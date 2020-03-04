import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/icon_with_badge.dart';
import 'package:ecommers/ui/widgets/product_page/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPage extends StatelessWidget {
  final Widget child;

  const ProductPage({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backIcon,
            color: BrandingColors.primary,
            height: 18.0,
          ),
          onPressed: () => navigationService.goBack(),
        ),
        title: Header(
          title: 'Faux Sued Ankle Boots',
          cost: 49.99,
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
      body: child,
    );
  }
}
