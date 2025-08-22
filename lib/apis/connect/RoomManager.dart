import 'package:flutter_application_6/apis/show_storage_elements_on_section.dart';
import 'package:flutter_application_6/static_classes/show_storage_elements_on_section_data.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class RoomManager {
  List<StorageRoom> storagRoom = []; // قائمة لتخزين الغرف

  /// دالة لجلب الغرف من API وتخزينها في قائمة
  Future<void> loadRooms(int sectionId) async {
    ShowStorageElementsOnSection storageElements = ShowStorageElementsOnSection();
    
    // استدعاء الدالة لجلب العناصر
    await storageElements.showStorageElementsOnSectionMethod(sectionId: sectionId);

    // تحويل البيانات من الخريطة إلى قائمة من الغرف
    storagRoom = ShowStorageElementsOnSectionData.showStorageElementsOnSectionMap.entries
        .map((entry) => StorageRoom.fromJson(entry.value as Map<String, dynamic>))
        .toList();
  }
}