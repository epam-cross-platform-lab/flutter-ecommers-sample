import 'package:flutter/material.dart';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';

class ProductItemSmall extends ProductItemBase {
  static const size = Size(185.0, 59.0);

  const ProductItemSmall({
    @required String assetImagePath,
    @required String title,
    @required double cost,
    int id,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          productSize: size,
          id: id,
        );
  factory ProductItemSmall.fromModel(Product product) {
    return ProductItemSmall(
      assetImagePath: product.previewImage,
      cost: product.price,
      title: product.title,
      id: product.id,
    );
  }
  @override
  Widget buildProductItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: CachedImage(imagePath: assetImagePath),
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
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: Dimens.defaultTextMaxLines,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                Formatter.getCost(cost),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
