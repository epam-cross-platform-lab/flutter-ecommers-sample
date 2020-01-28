import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  static const _badgeSize = Size(17.0, 15.0);
  final int value;

  const Badge({
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _badgeSize.width,
      height: _badgeSize.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Palette.badge,
        borderRadius: BorderRadius.circular(Dimens.badgeBorderRadius),
        boxShadow: [
          BoxShadow(
              color: Palette.badgeBlur,
              blurRadius: Dimens.badgeBlurRadius,
              offset: Dimens.badgeBlurOffset),
        ],
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: Styles.badgeValueText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
