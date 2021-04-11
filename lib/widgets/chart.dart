import 'package:expense_monitor/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'chartBars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      num totalSum = 0;

      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].transactionDate.day == weekDay.day &&
            _recentTransactions[i].transactionDate.month == weekDay.month &&
            _recentTransactions[i].transactionDate.year == weekDay.year) {
          totalSum += _recentTransactions[i].transactionAmt;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  num get totalSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        child: Row(
          children: groupedTransactionValues.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: item["day"],
                spendingAmount: item["amount"],
                spendingPercOfTotal: totalSpending != 0
                    ? ((item["amount"] as num) / totalSpending)
                    : 0.0,
              ),
            );
          }).toList(),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        padding: EdgeInsets.all(15),
      ),
    );
  }
}
