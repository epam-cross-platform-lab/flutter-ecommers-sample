import 'package:badges/badges.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/insets.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtomBarItemIcon extends StatelessWidget {
  final IconData iconData;
  final bool hasBadge;

  static const _iconWithBadgeWidth = 41.0;

  const ButtomBarItemIcon({
    @required this.iconData,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
     final cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (hasBadge) {
      return Selector<CartProvider, int>(
        builder: (context, data, child) {
          return Container(
            alignment: Alignment.center,
            width: _iconWithBadgeWidth,
            child: IconWithBadge(
              badgePosition:
                  BadgePosition.bottomLeft(bottom: Insets.x1, left: -Insets.x4),
              badgeTextStyle: Theme.of(context).textTheme.overline,
              icon: Icon(iconData),
              badgeValue: cartProvider.orderCount,
            ),
          );
        },
        selector: (buildContext, cartProvider) => cartProvider.orderCount,
      );
    }
    return Icon(iconData);
  }
}
