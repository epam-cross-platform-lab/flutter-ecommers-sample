import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';

class ProductItemWide extends ProductItemBase {
  final double rate;
  final Color color;

  static const size = Size(160.0, 218.0);

  const ProductItemWide({
    @required String assetImagePath,
    @required String title,
    @required double cost,
    int id,
    this.color = Colors.transparent,
    this.rate,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          productSize: size,
          id: id,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: HeroImage(
              tag: id,
              imagePath: assetImagePath,
            ),
          ),
        ),
        Text(
          title,
          maxLines: Dimens.defaultTextMaxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                Formatter.getCost(cost),
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
