import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/widgets/category_item/category_item.dart';
import 'package:ecommers/ui/widgets/image_card.dart';
import 'package:ecommers/ui/widgets/index.dart';
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
          children: <Widget>[
            ImageCard(
              buttonText: 'SEE MORE',
              description: 'For all your summer clothing needs',
              imageAsset: GIRL_IMAGE,
            ),
            PrimaryButtonWidget(
              assetIcon: ARROW_RIGHT_ICON,
              onPressedFunction: () {},
              text: 'SIGN IN',
            ),
            SecondaryButtonWidget(
              assetIcon: SHARE_ARROW_ICON,
              onPressedFunction: () {},
              text: 'SHARE THIS',
            ),
          ],
        ),
      ),
    );
  }
}
