import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TranscationCard extends StatelessWidget {
  final double amount;
  final String title;
  final DateTime date;
  TranscationCard(
      {@required this.amount, @required this.title, @required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$' + amount.toStringAsFixed(2),
              style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
           
            children: <Widget>[
              Text(title.toString(),
                  style: Theme.of(context).textTheme.headline6),
              Text(DateFormat.yMMMd().format(date),
                  style: Theme.of(context).textTheme.caption),
            ],
          )
        ],
      ),
    );
  }
}
