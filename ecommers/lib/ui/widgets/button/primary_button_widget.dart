import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends ButtonBaseWidget {
  PrimaryButtonWidget({
    @required String text,
    @required Function() onPressedFunction,
    Color backgroundColor = BrandingColors.primary,
    Color textColor = BrandingColors.secondaryText,
    Color blurColor = BrandingColors.primary,
    String assetIconPath = Assets.arrowRightIcon,
  }) : super(
          text: text,
          assetIcon: assetIconPath,
          buttonColor: backgroundColor,
          textColor: textColor,
          onPressedFunction: onPressedFunction,
          blurColor: blurColor.withOpacity(0.4),
        );
}
