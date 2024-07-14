import 'package:cbe_analyzer/models/transactions.dart';
import 'package:cbe_analyzer/services/sms_services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyDebitsBarChart extends StatelessWidget {
  final List<Transaction> transactions;

  MonthlyDebitsBarChart(this.transactions);

  @override
  Widget build(BuildContext context) {
    final monthlyDebits = getMonthlyDebits(transactions);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: monthlyDebits.entries.map((entry) {
          return BarChartGroupData(
            x: int.parse(entry.key.replaceAll("-", "")),
            barRods: [
              BarChartRodData(
                fromY: entry.value,
                color: Colors.blue,
                toY: entry.value,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
