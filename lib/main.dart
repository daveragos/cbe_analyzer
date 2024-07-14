import 'package:cbe_analyzer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermission(); // Request permission when the app starts
  runApp(const MainApp());
}

Future<void> _requestPermission() async {
  print("Requesting permission...");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? hasPermission = prefs.getBool('hasPermission');

  if (hasPermission == null || !hasPermission) {
    final permissionStatus = await Permission.sms.request();
    if (permissionStatus.isGranted) {
      print("Permission granted.");
      await prefs.setBool('hasPermission', true);
    } else {
      print("Permission denied.");
    }
  } else {
    print("Permission already granted.");
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
