import 'package:flutter/cupertino.dart';

class CategoryItemModel {
  Gradient gradient;
  Color shadowColor;
  String imagePath;
  EdgeInsets imageCategoryPadding;
  String title;

  CategoryItemModel(
      {this.gradient,
      this.shadowColor,
      this.imagePath,
      this.imageCategoryPadding,
      this.title});
}
