import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  final double _bottomContainerHeight;
  final Size buttonSize;

  const BottomWidget({
    @required this.buttonSize,
    double bottomContainerHeight = 25.0,
  }) : _bottomContainerHeight = bottomContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Insets.x0, Insets.x3, Insets.x0, Insets.x4),
          child: Container(
            height: _bottomContainerHeight,
            child: Divider(
              color: BrandingColors.secondary.withOpacity(0.4),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: buttonSize.height,
                width: buttonSize.width,
                child: PrimaryButtonWidget(
                  backgroundColor: BrandingColors.background,
                  textColor: BrandingColors.secondary,
                  blurColor: BrandingColors.secondary,
                  assetIconPath: Assets.shareArrowIcon,
                  text: I18n.of(context).shareThis,
                  onPressedFunction: () => {},
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: buttonSize.height,
                width: buttonSize.width,
                child: PrimaryButtonWidget(
                  text: I18n.of(context).addToCart,
                  onPressedFunction: () => {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
