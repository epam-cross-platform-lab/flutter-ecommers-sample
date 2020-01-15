import 'package:ecommers/ui/widgets/BaseButtonWidget.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final Color backgroundColor = Color(0xFFFF6969);
  final Color textColor = Colors.white;
  final Color blurColor = Color(0xFFFF6969).withOpacity(0.4);

  final String text;
  final String assetIcon;
  final Function onPressedFunction;

  PrimaryButtonWidget(this.text, this.assetIcon, this.onPressedFunction);

  @override
  Widget build(BuildContext context) {
    return BaseButtonWidget(
        text: text,
        assetSVG: assetIcon,
        buttonColor: backgroundColor,
        textColor: textColor,
        onPressedFunction: onPressedFunction,
        blurColor: blurColor);
  }
}
