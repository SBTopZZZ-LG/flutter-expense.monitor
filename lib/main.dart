import 'dart:math';

import 'package:expense_monitor/newTransaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transactionList.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: "0",
    //     transactionTitle: "New Shoes",
    //     transactionAmt: 699,
    //     transactionDate: DateTime.now()),
    // Transaction(
    //     id: "1",
    //     transactionTitle: "Food",
    //     transactionAmt: 250,
    //     transactionDate: DateTime.now()),
    // Transaction(
    //     id: "2",
    //     transactionTitle: "Fueling",
    //     transactionAmt: 2000.50,
    //     transactionDate: DateTime.now()),
  ];

  String randomString({int length = 10}) {
    String allowedChars =
        "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    String randomString = "";
    for (int i = 0; i < length; i++)
      randomString += Random().nextInt(allowedChars.length - 1).toString();
    return randomString;
  }

  void _addNewTransaction(String title, num amount, DateTime dateTime) {
    final Transaction transaction = Transaction(
        id: randomString(),
        transactionTitle: title,
        transactionAmt: amount,
        transactionDate: dateTime);

    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((Transaction item) => item.id == id);
    });
  }

  void _showNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext _context) => GestureDetector(
              onTap: () {},
              child: NewTransaction(_addNewTransaction),
              behavior: HitTestBehavior.opaque,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green.shade500,
          fontFamily: 'LGC',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Expense Monitor"),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showNewTransactionSheet(context))
            ],
          ),
          body: Column(
            children: [
              // Card(
              //   child: Container(
              //     child: Text("Chart"),
              //     width: double.infinity,
              //     height: 150,
              //     margin: EdgeInsets.all(10),
              //     alignment: Alignment.topCenter,
              //   ),
              //   elevation: 5,
              //   margin: EdgeInsets.all(10),
              // ),
              Chart(_transactions.where((Transaction element) {
                return element.transactionDate
                    .isAfter(DateTime.now().subtract(Duration(
                  days: 7,
                )));
              }).toList()),
              Expanded(
                  child: TransactionList(_transactions, _deleteTransaction)),
              SizedBox(height: 50),
            ],
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButton: Builder(builder: (BuildContext context) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _showNewTransactionSheet(context),
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
