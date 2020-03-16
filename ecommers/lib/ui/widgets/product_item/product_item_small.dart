import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItemSmall extends ProductItemBase {
  static const productItemSmallSize = Size(185.0, 59.0);

  const ProductItemSmall({
    @required String assetImagePath,
    @required String title,
    @required double cost,
  }) : super(
          assetImagePath: assetImagePath,
          cost: cost,
          title: title,
          productSize: productItemSmallSize,
        );

  @override
  Widget buildProductItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: CachedNetworkImage(
            imageUrl:
                'https://raw.githubusercontent.com/epam-cross-platform-lab/flutter-ecommers-sample/dev/design_sources/$assetImagePath',
            errorWidget: (context, url, error) =>
                SvgPicture.asset(Assets.warningIcon),
            fit: BoxFit.scaleDown,
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
