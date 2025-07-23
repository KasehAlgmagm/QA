import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/Container/Container1.dart';

class StorageRoomScreen extends StatelessWidget {
  final Category category;

  StorageRoomScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: category.storageRooms.length,
          itemBuilder: (context, index) {
            final room = category.storageRooms[index];
            return GestureDetector(
              onTap: () {
                // تأكد من أن قائمة الكونتينرات تحتوي على النوع الصحيح
                final containers =
                    (room.containers as List<ContainerItem>?) ??
                    []; // استخدم قائمة فارغة إذا كانت null
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ContainerScreen(
                          room: room,
                          containers: containers,
                          category: category,
                        ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('معرف الغرفة: ${room.id}'),
                      Text('درجة الحرارة: ${room.temperature} °C'),
                      Text('درجة الرطوبة: ${room.humidity} %'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
