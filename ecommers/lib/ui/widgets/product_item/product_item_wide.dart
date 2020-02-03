import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemWide extends ProductItemBase {
  final String assetImagePath;
  final String title;
  final double cost;
  final double rate;

  static const productItemWideSize = Size(160.0, 218.0);

  ProductItemWide({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    this.rate,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          size: productItemWideSize,
        );

  @override
  Widget buildProductItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Image.asset(assetImagePath),
          ),
        ),
        Text(
          title,
          maxLines: Dimens.defaultTextMaxLines,
          style: Styles.productItemWideTitleText,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                Formatter.getCost(cost),
                style: Styles.productItemWideCostText,
              ),
            ),
            RateWidget(
              rate: rate,
            ),
          ],
        )
      ],
    );
  }
}
