import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemSmall extends ProductItemBase {
  static const productItemSmallSize = Size(185.0, 59.0);
   static const String productTypeName ='small';

  const ProductItemSmall({
    @required String assetImagePath,
    @required String title,
    @required double cost,
    int id,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          productSize: productItemSmallSize,
          id: id,
          productItemTypeName: productTypeName,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: HeroImage(
            tag: imageTag,
            imagePath: assetImagePath,
          ),
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
