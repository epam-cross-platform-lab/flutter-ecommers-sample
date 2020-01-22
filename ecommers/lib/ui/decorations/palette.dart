import 'package:flutter/material.dart';

class Palette {
  static Color get apparelCategoryShadow => Color(0xffFF6262).withOpacity(0.34);
  static Color get beautyCategoryShadow => Color(0xff62AAFF).withOpacity(0.35);
  static Color get shoesCategoryShadow => Color(0xff26D555).withOpacity(0.34);
  static Color get electronicsCategoryShadow => Color(0xff7A71E8).withOpacity(0.34);
  static Color get furnitureCategoryShadow => Color(0xffD59F26).withOpacity(0.34);
  static Color get homeCategoryShadow => Color(0xff834162).withOpacity(0.34);
  static Color get stationaryCategoryShadow => Color(0xff646464).withOpacity(0.34);

  static Color get categoryText => Color(0xff515C6F);

  static Color get primaryButtonBackground => Color(0xFFFF6969);
  static Color get primaryButtonText => Colors.white;
  static Color get primaryButtonBlur => Color(0xFFFF6969).withOpacity(0.4);

  static Color get secondaryButtonBackground => Colors.white;
  static Color get secondaryButtonText => Color(0xFF727C8E);
  static Color get secondaryButtonBlur => Color(0xFF727C8E).withOpacity(0.15);

  static Color get bottomNavigationItemSelected => Color(0xffFF6969);
  static Color get bottomNavigationItemUnselected => Color(0xff515C6F);
}
