import 'package:flutter/material.dart';

class Gradients {
  static Gradient get apparelCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffFFAE4E), Color(0xffFF7676)]);

  static Gradient get beautyCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff76BAFF), Color(0xff4EFFF8)]);

  static Gradient get shoesCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffB4FF4E), Color(0xff2FC145)]);

  static Gradient get electronicsCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffD5A3FF), Color(0xff77A5F8)]);

  static Gradient get furnitureCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffFFF84E), Color(0xffE6B15C)]);

  static Gradient get homeCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffFF74A4), Color(0xff9F6EA3)]);

  static Gradient get stationaryCategory => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff9D9E9F), Color(0xff505862)]);
}
