import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

double? extractAmount(String body, String bank) {
  Map<String, RegExp> bankRegex = {
    'CBE': RegExp(r'Your Current Balance is ETB (\d+\.\d{2})'),
    'CBEBirr': RegExp(r'Your CBEBirr account balance is (\d+\.\d{2})Br'),
    'Awash Bank': RegExp(r'Your balance now is ETB (\d+\.\d{2})'),
    'BOA': RegExp(r'The available balance in the account is ETB (\d+\.\d{2})'),
  };
  if (bankRegex.containsKey(bank)) {
    final match = bankRegex[bank]!.firstMatch(body);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
  }
  return null;
}

Future<List<SmsMessage>> fetchSmsMessages({required String bank}) async {
  var permission = await Permission.sms.status;
  if (permission.isGranted) {
    SmsQuery _query = SmsQuery();
    final messages = await _query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        // SmsQueryKind.sent,
      ],
      address: bank,
      // count: 10,
    );
    print('##############################################');
    print('Fetched ${messages.length} messages from $bank');
    print('First message: ${messages.first.body}');
    print('Last message: ${messages.last.body}');
    return messages.reversed.toList();
  } else {
    await Permission.sms.request();
    return [];
  }
}
