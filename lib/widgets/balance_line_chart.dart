import 'package:cbe_analyzer/models/transactions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BalanceLineChart extends StatelessWidget {
  final List<Transaction> transactions;

  BalanceLineChart({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: transactions
                .map((t) =>
                    FlSpot(t.date.millisecondsSinceEpoch.toDouble(), t.balance))
                .toList(),
          ),
        ],
      ),
    );
  }
}
