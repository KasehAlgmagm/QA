import 'package:flutter/material.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class SelectRoomScreen extends StatelessWidget {
  final List<StorageRoom> availableRooms;
  final ContainerItem containerItem;

  SelectRoomScreen({required this.availableRooms, required this.containerItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر غرفة لنقل الكونتينر'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: availableRooms.length,
              itemBuilder: (context, index) {
                final room = availableRooms[index];
                return ListTile(
                  title: Text(room.name),
                  onTap: () {
                    _showConfirmationDialog(context, room);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, StorageRoom room) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تأكيد النقل'),
          content: Text('هل ترغب في نقل الكونتينر إلى ${room.name}؟'),
          actions: [
            TextButton(
              onPressed: () {
                // فحص ما إذا كانت الغرفة هي نفس الغرفة الحالية
                if (room.id == containerItem.id) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('عذرا لا يمكنك النقل لنفس الغرفه'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // هنا يجب إضافة منطق لنقل الكونتينر
                  Navigator.pop(context); // إغلاق الحوار
                  // هنا يمكنك إضافة الكود لنقل الكونتينر
                }
              },
              child: Text('تمام'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الحوار
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }
}
