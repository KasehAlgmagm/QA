import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Category/Category1.dart';
import 'package:flutter_application_6/Category/Category2.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/Container/Container1.dart';
import 'package:flutter_application_6/my_widget/RoomComparer1.dart';
import 'package:flutter_application_6/navication/NotifactionModl.dart';
import 'package:flutter_application_6/prodact/prodact.dart';
//import 'package:flutter_application_6/storageRoom/StorageRoomScreen%20.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();

  getNotifications() {}
}

List<NotificationModel> notifications = [
  NotificationModel(
    message: "رسالة 1",
    type: "NST",
    storageRoom: StorageRoom(
      id: '1',
      name: "غرفة 1",
      temperature: 22.5,
      humidity: 45.0,
      containers: [
        ContainerItem(
          id: "C1",
          type: "نوع A",
          products: [
            Product(name: "منتج 1", quantity: 10),
            Product(name: "منتج 2", quantity: 5),
          ],
        ),
        ContainerItem(
          id: "C2",
          type: "نوع B",
          products: [Product(name: "منتج 3", quantity: 8)],
        ),
      ],
    ),
  ),
  NotificationModel(
    message: "رسالة 2",
    type: "NDC",
    containers: [
      ContainerItem(
        id: "كونتينر 3",
        type: "نوع 3",
        products: [Product(name: "منتج E", quantity: 4)],
      ),
      ContainerItem(
        id: "كونتينر 4",
        type: "نوع 4",
        products: [Product(name: "منتج F", quantity: 6)],
      ),
    ],
  ),
];
int getNotificationCount() {
  return notifications.length; // إرجاع عدد الإشعارات
}

class _NotificationListState extends State<NotificationList> {
  List<Category> categories =
      Category2.categories; // الوصول إلى الفئات من Category2

  void _acceptNotification(int index) {
    final notification = notifications[index];

    if (notification.type == "NST" && notification.storageRoom != null) {
      final room = notification.storageRoom!;
      final containersT = room.containers;

      // الحصول على الكونتينرات الخاصة بالغرفة
      print("Notification room ID: ${room.id}");
      print("Notification room name: ${room.name}");
      print("Containers in room: ${containersT.length}");

      // تحديد الفئة المناسبة
      final category = categories.firstWhere(
        (cat) => cat.storageRooms.any((r) => r.id == room.id),
        orElse:
            () =>
                throw Exception(
                  "No matching category found for room ID: ${room.id}",
                ),
      );
      // category.containers.addAll(containersT);
      // room.containers.clear();

      print(
        "Rooms in category: ${category.storageRooms.map((r) => r.name).toList()}",
      );

      // توجيه المستخدم إلى شاشة ContainerScreen مباشرة
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ContainerScreen(
                category: category,
                room: room,
                containers: containersT,
              ),
        ),
      );

      setState(() {
        notifications[index].isAccepted = true;
      });

      print("hello");
      setState(() {
        notifications.removeAt(index); // حذف الرسالة من القائمة
      });
    } else if (notification.type == "NDC") {
      // عند تلقي إشعار من نوع NDC، إنشاء غرفة افتراضية
      List<ContainerItem> allContainers =
          notification.containers ?? []; // اجمع الكونتينرات من الإشعار

      // إنشاء غرفة افتراضية
      StorageRoom virtualRoom = StorageRoom(
        id: 'virtual_room', // معرف الغرفة الافتراضية
        name: 'شاحنات النقل',
        temperature: 20.0, // يمكنك وضع قيمة افتراضية
        humidity: 50.0, // يمكنك وضع قيمة افتراضية
        containers: allContainers,
      );

      // توجيه المستخدم إلى شاشة ContainerScreen مع الغرفة الافتراضية
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ContainerScreen(
                category: categories.first, // استخدم أي فئة مناسبة
                room: virtualRoom,
                containers: allContainers, // تمرير جميع الكونتينرات
              ),
        ),
      );

      setState(() {
        notifications[index].isAccepted = true;
        // يمكنك حذف الإشعار إذا كان ذلك مطلوبًا
        // notifications.removeAt(index);
      });
    }
  }

  void _rejectNotification(int index) {
    setState(() {
      notifications.removeAt(index); // حذف الرسالة من القائمة
    });
    print("تم رفض الرسالة"); // طباعة رسالة لتأكيد الرفض
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 58, 130, 188),
              width: 5,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Text(
                notification.message,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              if (notification.type == "NST" &&
                  notification.storageRoom != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "غرفة التخزين: ${notification.storageRoom!.name}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "temperature: ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "${notification.storageRoom?.temperature ?? 'غير متوفر'}°C",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ), // اللون الأحمر
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Degree of humidity: ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "${notification.storageRoom?.humidity ?? 'غير متوفر'}%",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ), // اللون الأحمر
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (notification.type == "NDC" && notification.containers != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "مجموعة الكونتينرات:",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    ...notification.containers!.map(
                      (container) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: ${container.id}, نوع: ${container.type}",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.greenAccent),
                    onPressed: () => _acceptNotification(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),

                    onPressed: () => _rejectNotification(index),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
