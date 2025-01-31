import 'package:expence_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart.dart';

class Chart extends StatelessWidget {
  //chart of transaction
  final List<transaction> recentTransaction;
  const Chart(this.recentTransaction, {super.key});
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        var totalSum = 0.0;
        for (var i = 0; i < recentTransaction.length; i++) {
  
          if (recentTransaction[i].date.day == weekDay.day &&
              recentTransaction[i].date.month == weekDay.month &&
              recentTransaction[i].date.year == weekDay.year) {
            totalSum += recentTransaction[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 6,
        margin:  EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              //feeling the space of the folder
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  (data['day']as String),
                (data['amount']as double),
                    totalSpending==0.0?0.0:(data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      
    );
  }
}
