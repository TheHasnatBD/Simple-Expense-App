import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransactionHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color avatarBgColor;

  @override
  void initState() {
    const avatarColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.deepPurple,
      Colors.black,
      Colors.deepOrange,
      Colors.cyan,
    ];
    avatarBgColor = avatarColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        /*
          //Custom circle avatar

          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: FittedBox(
                  child: Text(transactions[index].amount.toString())),
            ),
          ),*/
        leading: CircleAvatar(
          backgroundColor: avatarBgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: FittedBox(child: Text(widget.transaction.amount.toString())),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        //isThreeLine: true,

        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deleteTransactionHandler(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deleteTransactionHandler(widget.transaction.id)),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.dateTime),
          //style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
