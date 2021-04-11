import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String transactionTitle;
  final num transactionAmt;
  final DateTime transactionDate;

  Transaction(
      {@required this.id,
      @required this.transactionTitle,
      @required this.transactionAmt,
      @required this.transactionDate});

  String getId() {
    return this.id;
  }
}
