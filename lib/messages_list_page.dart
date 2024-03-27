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
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages when the widget is initialized
  }

  Future<void> _fetchMessages() async {
    final messages = await fetchSmsMessages();
    debugPrint('sms inbox messages: ${messages.length}');
    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CBE Analyzer'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: _messages.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Expanded(
                  //   child: MessagesListView(messages: _messages),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final messages = await fetchSmsMessages();
          debugPrint('sms inbox messages: ${messages.length}');
          setState(() {
            _messages = messages;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
