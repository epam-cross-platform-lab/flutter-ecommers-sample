import 'package:flutter/material.dart';

class Gradients {
  static Gradient get apparelCategory =>
      _createGradient(const Color(0xffFFAE4E), const Color(0xffFF7676));

  static Gradient get beautyCategory =>
      _createGradient(const Color(0xff4EFFF8), const Color(0xff76BAFF));

  static Gradient get shoesCategory =>
      _createGradient(const Color(0xffB4FF4E), const Color(0xff2FC145));

  static Gradient get electronicsCategory =>
      _createGradient(const Color(0xffD5A3FF), const Color(0xff77A5F8));

  static Gradient get furnitureCategory =>
      _createGradient(const Color(0xffFFF84E), const Color(0xffE6B15C));

  static Gradient get homeCategory =>
      _createGradient(const Color(0xffFF74A4), const Color(0xff9F6EA3));

  static Gradient get stationaryCategory =>
      _createGradient(const Color(0xff9D9E9F), const Color(0xff505862));

  static Gradient get categoriesCompact =>
      _createGradient(const Color(0xffffffff), const Color(0xffffffff));

  static LinearGradient _createGradient(Color beginColor, Color endColor) {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [beginColor, endColor]);
  }
}
