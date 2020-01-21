import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class Styles {
  static TextStyle get categoryItemTitle => TextStyle(
        color: Palette.categoryText,
        fontSize: Dimens.categoryTitleFontSize,
      );

  static TextStyle get titleText => TextStyle(
        color: Palette.titleText,
        fontSize: Dimens.titleTextFontSize,
        fontWeight: FontWeight.bold,
      );
}
