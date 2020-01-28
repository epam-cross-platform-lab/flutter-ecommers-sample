import 'package:flutter/material.dart';

class CategoryItemModel {
  final Gradient gradient;
  final Color shadowColor;
  final String imagePath;
  final String title;

  CategoryItemModel(
      {this.gradient,
      this.shadowColor,
      this.imagePath,
      this.title});
}
