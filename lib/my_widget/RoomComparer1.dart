import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Container/Container.dart';

class RoomComparer1 {
  final List<Category> categories;

  RoomComparer1(this.categories);

  List<ContainerItem> getAllContainers() {
    List<ContainerItem> allContainers = [];

    for (var category in categories) {
      for (var room in category.storageRooms) {
        if (room.containers != null) {
          allContainers.addAll(room.containers!);
        } else {
          print("room.containers==null");
        }
      }
    }

    return allContainers;
  }
}
