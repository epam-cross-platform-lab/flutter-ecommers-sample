import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class SecondaryButtonWidget extends ButtonBaseWidget {
  const SecondaryButtonWidget({
    @required String text,
    @required String assetIcon,
    @required Function() onPressedFunction,
  }) : super(
          text: text,
          assetIcon: assetIcon,
          buttonColor: BrandingColors.background,
          textColor: BrandingColors.secondary,
          onPressedFunction: onPressedFunction,
          blurColor: BrandingColors.secondary,
        );
}
