import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/Container/Container1.dart';
import 'package:flutter_application_6/apis/connect/RoomManager.dart';

class StorageRoomScreen extends StatefulWidget {
  final Category category;

  StorageRoomScreen({required this.category});

  @override
  _StorageRoomScreenState createState() => _StorageRoomScreenState();
}

class _StorageRoomScreenState extends State<StorageRoomScreen> {
  RoomManager roomManager = RoomManager();

  @override
  void initState() {
    super.initState();
    roomManager.loadRooms(widget.category.number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name), // استخدم widget للوصول إلى الفئة
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
          itemCount: roomManager.storagRoom.length, // استخدم widget هنا
          itemBuilder: (context, index) {
            final room = roomManager.storagRoom[index]; // استخدم widget
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ContainerScreen(
                          storageRoom: room,
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
