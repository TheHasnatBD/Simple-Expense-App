import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final String notes;
  final DateTime dateTime;
  final double amount;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.notes,
      @required this.dateTime,
      @required this.amount});
}
