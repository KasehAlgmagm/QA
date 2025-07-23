import 'package:flutter_application_6/prodact/prodact.dart';

class ContainerItem {
  final String id; // معرف الكونتينر
  final String type; // نوع الكونتينر
  final List<Product> products;
  bool isSelected; // متغير لتحديد حالة الكونتينر
  // قائمة المنتجات المرتبطة بالكونتينر

  ContainerItem({
    required this.id,
    required this.type,
    required this.products,
    this.isSelected = false, // تمرير قائمة المنتجات
  });
}
