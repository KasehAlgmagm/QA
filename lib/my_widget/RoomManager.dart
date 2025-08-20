import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class RoomManager {
  static final RoomManager _instance = RoomManager._internal();
  List<StorageRoom> mainRooms = [];

  factory RoomManager() {
    return _instance;
  }

  RoomManager._internal();

  // إضافة غرفة جديدة

  // تعبئة mainRooms من الفئات

  // الحصول على غرفة بواسطة المعرف
  StorageRoom getRoomById(String roomId) {
    return mainRooms.firstWhere(
      (room) => room.id == roomId,
      orElse:
          () => StorageRoom(
            id: 'default_room', // معرف افتراضي
            name: 'غرفة افتراضية',
            temperature: 20.0,
            humidity: 50.0,
            containers: [],
          ),
    );
  }

  // الحصول على جميع الغرف
  List<StorageRoom> getAllRooms() {
    return mainRooms;
  }
}
