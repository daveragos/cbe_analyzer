import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fl_chart/fl_chart.dart';

class AmountBarChart extends StatelessWidget {
  final List<SmsMessage> messages;

  const AmountBarChart({Key? key, required this.messages}) : super(key: key);

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
                'My CBE Account Balance History (Bar Chart)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _maxAmount(messages),
                      minY: 0,
                      groupsSpace: 12,
                      titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 10,
                              getTitlesWidget: (double value, meta) {
                                return Text(
                                  messages[value.toInt()].date!.day.toString() +
                                      "/" +
                                      messages[value.toInt()]
                                          .date!
                                          .month
                                          .toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                );
                              },
                              reservedSize: 30,
                              interval: (_maxAmount(messages) /
                                  5), // Customize y-axis labels interval
                            ),
                          )),
                      borderData: FlBorderData(show: true),
                      barGroups: _generateBarGroups(messages),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  double _maxAmount(List<SmsMessage> messages) {
    double maxAmount = 0;
    for (final message in messages) {
      final double? value = _extractAmount(message.body!);
      if (value != null && value > maxAmount) {
        maxAmount = value;
      }
    }
    return maxAmount;
  }

  List<BarChartGroupData> _generateBarGroups(List<SmsMessage> messages) {
    final List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < messages.length; i++) {
      final double? value = _extractAmount(messages[i].body!);
      if (value != null) {
        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [BarChartRodData(toY: value, color: Colors.blue)],
          ),
        );
      }
    }
    return barGroups;
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
