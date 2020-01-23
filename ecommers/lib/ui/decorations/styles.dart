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

  static TextStyle get productItemTitleText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemTitleFontSize,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get productItemCostText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemCostFontSize,
        fontWeight: FontWeight.bold,    
      );

  static TextStyle get productItemSmallTitleText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemSmallTitleFontSize,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get productItemSmallCostText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemSmallCostFontSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get productItemWideTitleText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemWideTitleFontSize,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get productItemWideCostText => TextStyle(
        color: Palette.productItemText,
        fontSize: Dimens.productItemWideCostFontSize,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get rateText => TextStyle(
        color: Palette.rateText,
        fontSize: Dimens.rateFontSize,
        fontWeight: FontWeight.bold,
      );
}
