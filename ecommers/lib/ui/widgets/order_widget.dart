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

  static const orderWidgetSize = Size(272.0, 102.0);
  static const orderCircleLabelSize = Size(100.0, 100.0);
  static const actionForCountLabelSize = Size(18.0, 18.0);
  static const actionForCountIconSize = 12.0;

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
  static const IconData _countDecrementIcon = Icons.remove;
  static const IconData  _countIncrementIcon = Icons.add;
  static const _countRowWidth = 71.0;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: OrderWidget.orderWidgetSize.width,
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
                style: Theme.of(context).textTheme.body1,
              ),
              Text(
                widget.secondaryText,
                style: Theme.of(context).textTheme.body2,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                Formatter.getCost(widget.count * widget.cost),
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: _countRowWidth,
                child: Row(
                  children: <Widget>[
                    _buildCountActionButton(
                        _countDecrementIcon, widget.countDecrementFunction),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.count.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: FontSizes.normal),
                        ),
                      ),
                    ),
                    _buildCountActionButton(
                        _countIncrementIcon, widget.countIncrementFunction),
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
      height: OrderWidget.orderCircleLabelSize.height,
      width: OrderWidget.orderCircleLabelSize.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: BrandingColors.background,
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
      width: OrderWidget.actionForCountLabelSize.width,
      height: OrderWidget.actionForCountLabelSize.height,
      child: RawMaterialButton(
        onPressed: onPressedFunction,
        shape: CircleBorder(),
        child: Center(
          child: Icon(
            iconData,
            color: BrandingColors.secondary,
            size: OrderWidget.actionForCountIconSize,
          ),
        ),
        elevation: 1.0,
        fillColor: BrandingColors.backgroundIcon,
      ),
    );
  }
}
