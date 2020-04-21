import 'package:flutter/material.dart';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';

class PrimaryButtonWidget extends ButtonBaseWidget {
  PrimaryButtonWidget({
    @required String text,
    @required Function() onPressedFunction,
    bool isDisabled = false,
    String assetIconPath = Assets.arrowRightIcon,
  }) : super(
          text: text,
          assetIcon: assetIconPath,
          buttonColor: BrandingColors.primary,
          textColor: BrandingColors.secondaryText,
          onPressedFunction: onPressedFunction,
          blurColor: BrandingColors.primary.withOpacity(0.4),
          isDisabled: isDisabled,
        );
}
