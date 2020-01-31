import 'package:badges/badges.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class ButtomBarItemIcon extends StatelessWidget {
  final IconData iconData;
  final bool hasBadge;
  final int badgeValue;

  static const _iconWithBadgeWidth = 41.0;

  ButtomBarItemIcon({
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
          badgePosition: BadgePosition.bottomLeft(bottom: 4, left: -13),
          icon: Icon(iconData),
          badgeValue: badgeValue,
        ),
      );
    }
    return Icon(iconData);
  }
}
