import 'package:ecommers/ui/widgets/recently_viewed_widnget/index.dart';
import 'package:flutter/widgets.dart';

class RecentlyViewedItem extends StatelessWidget{
    final RecentlyViewedItemModel recentlyViewedItem;

  const RecentlyViewedItem({Key key, this.recentlyViewedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(recentlyViewedItem.assetImagePath),
          ),
          Text(recentlyViewedItem.title),
          Text('\$${recentlyViewedItem.cost}')
        ],
      ),
    );
  }
  
}