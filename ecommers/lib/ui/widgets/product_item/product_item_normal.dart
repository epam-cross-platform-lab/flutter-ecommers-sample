import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItemNormal extends ProductItemBase {
  static const size = Size(101.0, 135.0);

  const ProductItemNormal({
    @required String assetImagePath,
    @required String title,
    @required double cost,
    })
      : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          productSize: size,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Image.asset(assetImagePath),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: Dimens.defaultTextMaxLines,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: FontSizes.small_3x),
        ),
        Text(
          Formatter.getCost(cost),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: FontSizes.small_1x,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
