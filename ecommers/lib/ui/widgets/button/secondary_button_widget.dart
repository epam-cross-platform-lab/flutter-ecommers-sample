import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class SecondaryButtonWidget extends ButtonBaseWidget {
  final String text;
  final String assetIcon;
  final Function onPressedFunction;

  SecondaryButtonWidget({
    @required this.text,
    @required this.assetIcon,
    @required this.onPressedFunction,
  }) : super(
          text: text,
          assetIcon: assetIcon,
          buttonColor: BrandingColors.background,
          textColor: BrandingColors.secondary,
          onPressedFunction: onPressedFunction,
          blurColor: BrandingColors.secondary,
        );
}
