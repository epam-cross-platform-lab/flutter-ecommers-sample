import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/factories/category_factory/consts.dart';
import 'package:ecommers/ui/widgets/gradient_category_label.dart';
import 'package:flutter/material.dart';

class CategoryFactory {
   Iterable<Widget> createAllCategories(Iterable<Categories> categories) {
    
    return categories.map((category) => GradientCategoryLabel(
          backgroundGradient: categoryButtons[category].gradient,
          imagePath: categoryButtons[category].imagePath,
          shadowColor: categoryButtons[category].shadowColor,
          imageCategoryPadding: categoryButtons[category].imageCategoryPadding,
        ));
  }
}
