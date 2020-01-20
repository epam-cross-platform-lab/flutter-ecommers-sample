import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  static const Size _cardSize = Size(325.0, 184.0);
  static const Size _buttonSize = Size(120.0, 40.0);

  static const double _textWidth = 134.0;
  static const int _textMaxLines = 3;

  static const double _borderRadius = 10.0;
  static const double _containerPadding = 26.0;

  final String imageAsset;
  final String description;
  final String buttonText;

  ImageCard({this.imageAsset, this.description, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: _cardSize.height,
      width: _cardSize.width,
      padding: EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: _textWidth,
                  child: Text(
                    description,
                    maxLines: _textMaxLines,
                    style: TextStyle(
                      color: Palette.imageCardText,
                      fontSize: Dimens.imageCardTextFontSize,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: _buttonSize.height,
                  width: _buttonSize.width,
                  child: BaseButtonWidget(
                      text: buttonText,
                      assetIcon: ARROW_RIGHT_ICON,
                      buttonColor: Palette.secondaryButtonBackground,
                      textColor: Palette.secondaryButtonText,
                      onPressedFunction: () {},
                      iconBackgroundColor: Palette.primaryButtonBackground,
                      blurColor: Palette.secondaryButtonBlur),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
