import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItemNormal extends ProductItemBase {
  static const size = Size(101.0, 135.0);

  const ProductItemNormal({
    @required Product product,
  }) : super(
          product: product,
          productSize: size,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: HeroImage(
              tag: product.id,
              imagePath: product.images?.first,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          product.title,
          overflow: TextOverflow.ellipsis,
          maxLines: Dimens.defaultTextMaxLines,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: FontSizes.small_3x),
        ),
        Text(
          Formatter.getCost(product.price),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: FontSizes.small_1x,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
