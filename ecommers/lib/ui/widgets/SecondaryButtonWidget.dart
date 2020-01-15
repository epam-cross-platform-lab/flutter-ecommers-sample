import 'package:flutter/material.dart';
import 'BaseButtonWidget.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF727C8E);
  final Color blurColor = Color(0xFF727C8E).withOpacity(0.15);

  final String text;
  final String assetIcon;
  final Function onPressedFunction;

  SecondaryButtonWidget(this.text, this.assetIcon, this.onPressedFunction);

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