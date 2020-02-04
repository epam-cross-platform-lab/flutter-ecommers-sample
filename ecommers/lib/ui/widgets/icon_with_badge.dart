import 'package:badges/badges.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class IconWithBadge extends Badge {
  final int badgeValue;
  final BadgePosition badgePosition;
  final Widget icon;
  final TextStyle badgeTextStyle;

  IconWithBadge({
    this.badgeValue = 0,
    this.badgePosition,
    this.badgeTextStyle,
    @required this.icon,
  }) : super(
          child: icon,
          badgeContent: Text(
            badgeValue.toString(),
            style: badgeTextStyle,
            textAlign: TextAlign.center,
          ),
          position:
              badgePosition ?? BadgePosition.bottomLeft(bottom: -4, left: -9),
          shape: BadgeShape.square,
          borderRadius: Radiuses.small_2x,
          elevation: 1.0,
          badgeColor: BrandingColors.primary,
          animationType: BadgeAnimationType.scale,
          showBadge: badgeValue != 0,
          padding: EdgeInsets.fromLTRB(Insets.x1_5, Insets.x0_5, Insets.x1_5, Insets.x0_5),
        );
}
