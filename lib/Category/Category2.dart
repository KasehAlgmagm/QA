import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Category/Category1.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/my_widget/RoomManager.dart';
import 'package:flutter_application_6/prodact/prodact.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

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
  @override
  _Category2State createState() => _Category2State();
}

class _Category2State extends State<Category2> {
  late RoomManager roomManager; // استخدام late للتهيئة اللاحقة

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
        appBar: AppBar(
          title: Text('عرض الأقسام'),
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
