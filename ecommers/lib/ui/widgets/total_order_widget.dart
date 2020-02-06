import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class TotalOrderWidget extends StatelessWidget {
  final String buttonText;
  final double cost;
  final Function onButtonPressedFunction;
  final Color backgroundColor;
  final EdgeInsets padding;

  static const _buttonSize = Size(165.0, 46.0);

  const TotalOrderWidget({
    @required this.cost,
    @required this.buttonText,
    @required this.onButtonPressedFunction,
    this.backgroundColor,
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
                I18n.of(context).totalOrder,
                //style: Styles.totalOrderText,
              ),
              SizedBox(height: 7.0),
              Text(
                Formatter.getCost(cost),
                //style: Styles.totalOrderCostText,
              ),
              SizedBox(height: 4.0),
              Text(
                I18n.of(context).freeDomesticShipping,
                //style: Styles.freeDomesticText,
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
