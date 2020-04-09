import 'package:ecommers/core/models/data_models/category.dart';
import 'package:flutter/material.dart';

import 'index.dart';

class CategoriesProviderModel extends ProviderModelBase {
  final List<Category> categoryList;
  int _selectedCategoryIndex = 0;

  Category get selectedCategory => categoryList[_selectedCategoryIndex];

  int get selectedCategoryIndex => _selectedCategoryIndex;
  set selectedCategoryIndex(int index) {
    if (selectedCategoryIndex == index) return;

    _selectedCategoryIndex = index;

    notifyListeners();
  }

  CategoriesProviderModel(BuildContext context, this.categoryList)
      : super(context);
}
