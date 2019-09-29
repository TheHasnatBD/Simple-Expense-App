import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import '../widget/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction) {
    print('Constructor() => Chart');
  }

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekAday = DateTime.now().subtract(Duration(
        days: index,
      ));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekAday.day &&
            recentTransaction[i].dateTime.month == weekAday.month &&
            recentTransaction[i].dateTime.year == weekAday.year) {
          totalSum = totalSum + recentTransaction[i].amount;
        }
      }

      print("${DateFormat.E().format(weekAday)} sum: $totalSum");
      return {
        'day': DateFormat.E().format(weekAday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() => Chart');

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // space around on chart bar
          children: groupedTransactionValue.map((data) {
            return Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
