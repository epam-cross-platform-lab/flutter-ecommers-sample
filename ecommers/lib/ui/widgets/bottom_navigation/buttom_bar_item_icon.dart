import 'package:ecommers/ui/widgets/badge.dart';
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
    if (hasBadge && badgeValue != 0) {
      return Container(
        alignment: Alignment.center,
        width: _iconWithBadgeWidth,
        child: Row(
          children: <Widget>[
            Badge(value: badgeValue),
            Icon(iconData),
          ],
        ),
      );
    }
    return Icon(iconData);
  }
}
