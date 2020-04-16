import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemWide extends ProductItemBase {
  static const size = Size(160.0, 218.0);

  final Color color;

  const ProductItemWide({
    @required Product product,
    this.color = Colors.transparent,
  }) : super(
          product: product,
          productSize: size,
        );

  factory ProductItemWide.fromModel(Product product, Color color) {
    return ProductItemWide(
      product: product,
      color: color,
    );
  }

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
        Text(
          product.title,
          maxLines: Dimens.defaultTextMaxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                Formatter.getCost(product.price),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: FontSizes.small_3x,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            RateWidget(
              rate: product.rate,
            ),
          ],
        )
      ],
    );
  }
}
