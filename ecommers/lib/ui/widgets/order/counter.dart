import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/circle_icon.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int count;
  final Function countIncrementFunction;
  final Function countDecrementFunction;

  const Counter({
    @required this.count,
    @required this.countIncrementFunction,
    @required this.countDecrementFunction,
  });

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  static const _countRowWidth = 71.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _countRowWidth,
      child: Row(
        children: <Widget>[
          _buildCountActionButton(
            REMOVE_ICON,
            widget.countDecrementFunction,
          ),
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
            ADD_ICON,
            widget.countIncrementFunction,
          ),
        ],
      ),
    );
  }

  Widget _buildCountActionButton(
    String imagePath,
    Function onTappedFunction,
  ) {
    return Container(
      width: CircleIcon.size.width + Insets.x1,
      height: CircleIcon.size.height + Insets.x1,
      alignment: Alignment.center,
      child: RawMaterialButton(
        shape: const CircleBorder(),
        onPressed: onTappedFunction,
        elevation: 1.0,
        child: CircleIcon(imagePath: imagePath),
      ),
    );
  }
}
