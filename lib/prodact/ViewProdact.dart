import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/prodact/prodact.dart';

class Viewprodact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("عرض المنتجات"),
          backgroundColor: Colors.lightBlue,
        ),
        body: ProductList(
          products: [
            Product(
              name: "منتج 1",
              quantity: 10,
              // category: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 2",
              quantity: 5,
              // category: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 3",
              quantity: 20,
              //: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 4",
              quantity: 25,
              //category: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 5",
              quantity: 30,
              //category: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 6",
              quantity: 35,
              //  category: Category(name: 'B', number: 2),
            ),
            Product(
              name: "منتج 7",
              quantity: 40,
              //category: Category(name: 'B', number: 2),
            ),
          ],
        ),
      ),
    );
  }
}
