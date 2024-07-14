import 'package:cbe_analyzer/models/transactions.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

List<Transaction> parseSms(List<SmsMessage> sms) {
  List<Transaction> transactions = [];
  for (SmsMessage smsMessage in sms) {
    final regex =
        RegExp(r'debited with ETB (\d+\.\d{2}).*Balance is ETB (\d+\.\d{2})');
    final match = regex.firstMatch(smsMessage.body!);
    if (match != null) {
      final amount = double.parse(match.group(1)!);
      final balance = double.parse(match.group(2)!);
      final date = smsMessage.date;
      transactions.add(Transaction(date!, balance, amount));
    }
  }
  return transactions;
}
