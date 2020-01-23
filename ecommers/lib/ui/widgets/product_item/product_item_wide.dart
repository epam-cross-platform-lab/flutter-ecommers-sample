import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemWide extends ProductItemBase {
  final String assetImagePath;
  final String title;
  final double cost;
  final double rate;

  ProductItemWide({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    this.rate,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          size: Dimens.productItemWideSize,
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
              style: Styles.productItemWideTitleText,
            ),
            Stack(
              children: <Widget>[
                Text(
                  formatCurrency.format(cost),
                  style: Styles.productItemWideCostText,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RateWidget(
                    rate: rate,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
