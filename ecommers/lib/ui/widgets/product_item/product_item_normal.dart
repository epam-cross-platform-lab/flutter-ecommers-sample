import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/widgets.dart';

class ProductItemNormal extends ProductItemBase {
  final String assetImagePath;
  final String title;
  final double cost;
  final double rate;

  ProductItemNormal({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    this.rate,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          size: Dimens.productItemNormalSize,
        );

  @override
  Widget buildProductItem() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(assetImagePath),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: Dimens.defaultTextMaxLines,
              style: Styles.productItemTitleText,
            ),
            Text(
              Formatter.getCost(cost),
              style: Styles.productItemCostText,
            ),
          ],
        )
      ],
    );
  }
}
