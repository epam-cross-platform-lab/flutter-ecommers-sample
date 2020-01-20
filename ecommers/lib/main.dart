import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/widgets/category_item/category_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ecomers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ecommers Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Categories.apparel,
            Categories.beauty,
            Categories.shoes,
            Categories.electronics,
            Categories.furniture,
            Categories.home,
            Categories.stationary
          ].map((category) => CategoryItem.fromType(category)).toList(),
        ),
      ),
    );
  }
}
