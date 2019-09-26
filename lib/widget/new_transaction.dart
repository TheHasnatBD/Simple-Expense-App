import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleEditingController = TextEditingController();
  final noteEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  void submitTransaction() {
    final title = titleEditingController.text;
    final notes = noteEditingController.text;
    final amount = double.parse(amountEditingController.text);

    if (title.isEmpty || notes.isEmpty || amount <= 0) {
      return;
    } else {
      widget.addTransactionHandler(title, notes, amount);
      Navigator.of(context).pop();
    }
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
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleEditingController,
              onSubmitted: (_) => submitTransaction,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountEditingController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Detail'),
              controller: noteEditingController,
              onSubmitted: (_) => submitTransaction(),
            ),
            FlatButton(
                onPressed: submitTransaction,
                child: Text(
                  "Add Transcation",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
