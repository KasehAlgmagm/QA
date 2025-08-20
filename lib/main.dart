import 'package:flutter/material.dart';
import 'package:flutter_application_6/HomePage.dart';
import 'package:flutter_application_6/Logine.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter_application_6/Logine.dart';
Future<String?> _getValue({required String key}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? thereISToken = await _getValue(key: 'token');
  bool isRegistered =
      (thereISToken != null || thereISToken != '') ? true : false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isRegistered) ? const MyHomePage() : const LogIn(),
    ),
  );
}
