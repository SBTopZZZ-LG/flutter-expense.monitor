import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final num spendingAmount;
  final double spendingPercOfTotal;

  ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendingPercOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text("₹ ${spendingAmount.toString()}"),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              )),
              FractionallySizedBox(
                  heightFactor: spendingPercOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  )),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
