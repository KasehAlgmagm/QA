import 'package:flutter_application_6/apis/show_containers_on_storage_element.dart';
import 'package:flutter_application_6/static_classes/show_containers_on_storage_element_data.dart';

class ContainerManager {
  List<dynamic> containers = []; // قائمة لتخزين الحاويات

  /// دالة لجلب الحاويات من API وتخزينها في قائمة
  Future<void> loadContainers(int storageElementId) async {
    ShowContainersOnStorageElement showContainers = ShowContainersOnStorageElement();

    // استدعاء الدالة لجلب الحاويات
    await showContainers.showContainersOnStorageElementMethod(storageElementId: storageElementId);

    // تحويل البيانات من الخريطة إلى قائمة من الحاويات
    containers = ShowContainersOnStorageElementData.showContainersOnStorageElementMap.entries
        .map((entry) => entry.value) // افترض أن entry.value هو العنصر المطلوب
        .toList();
  }
}