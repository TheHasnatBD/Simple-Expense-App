import 'dart:io';

import 'package:expense_app/widget/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler) {
    print('constructor() => NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState() => NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditingController = TextEditingController();
  final _noteEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('constructor ==> ==> NewTransaction Widget');
  }

  @override
  void initState() {
    print('initState() => NewTransaction Widget');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget() => NewTransaction Widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose() => NewTransaction Widget');
    super.dispose();
  }

  void _submitTransaction() {
    final title = _titleEditingController.text;
    final notes = _noteEditingController.text;
    final amountInput = _amountEditingController.text;
    if (amountInput.isEmpty) {
      return;
    }
    final amount = double.parse(amountInput);

    if (title.isEmpty || _selectedDate == null || amount <= 0) {
      return;
    } else {
      widget.addTransactionHandler(
        title,
        notes,
        _selectedDate,
        amount,
      );
      Navigator.of(context).pop();
    }
  }

  void _showDatePickerPopUp() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(3),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleEditingController,
                onSubmitted: (_) => _submitTransaction,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountEditingController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Detail'),
                controller: _noteEditingController,
                onSubmitted: (_) => _submitTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No date choosen."
                            : DateFormat.yMMMMd().format(_selectedDate),
                      ),
                    ),
                    AdaptiveFlatButton("Choose Date", _showDatePickerPopUp),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      color: Theme.of(context).primaryColor,
                      child: const Text("Add Transcation"),
                      onPressed: _submitTransaction)
                  : RaisedButton(
                      onPressed: _submitTransaction,
                      child: const Text("Add Transcation"),
                      textColor: Theme.of(context).textTheme.button.color,
                      color: Theme.of(context).primaryColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
