import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingamount;
  final double spendingPctOfTotal;
  ChartBar(this.lable, this.spendingamount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contrain) {
        return Column(
          children: <Widget>[
            Container(
              height: contrain.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${spendingamount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: contrain.maxHeight * 0.05,
            ),
            Container(
              height: contrain.maxHeight * 0.6,
              width: 10,
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: contrain.maxHeight * 0.05,
            ),
            Container(
              height: contrain.maxHeight * 0.15,
              child: FittedBox(
                child: Text(lable,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        );
      },
    );
  }
}
