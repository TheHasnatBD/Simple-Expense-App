import 'package:flutter/material.dart';

import '../model/transaction.dart';
import '../widget/transaction_tem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    print('build() => TransactionList');
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
                  const SizedBox(
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
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransactionHandler: deleteTransactionHandler,
                    ))
                .toList());
  }
}
