import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widget/index.dart';
import 'package:flutter/cupertino.dart';

class RcentlyViewedList extends StatelessWidget {
  final List<RecentlyViewedItemModel> recentlyViewedItmes;

  const RcentlyViewedList({this.recentlyViewedItmes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: recentlyViewedItmes.length,
      itemBuilder: (context, index) {
        final itemModel = recentlyViewedItmes[index];
        return RecentlyViewedItem(
          recentlyViewedItem: itemModel,
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: Insets.x3),
    );
  }
}
