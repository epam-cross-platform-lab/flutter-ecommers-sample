import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  static const Size _buttonSize = Size(120.0, 40.0);

  static const double _textWidth = 134.0;
  static const int _textMaxLines = 3;

  static const double _borderRadius = 10.0;
  static const imageCardSize = Size(325.0, 184.0);

  final String imageAsset;
  final String description;
  final String buttonText;
  final Function onButtonPressed;

  ImageCard({
    this.imageAsset,
    this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: imageCardSize.height,
      width: imageCardSize.width,
      padding: EdgeInsets.all(Insets.x6_5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: _textWidth,
              child: Text(
                description,
                maxLines: _textMaxLines,
                style: Theme.of(context).textTheme.display2,
              ),
            ),
          ),
          
          SizedBox(
            height: _buttonSize.height,
            width: _buttonSize.width,
            child: ButtonBaseWidget(
                text: buttonText,
                assetIcon: ARROW_RIGHT_ICON,
                buttonColor: BrandingColors.background,
                textColor: BrandingColors.secondary,
                onPressedFunction: onButtonPressed,
                iconBackgroundColor: BrandingColors.primary,
                blurColor: BrandingColors.secondary.withOpacity(0.15)),
          ),
        ],
      ),
    );
  }
}
