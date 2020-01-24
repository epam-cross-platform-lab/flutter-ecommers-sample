import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Search"),
          ProductItemWide(
            assetImagePath: SHIRT_IMAGE,
            cost: 5,
            title: 'Wide Title',
            rate: 4,
          )],
      ),
    );
  }
}