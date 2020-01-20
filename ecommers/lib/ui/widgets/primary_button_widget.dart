import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final String assetIcon;
  final Function onPressedFunction;

  PrimaryButtonWidget(
      {@required this.text,
      @required this.assetIcon,
      @required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        text: text,
        assetIcon: assetIcon,
        buttonColor: Palette.primaryButtonBackground,
        textColor: Palette.primaryButtonText,
        onPressedFunction: onPressedFunction,
        blurColor: Palette.primaryButtonBlur);
  }
}
