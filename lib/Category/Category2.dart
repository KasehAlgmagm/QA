import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category1.dart';
import 'package:flutter_application_6/Logine.dart';
import 'package:flutter_application_6/apis/connect/LoadSections.dart';
import 'package:flutter_application_6/apis/log_out_user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Category2 extends StatefulWidget {
  const Category2({super.key});
  @override
  _Category2State createState() => _Category2State();
}

class _Category2State extends State<Category2> {
  LogOutUser logOut = LogOutUser();
  Future<void> _saveValue({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  LoadSections loadSections = LoadSections();
  @override
  void initState() {
    super.initState();
    loadSections.loadAllSections();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  logOut.logOutUser();
                  await _saveValue(key: 'token', value: '');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LogIn()),
                    (route) => false,
                  );
                },
                child: const Text('تسجيل الخروج'),
              ),
              // MaterialButton(
              //   onPressed: () async {
              //     //api test

              //     Markasread s = Markasread();
              //     await s.markasreadMethod(
              //       id: 'a2a21878-7e34-4aee-b298-066a4fc',
              //     );

              //     print('objecttttttttttt=${MarkasreadData.markasreadMap}');
              //   },
              //   child: const Text('click me'),
              // ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('عرض الأقسام'),
          backgroundColor: Colors.lightBlue,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CategoryList(categories: loadSections.categories),
        ),
      ),
    );
  }
}
