import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemSmall extends ProductItemBase {
  static const productItemSmallSize = Size(185.0, 59.0);

  const ProductItemSmall({
    @required Product product,
  }) : super(
          product: product,
          productSize: productItemSmallSize,
        );

  factory ProductItemSmall.fromModel(Product product) {
    return ProductItemSmall(product: product);
  }

  @override
  Widget buildProductItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: CachedImage(imagePath: product.images?.first),
        ),
        const SizedBox(
          width: ProductItemBase.padding,
        ),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: Dimens.defaultTextMaxLines,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                Formatter.getCost(product.price),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
