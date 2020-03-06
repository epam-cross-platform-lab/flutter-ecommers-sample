import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemWide extends ProductItemBase {
  final double rate;

  static const productItemWideSize = Size(160.0, 218.0);

  const ProductItemWide({
    @required ProductItemModel productModel,
    this.rate,
  }) : super(
          productModel: productModel,
          productSize: productItemWideSize,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Image.asset(productModel.assetImagePath),
          ),
        ),
        Text(
          productModel.title,
          maxLines: Dimens.defaultTextMaxLines,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                Formatter.getCost(productModel.cost),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: FontSizes.small_3x,
                      fontWeight: FontWeight.w700,
                    ),
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
