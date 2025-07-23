//import 'package:flutter/material.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class NotificationModel {
  final String message;
  bool isAccepted;
  final String type; // NST أو NDC
  final StorageRoom? storageRoom; // معلومات غرفة التخزين (اختياري)
  final List<ContainerItem>? containers; // قائمة الكونتينرات (اختيارية)

  NotificationModel({
    required this.message,
    this.isAccepted = false,
    required this.type,
    this.storageRoom, // يمكن أن تكون فارغة
    this.containers, // يمكن أن تكون فارغة
  });
}
