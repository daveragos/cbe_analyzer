import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'sms_helper.dart';
import 'message_list_view.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<SmsMessage> _messages = [];
  List<String> _body = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Inbox Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: _messages.isNotEmpty
            ? MessagesListView(
                messages: _messages,
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
            _body = messages.map((e) => e.body).toList().cast<String>();
            _messages = messages;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
