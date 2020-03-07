import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/icon_with_badge.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_page/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPage extends StatelessWidget {
  final ProductItemModel productModel;
  static const _carouselWidgetHeight = 250.0;
  static const _carouselImageScale = 0.5;
  static const _appBarIconButtonHeight = 18.0;

  const ProductPage({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backIcon,
            color: BrandingColors.primary,
            height: _appBarIconButtonHeight,
          ),
          onPressed: () => navigationService.goBack(),
        ),
        title: Header(
          title: productModel.title,
          cost: productModel.cost,
          rate: 4.9,
        ),
        actions: <Widget>[
          IconButton(
            icon: IconWithBadge(
              badgeValue: 4,
              badgeTextStyle: Theme.of(context).textTheme.overline,
              icon: Icon(
                Icons.shopping_cart,
                color: BrandingColors.primaryText,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: BrandingColors.pageBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CarouselWidget(
              assetImagePaths: [
                productModel.assetImagePath,
                productModel.assetImagePath,
                productModel.assetImagePath,
              ],
              height: _carouselWidgetHeight,
              imageScale: _carouselImageScale,
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.x5),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const BottomWidget(
                  buttonSize: Size(165.0, 46.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
