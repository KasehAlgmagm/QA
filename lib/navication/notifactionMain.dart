import 'package:flutter/material.dart';
import 'package:flutter_application_6/navication/Naviction.dart';

class Notifactionmain1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("الإشعارات"),
          backgroundColor: Colors.lightBlue,
        ),

        body: NotificationList(),
      ),
    );
  }
}
