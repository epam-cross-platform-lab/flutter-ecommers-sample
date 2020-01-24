import 'package:flutter/material.dart';

class Gradients {
  static Gradient get apparelCategory =>
      _createGradient(Color(0xffFFAE4E), Color(0xffFF7676));

  static Gradient get beautyCategory =>
      _createGradient(Color(0xff4EFFF8), Color(0xff76BAFF));

  static Gradient get shoesCategory =>
      _createGradient(Color(0xffB4FF4E), Color(0xff2FC145));

  static Gradient get electronicsCategory =>
      _createGradient(Color(0xffD5A3FF), Color(0xff77A5F8));

  static Gradient get furnitureCategory =>
      _createGradient(Color(0xffFFF84E), Color(0xffE6B15C));

  static Gradient get homeCategory =>
      _createGradient(Color(0xffFF74A4), Color(0xff9F6EA3));

  static Gradient get stationaryCategory =>
      _createGradient(Color(0xff9D9E9F), Color(0xff505862));

  static Gradient get categoriesCompact =>
      _createGradient(Color(0xffffffff), Color(0xffffff));

  static LinearGradient _createGradient(Color beginColor, Color endColor) {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [beginColor, endColor]);
  }
}
