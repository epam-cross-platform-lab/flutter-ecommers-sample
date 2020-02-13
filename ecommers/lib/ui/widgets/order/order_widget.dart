import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/order/counter.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: OrderWidget.orderWidgetSize.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleLabel(
            size: OrderWidget.orderCircleLabelSize,
            image: Image.asset(
              widget.assetImagePath,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.primaryText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                widget.secondaryText,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                Formatter.getCost(widget.count * widget.cost),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: BrandingColors.primary),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Counter(
                count: widget.count,
                countIncrementFunction: widget.countIncrementFunction,
                countDecrementFunction: widget.countDecrementFunction,
              )
            ],
          ),
        ],
      ),
    );
  }
}
