import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widget/index.dart';
import 'package:flutter/material.dart';

class RecentlyViewedWidget extends StatelessWidget {
  final List<ProductItemSmallModel> recentlyViewedList = [
    ProductItemSmallModel(
      assetImagePath: Assets.scarfImage,
      title: 'Red Cotton Scarf',
      cost: 22.8,
      id: 1,
    ),
    ProductItemSmallModel(
      assetImagePath: Assets.blackShoes,
      title: 'Black shoes ',
      cost: 22.8,
      id: 0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: recentlyViewedList.length,
      itemBuilder: (context, index) {
        final itemModel = recentlyViewedList[index];
        return ProductItemSmall(
          assetImagePath: itemModel.assetImagePath,
          title: itemModel.title,
          cost: itemModel.cost,
          id: itemModel.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: Insets.x3),
    );
  }
}
