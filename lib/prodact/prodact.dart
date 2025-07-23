import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';

class Product {
  final String name;
  int quantity;
  //final Category category; // تأكد من أن هذا من نوع Category

  Product({
    required this.name,
    required this.quantity,

    //required this.category
  });
}

class ProductList extends StatefulWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.products.length,
      (index) => TextEditingController(),
    );
  }

  void _decreaseQuantity(int index) {
    int? decrementValue = int.tryParse(
      _controllers[index].text,
    ); // تحويل النص إلى عدد صحيح
    if (decrementValue != null && decrementValue > 0) {
      setState(() {
        if (widget.products[index].quantity >= decrementValue) {
          widget.products[index].quantity -= decrementValue; // تنقيص العدد
        } else {
          // رسالة تنبيه إذا كان العدد المراد إنقاصه أكبر من المتاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'عدد المتاح أقل من القيمة المدخلة',
                style: TextStyle(fontSize: 17),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
      _controllers[index].clear(); // مسح المدخلات بعد التنقيص
    }
  }

  @override
  void dispose() {
    // تخلص من جميع controllers عند انتهاء الاستخدام
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,

      itemBuilder: (context, index) {
        final product = widget.products[index];
        return Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2), // خط أزرق
            borderRadius: BorderRadius.circular(8.0), // زوايا مستديرة
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'عدد المتاح: ${product.quantity}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(width: 8.0),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller:
                            _controllers[index], // استخدام controller الخاص بكل منتج
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                          //border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _decreaseQuantity(index), // تقليل العدد
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
