import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color iconBackgroundColor;
  final Color blurColor;

  final String text;
  final String assetSVG;
  final Function onPressedFunction;

  BaseButtonWidget(
      {this.text,
      this.assetSVG,
      this.buttonColor,
      this.textColor,
      this.blurColor,
      this.iconBackgroundColor,
      this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10.0, offset: new Offset(0.0, 5.0), color: blurColor)
        ]),
        child: CupertinoButton(
            padding: EdgeInsets.all(8.0),
            borderRadius: BorderRadius.circular(23.0),
            color: buttonColor,
            onPressed: onPressedFunction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(text,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold)))),
                Container(
                    height: 30.0,
                    width: 30.0,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 9.0),
                        child: SvgPicture.asset(assetSVG, color: buttonColor)),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: iconBackgroundColor ?? textColor))
              ],
            )));
  }
}
