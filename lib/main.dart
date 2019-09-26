import 'package:flutter/material.dart';

import './widget/chart.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenss',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String titleInput, noteDetailInput, amountInput;

  final List<Transaction> _transactionList = [
    /*Transaction(
        id: '1',
        title: 'Demo title',
        notes: 'Demo notes',
        dateTime: DateTime.now(),
        amount: 23.45),*/
  ];
  List<Transaction> get _recentTransactions {
    return _transactionList.where((transaction) {
      return transaction.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

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
  } // _addNewTransaction

  void addNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  } // addNewTransactionSheet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Expenses",
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addNewTransactionSheet(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // CHART Container
            Chart(_recentTransactions),
            TransactionList(_transactionList),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addNewTransactionSheet(context),
      ),
    );
  }
}
