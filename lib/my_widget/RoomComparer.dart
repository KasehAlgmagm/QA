import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class RoomComparer {
  final Category category;

  RoomComparer(this.category);

  // دالة للمقارنة بين غرفة مدخلة والغرف الموجودة
  StorageRoom? compareRoom(StorageRoom inputRoom) {
    for (var room in category.storageRooms) {
      print("Comparing with room: ${room.name} (ID: ${room.id})");

      if (room.id == inputRoom.id) {
        return room; // إرجاع الغرفة المطابقة
      }
    }
    return null; // لا توجد غرفة مطابقة
  }

  // دالة للحصول على جميع الغرف في نفس القسم
  List<StorageRoom> getRoomsInSameCategory(StorageRoom inputRoom) {
    return category.storageRooms; // إرجاع جميع الغرف في نفس الفئة
  }
}
