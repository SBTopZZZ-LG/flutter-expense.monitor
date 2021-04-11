import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  String dateToString(String date) {
    String reformatted;
    //As 14/03/2002 to "14th of "
    reformatted = "${int.parse(date.split("-")[0]).toString()}${[
      "th",
      "st",
      "nd",
      "rd",
      "th"
    ][int.parse(date.split("-")[0][date.split("-")[0].length - 1]) > 4 ? 4 : date.split("-")[0][date.length - 1] as int]} of ";
    //As "14th of " to "14th of March, 2002"
    reformatted += [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December"
        ][int.parse(date.split("-")[1]) - 1] +
        ", ${date.split("-")[2]}";

    return reformatted;
  }

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.length > 0
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Transaction obj = _transactions[index];
                return Card(
                  child: ListTile(
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red.shade800,
                          onPressed: () => _deleteTransaction(obj.getId())),
                      title: Text(obj.transactionTitle,
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                          obj.transactionDate
                              .toString()
                              .split(" ")[0]
                              .split("-")
                              .reversed
                              .join("-"),
                          style: TextStyle(fontSize: 17)),
                      leading: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor)),
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  "₹ ${obj.transactionAmt.toString()}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            )),
                      )),
                );
                // Container(
                //   child: Card(
                //     child: Container(
                //       child: Row(
                //         children: [
                //           Container(
                //             child: Text(
                //               "₹ ${obj.transactionAmt}",
                //               style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Theme.of(context).primaryColor),
                //             ),
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //               color: Theme.of(context).primaryColor,
                //               width: 1,
                //             )),
                //             padding: EdgeInsets.all(10),
                //           ),
                //           Container(
                //             child: Column(
                //               children: [
                //                 Text(obj.transactionTitle,
                //                     style: TextStyle(
                //                         color: Colors.black,
                //                         fontSize: 17,
                //                         fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "${obj.transactionDate.toString().split(" ")[0].split("-").reversed.join("-")}",
                //                   style: TextStyle(
                //                     color: Colors.grey,
                //                     fontWeight: FontWeight.w100,
                //                   ),
                //                 ),
                //               ],
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //             ),
                //             margin: EdgeInsets.only(left: 10, right: 10),
                //           ),
                //         ],
                //       ),
                //       margin: EdgeInsets.all(5),
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           border: Border(
                //               right: BorderSide(
                //                   color: Theme.of(context).primaryColor,
                //                   width: 2))),
                //     ),
                //   ),
                // )
              },
              itemCount: _transactions.length,
            )
          : Center(
              child: Column(
              children: [
                Text(
                  "No transactions added yet",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17),
                ),
                Container(
                  child: Image.asset(
                    "assets/images/zzz.png",
                    fit: BoxFit.scaleDown,
                    width: 100,
                    height: 100,
                  ),
                  margin: EdgeInsets.only(top: 10),
                )
              ],
            )),
      width: double.infinity,
      height: 300,
      margin: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
    );
  }
}
