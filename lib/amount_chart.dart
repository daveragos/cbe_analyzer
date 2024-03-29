import 'package:cbe_analyzer/sms_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fl_chart/fl_chart.dart';

class AmountChart extends StatelessWidget {
  final List<SmsMessage> messages;
  final String bank;

  const AmountChart({super.key, required this.messages, required this.bank});

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
              Text(
                'My $bank Account Balance History',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.grey[400]!,
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            tooltipHorizontalAlignment:
                                FLHorizontalAlignment.center),
                      ),
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: true),
                      lineBarsData: _generateLineBarsData(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
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
        // belowBarData: BarAreaData(
        //   show: true,
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.green.withOpacity(0.7),
        //       Colors.red.withOpacity(0.7),
        //     ],
        //     stops: const [0.5, 1.0],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
      ),
    ];
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    for (int i = 0; i < messages.length; i++) {
      final double? value = extractAmount(messages[i].body!, bank);
      if (value != null) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    return spots;
  }
}
