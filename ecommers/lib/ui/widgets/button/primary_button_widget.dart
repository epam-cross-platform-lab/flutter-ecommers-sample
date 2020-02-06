import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends ButtonBaseWidget {
  final String text;
  final Function onPressedFunction;
  final String assetIconPath;

  PrimaryButtonWidget({
    @required this.text,
    @required this.onPressedFunction,
    this.assetIconPath = ARROW_RIGHT_ICON,
  }) : super(
          text: text,
          assetIcon: assetIconPath,
          buttonColor: BrandingColors.primary,
          textColor: BrandingColors.secondaryText,
          onPressedFunction: onPressedFunction,
          blurColor: BrandingColors.primary.withOpacity(0.4),
        );
}
