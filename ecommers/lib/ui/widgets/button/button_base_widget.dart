import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class ButtonBaseWidget extends StatelessWidget {
  static const double _circleSize = 30.0;
  static const double _iconHeight = 12.0;

  final Color buttonColor;
  final Color textColor;
  final Color iconBackgroundColor;
  final Color blurColor;
  final String text;
  final String assetIcon;
  final bool isDisabled;
  final Function() onPressedFunction;

  const ButtonBaseWidget({
    @required this.text,
    @required this.assetIcon,
    @required this.buttonColor,
    @required this.textColor,
    @required this.blurColor,
    @required this.onPressedFunction,
    this.iconBackgroundColor,
    this.isDisabled = false,
  });

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
        borderRadius: BorderRadius.circular(Radiuses.big_2x),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(Insets.x2),
        borderRadius: BorderRadius.circular(Radiuses.big_2x),
        color: buttonColor,
        disabledColor: BrandingColors.primary.withOpacity(0.5),
        onPressed: isDisabled ? null : onPressedFunction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text.toUpperCase(),
                  style: textTheme
                      .button
                      .copyWith(color: textColor),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: _circleSize,
              width: _circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor ?? textColor,
              ),
              child: SvgPicture.asset(
                assetIcon,
                height: _iconHeight,
                color: buttonColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
