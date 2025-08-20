import 'dart:async'; // استيراد المكتبة

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category2.dart';
//import 'package:flutter_application_6/prodact/ViewProdact.dart';
import 'package:flutter_application_6/navication/Naviction.dart';
import 'package:flutter_application_6/navication/notifactionMain.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Timer? _timer; // تعريف المتغير Timer

  int get _notificationCount => getNotificationCount();
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // هنا يمكنك تحديث العدد أو إجراء عمليات أخرى
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // إلغاء الـ Timer عند إغلاق الصفحة
    super.dispose();
  }

  List<Widget> listWidget = [const Category2(), Notifactionmain1()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.blue,
        items: <Widget>[
          Icon(Icons.home, size: size.width / 12, color: Colors.white),
          Stack(
            children: [
              Icon(Icons.list, size: size.width / 12, color: Colors.white),
              if (_notificationCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '$_notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ), // Icon(Icons.compare_arrows,size: size.width/12,color:Theme.of(context).primaryColor),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(child: listWidget.elementAt(_page)),
    );
  }
}
