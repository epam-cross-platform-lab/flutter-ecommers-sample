import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order/counter.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/material.dart';

class SmallOrderWidget extends StatefulWidget {
  final String assetImagePath;
  final String primaryText;
  final String secondaryText;
  final double cost;
  final int count;
  final Function() countIncrementFunction;
  final Function() countDecrementFunction;
  final Function() tapOrderFunction;

  static const orderCircleImageSize = Size(69.0, 69.0);

  const SmallOrderWidget(
      {@required this.assetImagePath,
      @required this.primaryText,
      @required this.secondaryText,
      @required this.cost,
      @required this.count,
      @required this.countIncrementFunction,
      @required this.countDecrementFunction,
      this.tapOrderFunction});

  @override
  _SmallOrderWidgetState createState() => _SmallOrderWidgetState();
}

class _SmallOrderWidgetState extends State<SmallOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.tapOrderFunction,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleImage(
            size: SmallOrderWidget.orderCircleImageSize,
            image: CachedImage(imagePath: widget.assetImagePath),
          ),
          const SizedBox(width: Insets.x3_5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.primaryText,
                  style: textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.secondaryText,
                  style: textTheme.subtitle1,
                ),
                const SizedBox(height: Insets.x1),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      Formatter.getCost(widget.count * widget.cost),
                      style: textTheme
                          .bodyText1
                          .copyWith(color: BrandingColors.primary),
                    )),
                    Counter(
                      count: widget.count,
                      countIncrementFunction: widget.countIncrementFunction,
                      countDecrementFunction: widget.countDecrementFunction,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
