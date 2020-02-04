import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class ThemeProvider {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: BrandingColors.primary,
      backgroundColor: BrandingColors.background,
      cursorColor: BrandingColors.primary,
      textTheme: TextTheme(
        title: _TextStyles.title,
        subtitle: _TextStyles.subtitle,
        button: _TextStyles.button,
        caption: _TextStyles.caption,
        subhead: _TextStyles.subhead,
        body1: _TextStyles.body1,
        body2: _TextStyles.body2,
        overline: _TextStyles.overline,
        display1: _TextStyles.display1,
        display2: _TextStyles.display2,
        display3: _TextStyles.display3,
        display4: _TextStyles.display4,
      ),
    );
  }
}

class _TextStyles {
  static const title = const TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.big_4x,
    fontWeight: FontWeight.w700,
  );

  static const subtitle = const TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.small_3x,
    fontWeight: FontWeight.w500,
  );

  static const button = const TextStyle(
    color: BrandingColors.secondary,
    fontSize: FontSizes.small_3x,
    fontWeight: FontWeight.w700,
  );

  static const caption = const TextStyle(
    color: BrandingColors.secondary,
    fontSize: FontSizes.small_2x,
    fontWeight: FontWeight.w400,
  );

  static const subhead = const TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w400,
  );

  static const body1 = const TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w500,
  );

  static const body2 = const TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w300,
  );

  static const overline = const TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.small_1x,
    fontWeight: FontWeight.w500,
  );

  static const display1 = const TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w400,
  );

  static const display2 = const TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_1x,
    fontWeight: FontWeight.w300,
  );

  static const display3 = const TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_2x,
    fontWeight: FontWeight.w400,
  );

  static const display4 = const TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_3x,
    fontWeight: FontWeight.w400,
  );
}
