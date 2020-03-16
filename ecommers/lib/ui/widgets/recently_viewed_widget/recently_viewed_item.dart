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
      width: 180,
      decoration: const BoxDecoration(
        color: BrandingColors.background,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 10.0),
                Text(
                  recentlyViewedItem.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 6.0),
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
