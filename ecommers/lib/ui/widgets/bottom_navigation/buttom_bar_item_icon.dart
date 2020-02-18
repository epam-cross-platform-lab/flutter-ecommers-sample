import 'package:badges/badges.dart';
import 'package:ecommers/ui/decorations/dimens/insets.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class ButtomBarItemIcon extends StatelessWidget {
  final IconData iconData;
  final bool hasBadge;
  final int badgeValue;

  static const _iconWithBadgeWidth = 41.0;

  const ButtomBarItemIcon({
    @required this.iconData,
    this.hasBadge = false,
    this.badgeValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (hasBadge) {
      return Container(
        alignment: Alignment.center,
        width: _iconWithBadgeWidth,
        child: IconWithBadge(
          badgePosition:
              BadgePosition.bottomLeft(bottom: Insets.x1, left: -Insets.x4),
          badgeTextStyle: Theme.of(context).textTheme.overline,
          icon: Icon(iconData),
          badgeValue: badgeValue,
        ),
      );
    }
    return Icon(iconData);
  }
}
