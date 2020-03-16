import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItemWide extends ProductItemBase {
  final double rate;
  final Color color;

  static const size = Size(160.0, 218.0);

  const ProductItemWide({
    @required String assetImagePath,
    @required String title,
    @required double cost,
    this.color = Colors.transparent,
    this.rate,
  }) : super(
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
            child: CachedNetworkImage(
              imageUrl: '${Assets.imageBaseUrl}/$assetImagePath',
              errorWidget: (context, url, error) =>
                  SvgPicture.asset(Assets.warningIcon),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Text(
          title,
          maxLines: Dimens.defaultTextMaxLines,
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
