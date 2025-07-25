import 'package:flutter_application_6/Container/Container.dart';

class StorageRoom {
  final String id; // معرف الغرفة
  final String name; // اسم الغرفة
  final double temperature; // درجة الحرارة
  final double humidity; // درجة الرطوبة
  final List<ContainerItem> containers; // قائمة الكونتينرات

  StorageRoom({
    required this.id,
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.containers, // تمرير قائمة الكونتينرات
  });
}
