import 'package:flutter/cupertino.dart';

class CategoryButtonModel {
  Gradient gradient;
  Color shadowColor;
  String imagePath;
  EdgeInsets imageCategoryPadding;

  CategoryButtonModel(
      {this.gradient,
      this.shadowColor,
      this.imagePath,
      this.imageCategoryPadding});
}
