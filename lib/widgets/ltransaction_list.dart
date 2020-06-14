import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function removeItem;

  TransactionList(this.transaction, this.removeItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding: EdgeInsets.all(10),
        child: transaction.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Tidak Ada Transaksi",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                dragStartBehavior: DragStartBehavior.down,
                itemBuilder: (ctx, index) {
                  return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text('\$${transaction[index].amount}'),
                              ),
                            ),
                          ),
                          title: Text(
                            transaction[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(transaction[index].date),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          foregroundColor: Theme.of(context).primaryColor,
                          caption: 'Delete',
                          color: Colors.transparent,
                          icon: Icons.delete,
                          onTap: () {
                            removeItem(transaction[index].id);
                          },
                        )
                      ]);
                },
                itemCount: transaction.length,
              ));
  }
}
