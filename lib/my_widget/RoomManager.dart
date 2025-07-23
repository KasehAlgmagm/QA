import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class RoomManager {
  static final RoomManager _instance = RoomManager._internal();
  List<StorageRoom> mainRooms = [];

  factory RoomManager() {
    return _instance;
  }

  RoomManager._internal();
}
