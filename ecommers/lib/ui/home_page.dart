import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).homePageTitle),
      ),
      body: Column(
        children: <Widget>[
          CategoriesCompactWidget(),
          ProductItem(
            assetImagePath: BACKPACK_IMAGE,
            cost: 5.00,
            title: 'SOME TITLE',
            type: ProductItemType.normal,
          ),
          SizedBox.fromSize(
            size: Size(10, 10),
          ),
          ProductItem(
            assetImagePath: SCARF_IMAGE,
            cost: 25.99990,
            title: 'Small Title',
            type: ProductItemType.small,
          ),
          SizedBox.fromSize(
            size: Size(10, 10),
          ),
          ProductItem(
            assetImagePath: SHIRT_IMAGE,
            cost: 100,
            title: 'Wide Title',
            rate: '5.1',
            type: ProductItemType.wide,
          ),
        ],
      ),
    );
  }
}
