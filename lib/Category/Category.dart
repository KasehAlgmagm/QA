import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class Category {
  final String name;
  final int number;
  final List<StorageRoom> storageRooms;

  Category({
    required this.name,
    required this.number,
    List<StorageRoom>? storageRooms,
  }) : storageRooms = storageRooms ?? []; // تأكد من أن القيمة ليست null
}
