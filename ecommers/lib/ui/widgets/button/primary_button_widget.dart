import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends ButtonBaseWidget {
  final String text;
  final Function onPressedFunction;

  PrimaryButtonWidget({
    @required this.text,
    @required this.onPressedFunction,
  }) : super(
          text: text,
          assetIcon: ARROW_RIGHT_ICON,
          buttonColor: Palette.primaryButtonBackground,
          textColor: Palette.primaryButtonText,
          onPressedFunction: onPressedFunction,
          blurColor: Palette.primaryButtonBlur,
        );
}
