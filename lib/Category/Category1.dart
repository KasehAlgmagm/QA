import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen%20.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // الانتقال إلى شاشة غرف التخزين عند الضغط على القسم
            Navigator.push(
              context,
              MaterialPageRoute(
                
                builder: (context) => StorageRoomScreen(category: category),
              ),
            );
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 4), // خط أزرق
              borderRadius: BorderRadius.circular(8.0), // زوايا مستديرة
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${category.number}', // عرض الرقم بجانب الاسم
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
