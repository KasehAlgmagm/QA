import 'package:flutter/material.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/prodact/prodact.dart';

class ProductContainerScreen extends StatelessWidget {
  final ContainerItem containerItem;

  ProductContainerScreen({required this.containerItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(containerItem.type),
        backgroundColor: Colors.lightBlue,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ProductList(
              products: containerItem.products,
            ), // عرض قائمة المنتجات
          ),
          // لا يوجد زر "تحريك" هنا
        ],
      ),
    );
  }
}
