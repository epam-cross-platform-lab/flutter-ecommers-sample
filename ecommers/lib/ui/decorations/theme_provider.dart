import 'package:flutter/material.dart';
import 'dimens/index.dart';
import 'index.dart';

class ThemeProvider {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: BrandingColors.primary,
      backgroundColor: BrandingColors.background,
      cursorColor: BrandingColors.primary,
      textTheme: TextTheme(
        headline6: _TextStyles.headline6,
        headline5: _TextStyles.headline5,
        button: _TextStyles.button,
        caption: _TextStyles.caption,
        subtitle1: _TextStyles.subtitle1,
        subtitle2: _TextStyles.subtitle2,
        bodyText1: _TextStyles.bodyText1,
        bodyText2: _TextStyles.bodyText2,
        overline: _TextStyles.overline,
        headline4: _TextStyles.headline4,
        headline3: _TextStyles.headline3,
        headline2: _TextStyles.headline2,
        headline1: _TextStyles.headline1,
      ),
    );
  }
}

class _TextStyles {
  static const headline6 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.big_4x,
    fontWeight: FontWeight.w700,
  );

  static const headline5 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.small_3x,
    fontWeight: FontWeight.w500,
  );

  static const button = TextStyle(
    color: BrandingColors.secondary,
    fontSize: FontSizes.small_3x,
    fontWeight: FontWeight.w700,
  );

  static const caption = TextStyle(
    color: BrandingColors.secondary,
    fontSize: FontSizes.small_2x,
    fontWeight: FontWeight.w400,
  );

  static const subtitle1 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w400,
  );

  static const subtitle2 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w300,
  );

  static const bodyText1 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w500,
  );

  static const bodyText2 = TextStyle(
    color: BrandingColors.primaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w300,
  );

  static const overline = TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.small_1x,
    fontWeight: FontWeight.w500,
  );

  static const headline4 = TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.normal,
    fontWeight: FontWeight.w400,
  );

  static const headline3 = TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_1x,
    fontWeight: FontWeight.w300,
  );

  static const headline2 = TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_2x,
    fontWeight: FontWeight.w400,
  );

  static const headline1 = TextStyle(
    color: BrandingColors.secondaryText,
    fontSize: FontSizes.big_3x,
    fontWeight: FontWeight.w400,
  );
}
