import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItemNormal extends ProductItemBase {
  static const size = Size(101.0, 135.0);

  const ProductItemNormal({
    @required String assetImagePath,
    @required String title,
    @required double cost,
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
              imageUrl:
                  'https://raw.githubusercontent.com/epam-cross-platform-lab/flutter-ecommers-sample/dev/design_sources/$assetImagePath',
              errorWidget: (context, url, error) =>
                  SvgPicture.asset(Assets.warningIcon),
              fit: BoxFit.scaleDown,
            ),
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
