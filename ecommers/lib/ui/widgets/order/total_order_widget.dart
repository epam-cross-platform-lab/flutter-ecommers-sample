import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/button/index.dart';

class TotalOrderWidget extends StatelessWidget {
  final String buttonText;
  final bool isButtonDisabled;
  final double cost;
  final Function() onButtonPressedFunction;
  final Color backgroundColor;
  final EdgeInsets padding;

  static const _buttonSize = Size(165.0, 46.0);

  const TotalOrderWidget({
    @required this.cost,
    @required this.buttonText,
    @required this.onButtonPressedFunction,
    this.backgroundColor,
    this.isButtonDisabled = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                localization.totalOrder,
                style: textTheme
                    .headline5
                    .copyWith(fontSize: FontSizes.small_1x),
              ),
              const SizedBox(height: 7.0),
              Text(
                Formatter.getCost(cost),
                style: textTheme
                    .headline6
                    .copyWith(fontSize: FontSizes.big_2x),
              ),
              const SizedBox(height: 4.0),
              Text(
                localization.freeDomesticShipping,
                style: textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: _buttonSize.height,
                width: _buttonSize.width,
                child: PrimaryButtonWidget(
                  text: buttonText,
                  isDisabled: isButtonDisabled,
                  onPressedFunction: onButtonPressedFunction,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
