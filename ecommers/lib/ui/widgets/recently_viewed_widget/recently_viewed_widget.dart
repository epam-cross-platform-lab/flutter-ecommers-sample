import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widget/index.dart';
import 'package:flutter/material.dart';

class RecentlyViewedWidget extends StatelessWidget {
  final List<RecentlyViewedItemModel> recentlyViewedList = [
    RecentlyViewedItemModel(
      assetImagePath: Assets.backpackImage,
      title: 'Red Cotton Scarf',
      cost: 22.8,
    ),
    RecentlyViewedItemModel(
      assetImagePath: Assets.backpackImage,
      title: 'apple',
      cost: 22.8,
    ),
    RecentlyViewedItemModel(
      assetImagePath: Assets.backpackImage,
      title: 'apple',
      cost: 22.8,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return RcentlyViewedList(
      recentlyViewedItmes: recentlyViewedList,
    );
  }
}
