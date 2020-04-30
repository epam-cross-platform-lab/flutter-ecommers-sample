import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';

class ProductItemSmall extends ProductItemBase {
  static const size = Size(185.0, 59.0);

  const ProductItemSmall({
    @required Product product,
  }) : super(
          product: product,
          productSize: size,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: CachedImage(imagePath: product.previewImage),
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
                style: textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                Formatter.getCost(product.price),
                style: textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
