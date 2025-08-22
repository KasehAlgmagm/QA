import 'package:flutter_application_6/apis/show_container_details.dart';
import 'package:flutter_application_6/product/prodact.dart';
import 'package:flutter_application_6/static_classes/show_container_details_data.dart';

class ProductManager {
  List<Product> products = []; // قائمة لتخزين المنتجات

  /// دالة لجلب المنتجات من API وتخزينها في قائمة
  Future<void> loadProducts(int loadId) async {
    ShowContainerDetails showContainerDetails = ShowContainerDetails();

    // استدعاء الدالة لجلب تفاصيل الحاوية
    await showContainerDetails.showContainerDetailsMethod(loadId: loadId);

    // تحويل البيانات من الخريطة إلى قائمة من المنتجات
    products =
        ShowContainerDetailsData.showContainerDetailsMap['products'] ?? [];
  }
}
