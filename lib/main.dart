import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/ltransaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UangKeluarKu",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple, 
        accentColor: Colors.amber, 
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            caption: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Transaction> transaction = [];

  List<Transaction> get _recentTransaction {
    return transaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7))
        );
      }).toList();
  }

  void _addNewTranscation(String title, double amount, DateTime tanggalTerpilih) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: tanggalTerpilih);
    setState(() {
      transaction.add(newTx);
    });
  }

  void _removeItem(String id) {
    setState(() { 
      transaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet<void>(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTranscation));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uang Keluar"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _showModal(context))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Chart(_recentTransaction),
                TransactionList(transaction,_removeItem),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.add),
          onPressed: () => _showModal(context)),
    );
  }
}
