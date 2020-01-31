import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  final String assetImagePath;
  final String primaryText;
  final String secondaryText;
  final double cost;
  final int count;
  final Function countIncrementFunction;
  final Function countDecrementFunction;

  OrderWidget({
    @required this.assetImagePath,
    @required this.primaryText,
    @required this.secondaryText,
    @required this.cost,
    @required this.count,
    @required this.countIncrementFunction,
    @required this.countDecrementFunction,
  });

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  static const  _countDecrementIcon = Icons.remove;
  static const  _countIncrementIcon = Icons.add;
  static const _countRowWidth = 71.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.orderWidgetSize.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildCircleLabel(),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.primaryText,
                style: Styles.orderPrimaryText,
              ),
              Text(
                widget.secondaryText,
                style: Styles.orderSecondaryText,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                Formatter.getCost(widget.count*widget.cost),
                style: Styles.orderCostText,
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: _countRowWidth,
                child: Row(
                  children: <Widget>[
                    _buildCountActionButton(_countDecrementIcon, widget.countDecrementFunction),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.count.toString(),
                          style: Styles.orderCountText,
                        ),
                      ),
                    ),
                    _buildCountActionButton(_countIncrementIcon, widget.countIncrementFunction),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildCircleLabel() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.orderCircleLabelSize.height,
      width: Dimens.orderCircleLabelSize.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Palette.orderCircleLabel,
      ),
      child: Center(
        child: Image.asset(
          widget.assetImagePath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  _buildCountActionButton(IconData iconData, Function onPressedFunction) {
    return Container(
      width: Dimens.actionForCountLabelSize.width,
      height: Dimens.actionForCountLabelSize.height,
      child: RawMaterialButton(
        onPressed: onPressedFunction,
        shape: CircleBorder(),
        child: Center(
          child: Icon(
            iconData,
            color: Palette.cartPageSecondaryText,
            size: Dimens.actionForCountIconSize,
          ),
        ),
        elevation: 1.0,
        fillColor: Palette.orderSmallLabel,
      ),
    );
  }
}
