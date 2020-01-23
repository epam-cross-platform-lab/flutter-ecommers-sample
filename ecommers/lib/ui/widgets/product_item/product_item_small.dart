import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemSmall extends ProductItemBase {
  final String assetImagePath;
  final String title;
  final double cost;
  final double rate;

  ProductItemSmall({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    this.rate,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          size: Dimens.productItemSmallSize,
        );

  @override
  Widget buildProductItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Image.asset(assetImagePath),
        ),
        SizedBox(
          width: ProductItemBase.padding,
        ),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Styles.productItemSmallTitleText,
              ),
              Text(
                formatCurrency.format(cost),
                style: Styles.productItemSmallCostText,
              ),
            ],
          ),
        )
      ],
    );
  }
}
