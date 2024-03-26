import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<SmsMessage>> fetchSmsMessages() async {
  var permission = await Permission.sms.status;
  if (permission.isGranted) {
    SmsQuery _query = SmsQuery();
    final messages = await _query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        // SmsQueryKind.sent,
      ],
      address: 'CBE',
      // count: 10,
    );
    return messages;
  } else {
    await Permission.sms.request();
    return [];
  }
}
