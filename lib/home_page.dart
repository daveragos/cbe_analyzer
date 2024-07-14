// ignore_for_file: non_constant_identifier_names

import 'package:cbe_analyzer/models/transactions.dart';
import 'package:cbe_analyzer/widgets/balance_line_chart.dart';
import 'package:flutter/material.dart';
import 'services/sms_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _CBEmessages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages when the widget is initialized
  }

  Future<void> _fetchMessages() async {
    _CBEmessages = await fetchSmsMessages(bank: 'CBE');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(text: 'CBE'),
          ],
        ),
        title: const Text('CBE Analyzer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BalanceLineChart(transactions: _CBEmessages),
          ),
        ],
      ),
    );
  }
}

/*
class BankChart extends StatelessWidget {
  const BankChart({
    super.key,
    required List<SmsMessage> messages,
  }) : _messages = messages;

  final List<SmsMessage> _messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: _messages.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Expanded(
                //   child: AmountBarChart(messages: _messages),
                // ),
                Expanded(
                  child: AmountChart(
                      messages: _messages, bank: _messages[0].address!),
                ),
              ],
            )
          : Center(
              child: Text(
                'No messages to show.\n Tap refresh button...',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
*/


/* 
Container(
          padding: const EdgeInsets.all(10.0),
          child: _messages.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Expanded(
                    //   child: AmountBarChart(messages: _messages),
                    // ),
                    Expanded(
                      child: AmountChart(messages: _messages),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'No messages to show.\n Tap refresh button...',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
        )
*/
