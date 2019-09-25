import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransactionHandler;
  final titleEditingController = TextEditingController();
  final noteEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  NewTransaction(this.addTransactionHandler);

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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountEditingController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Detail'),
              controller: noteEditingController,
            ),
            FlatButton(
                onPressed: () {
                  addTransactionHandler(
                    titleEditingController.text,
                    noteEditingController.text,
                    double.parse(amountEditingController.text),
                  );
                },
                child: Text(
                  "Add Transcation",
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}
