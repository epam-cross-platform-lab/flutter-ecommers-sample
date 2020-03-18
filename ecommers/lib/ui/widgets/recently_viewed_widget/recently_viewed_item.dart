import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentlyViewedItem extends StatelessWidget {
  final RecentlyViewedItemModel recentlyViewedItem;

  const RecentlyViewedItem({this.recentlyViewedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: BrandingColors.background,
        borderRadius: BorderRadius.circular(
          Radiuses.normal,
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Insets.x2),
            child: Image(
              height: 40,
              width: 40,
              image: AssetImage(recentlyViewedItem.assetImagePath),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: Insets.x2_5),
                Text(
                  recentlyViewedItem.title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: Insets.x0_5),
                Text(
                  '\$${recentlyViewedItem.cost}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
