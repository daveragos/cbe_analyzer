// ignore_for_file: non_constant_identifier_names

import 'package:cbe_analyzer/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'sms_helper.dart';
import 'amount_chart.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<SmsMessage> _CBEmessages = [];
  List<SmsMessage> _CBEBirrmessages = [];
  List<SmsMessage> _AwashBankmessages = [];
  List<SmsMessage> _BOAmessages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages when the widget is initialized
  }

  Future<void> _fetchMessages() async {
    _CBEmessages = await fetchSmsMessages(bank: 'CBE');
    _CBEBirrmessages = await fetchSmsMessages(bank: 'CBEBirr');
    _AwashBankmessages = await fetchSmsMessages(bank: 'Awash Bank');
    _BOAmessages = await fetchSmsMessages(bank: 'BOA');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'CBE'),
              Tab(text: 'CBEBirr'),
              Tab(text: 'AWASH'),
              Tab(text: 'BOA'),
            ],
          ),
          title: const Text('CBE Analyzer'),
        ),
        body: TabBarView(
          children: [
            BankChart(messages: _CBEmessages),
            BankChart(messages: _CBEBirrmessages),
            BankChart(messages: _AwashBankmessages),
            BankChart(messages: _BOAmessages),
          ],
        ),
      ),
    );
  }
}

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
