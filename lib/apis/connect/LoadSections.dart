import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/apis/show_sections_on_place.dart';
import 'package:flutter_application_6/static_classes/show_sections_on_place_data.dart';

class LoadSections {
  List<Category> categories = []; // مصفوفة لتخزين جميع الأقسام

  Future<void> loadAllSections() async {
    ShowSectionsOnPlace showSections = ShowSectionsOnPlace();

    // جلب جميع الأقسام
    await showSections.showSectionsOnPlaceMethod();

    // استرجاع الأقسام من البيانات
    var data = ShowSectionsOnPlaceData.showSectionsOnPlaceMap;

    // تأكد من أن البيانات هي خريطة
    if (data is Map) {
      // استخدام values لتحويل الخريطة إلى قائمة
      categories =
          data.values
              .map((item) => Category.fromJson(item as Map<String, dynamic>))
              .toList();
    } else {
      print('البيانات غير صحيحة.'); // يمكنك معالجة البيانات هنا
    }
  }
}
