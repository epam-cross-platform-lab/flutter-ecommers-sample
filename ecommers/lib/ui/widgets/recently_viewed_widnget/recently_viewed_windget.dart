import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widnget/index.dart';
import 'package:flutter/material.dart';

class RecentlyViewedWindget extends StatelessWidget {
  final List<RecentlyViewedItemModel> recentlyViewedList = [
    RecentlyViewedItemModel(
        assetImagePath: Assets.dressFloralImage, title: 'apple', cost: 22.8)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          RcentlyViewedList(recentlyViewedItmes: recentlyViewedList,),
        ],
      ),
    );
  }
}
