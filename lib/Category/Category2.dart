import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Category/Category1.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/Logine.dart';
import 'package:flutter_application_6/apis/log_out_user.dart';
import 'package:flutter_application_6/my_widget/RoomManager.dart';
import 'package:flutter_application_6/prodact/prodact.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _getValue({required String key}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

class Category2 extends StatefulWidget {
  static final List<Category> categories = [
    Category(
      name: 'القسم 1',
      number: 1,
      storageRooms: [
        StorageRoom(
          id: '1',
          name: 'غرفة 1',
          temperature: 22.5,
          humidity: 45.0,
          containers: [
            ContainerItem(
              id: 'C1',
              type: 'نوع A',
              products: [
                Product(
                  name: 'منتج 1',
                  quantity: 10,
                  // category: Category(name: 'A', number: 1),
                ),
                Product(
                  name: 'منتج 2',
                  quantity: 5,
                  // category: Category(name: 'A', number: 1),
                ),
              ],
            ),
            ContainerItem(
              id: 'C2',
              type: 'نوع B',
              products: [
                Product(
                  name: 'منتج 3',
                  quantity: 8,
                  // category: Category(name: 'A', number: 1),
                ),
              ],
            ),
          ],
        ),
        StorageRoom(
          id: '2',
          name: 'غرفة 2',
          temperature: 22.5,
          humidity: 45.0,
          containers: [
            ContainerItem(
              id: 'C3',
              type: 'نوع A',
              products: [
                Product(
                  name: 'منتج 1',
                  quantity: 10,
                  // category: Category(name: 'A', number: 1),
                ),
                Product(
                  name: 'منتج 2',
                  quantity: 5,
                  // category: Category(name: 'A', number: 1),
                ),
              ],
            ),
            ContainerItem(
              id: 'C4',
              type: 'نوع B',
              products: [
                Product(
                  name: 'منتج 3',
                  quantity: 8,
                  // category: Category(name: 'A', number: 1),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    // يمكنك إضافة أقسام أخرى هنا
  ];

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

  late RoomManager roomManager;
  List<StorageRoom> mainRooms = [];
  @override
  void initState() {
    super.initState();
    roomManager = RoomManager(); // إنشاء كائن RoomManager

    populateMainRooms(); // تأكد من أن هذه السطر موجود

    print("Main rooms populated1: ${roomManager.mainRooms.length}");
  }

  void populateMainRooms() {
    for (var category in Category2.categories) {
      roomManager.mainRooms.addAll(category.storageRooms);
    }
    print(
      "Main rooms populated: ${roomManager.mainRooms.length}",
    ); // طباعة عدد الغرف
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
          child: CategoryList(categories: Category2.categories),
        ),
      ),
    );
  }
}
