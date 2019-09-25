import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../model/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactionList = [
    Transaction(
        id: '1',
        title: 'Demo title',
        notes: 'Demo notes',
        dateTime: DateTime.now(),
        amount: 23.45),
  ];

  void _addNewTransaction(String title, String notes, double amount) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        notes: notes,
        dateTime: DateTime.now(),
        amount: amount);

    setState(() {
      _transactionList.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactionList),
      ],
    );
  }
}
