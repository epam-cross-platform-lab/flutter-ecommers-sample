import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  static const Size _buttonSize = Size(120.0, 40.0);

  static const imageCardSize = Size(325.0, 184.0);

  final String imageUrl;
  final String description;
  final String buttonText;
  final Function() onButtonPressed;

  const ImageCard({
    this.imageUrl,
    this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: imageUrl,
        child: Container(
          height: imageCardSize.height,
          width: imageCardSize.width,
          child: Stack(fit: StackFit.expand, children: [
            Positioned.fill(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ))),
            Positioned(
                left: Insets.x6_5,
                top: Insets.x6_5,
                bottom: Insets.x6_5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: imageCardSize.width / 3,
                        child: Text(
                          description,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _buttonSize.height,
                      width: _buttonSize.width,
                      child: ButtonBaseWidget(
                        text: buttonText,
                        assetIcon: Assets.arrowRightIcon,
                        buttonColor: BrandingColors.background,
                        textColor: BrandingColors.secondary,
                        onPressedFunction: onButtonPressed,
                        iconBackgroundColor: BrandingColors.primary,
                        blurColor: BrandingColors.secondary.withOpacity(0.15),
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }
}
