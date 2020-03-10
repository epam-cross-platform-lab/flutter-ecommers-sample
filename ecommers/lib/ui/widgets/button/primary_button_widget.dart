import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends ButtonBaseWidget {
  PrimaryButtonWidget({
    @required String text,
    @required Function() onPressedFunction,
    String assetIconPath = Assets.arrowRightIcon,
  }) : super(
          text: text,
          assetIcon: assetIconPath,
          buttonColor: BrandingColors.primary,
          textColor: BrandingColors.secondaryText,
          onPressedFunction: onPressedFunction,
          blurColor: BrandingColors.primary.withOpacity(0.4),
        );
}
