import 'package:flutter/material.dart';

import './widget/chart.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import 'model/transaction.dart';

void main() {
  /*
  // forced to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenss',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
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
  bool _showChart = false;
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

  void _addNewTransaction(
      String title, String notes, DateTime selectedDate, double amount) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        notes: notes,
        dateTime: selectedDate,
        amount: amount);

    setState(() {
      _transactionList.add(transaction);
    });
  } // _addNewTransaction

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

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
    final appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // CHART Container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('View chart'),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        70,
                    child: Chart(_recentTransactions),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.70,
                    child:
                        TransactionList(_transactionList, _deleteTransaction),
                  ),
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
