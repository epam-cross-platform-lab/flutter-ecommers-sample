import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseButtonWidget extends StatelessWidget {
  static const double _circleSize = 30.0;
  static const double _iconHeight = 12.0;
  static const double _borderRadius = 23.0;
  static const double _padding = 8.0;
  static const Offset _blurOffset = Offset(0.0, 5.0);
  static const double _blurRadius = 10.0;

  final Color buttonColor;
  final Color textColor;
  final Color iconBackgroundColor;
  final Color blurColor;
  final String text;
  final String assetImage;
  final Function onPressedFunction;

  BaseButtonWidget(
      {@required this.text,
      @required this.assetImage,
      @required this.buttonColor,
      @required this.textColor,
      @required this.blurColor,
      this.iconBackgroundColor,
      @required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            offset: _blurOffset,
            color: blurColor,
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(_padding),
        borderRadius: BorderRadius.circular(_borderRadius),
        color: buttonColor,
        onPressed: onPressedFunction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: _circleSize,
              width: _circleSize,
              child: SvgPicture.asset(
                  assetImage,
                  height: _iconHeight,
                  color: buttonColor,
                ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor ?? textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
