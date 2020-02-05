import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../decorations/dimens/index.dart';

class ButtonBaseWidget extends StatelessWidget {
  static const double _circleSize = 30.0;
  static const double _iconHeight = 12.0;

  final Color buttonColor;
  final Color textColor;
  final Color iconBackgroundColor;
  final Color blurColor;
  final String text;
  final String assetIcon;
  final Function onPressedFunction;

  ButtonBaseWidget(
      {@required this.text,
      @required this.assetIcon,
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
            blurRadius: Radiuses.normal,
            offset: const Offset(Insets.x0, Insets.x1_5),
            color: blurColor,
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(Insets.x2),
        borderRadius: BorderRadius.circular(Radiuses.big_2x),
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
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: textColor),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: _circleSize,
              width: _circleSize,
              child: SvgPicture.asset(
                assetIcon,
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
