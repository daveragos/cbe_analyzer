import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fl_chart/fl_chart.dart';

class AmountChart extends StatelessWidget {
  final List<SmsMessage> messages;

  const AmountChart({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'My CBE Account Balance History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: true),
                      lineBarsData: _generateLineBarsData(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBarsData() {
    return [
      LineChartBarData(
        spots: _generateSpots(),
        isCurved: true,
        color: Colors.blue,
        barWidth: 2,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    for (int i = 0; i < messages.length; i++) {
      final double? value = _extractAmount(messages[i].body!);
      if (value != null) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    return spots;
  }

  double? _extractAmount(String body) {
    final RegExp regex =
        RegExp(r'Your Current Balance is ETB ([0-9]+\.[0-9]+)\.');
    final match = regex.firstMatch(body);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return null; // Return null if no match found
  }
}
