import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:flutter/material.dart';

class RecentlyViewedWidget extends StatelessWidget {
  final List<Product> recentlyViewedList;

  const RecentlyViewedWidget({Key key, this.recentlyViewedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recentlyViewedList == null) return Container();
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: recentlyViewedList.length,
      itemBuilder: (context, index) {
        final itemModel = recentlyViewedList[index];
        return ProductItemSmall(product: itemModel);
      },
      separatorBuilder: (context, index) => const SizedBox(width: Insets.x3),
    );
  }
}
