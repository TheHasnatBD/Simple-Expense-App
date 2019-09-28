import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'No expenses are here.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constrains.maxHeight * 0.60,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
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
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: FittedBox(
                          child: Text(transactions[index].amount.toString())),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  //isThreeLine: true,
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          deleteTransactionHandler(transactions[index].id)),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].dateTime),
                    //style: Theme.of(context).textTheme.title,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
