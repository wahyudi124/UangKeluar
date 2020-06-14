import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function tXHandler;
  NewTransaction(this.tXHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _dateSelected;

  void _submittedData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _dateSelected == null) {
      return null;
    }

    widget.tXHandler(title, amount, _dateSelected);

    Navigator.of(context).pop();
  }

  void _tampilDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _dateSelected = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                    ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    labelText: 'Title',
                    labelStyle: Theme.of(context).textTheme.caption),
                keyboardType: TextInputType.text,
                controller: titleController,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                    ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  labelText: 'Amount',
                  labelStyle: Theme.of(context).textTheme.caption,
                ),
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dateSelected == null
                          ? "Belum di pilih"
                          : 'Tanggal Terpilih : ${DateFormat.yMd().format(_dateSelected)}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  FlatButton(
                      onPressed: _tampilDatePicker,
                      child: Text(
                        "Pilih Tanggal",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: _submittedData,
              child: Text("Tambah Transaksi",
                  style: Theme.of(context).textTheme.button),
            )
          ],
        ),
      ),
    );
  }
}
