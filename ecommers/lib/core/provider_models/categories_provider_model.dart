import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/data_models/category.dart';
import 'package:flutter/material.dart';

class CategoriesProviderModel extends ChangeNotifier with BusyNotifier {
  final List<Category> categoryList;
  int _selectedCategoryIndex = 0;

  Category get selectedCategory => categoryList[_selectedCategoryIndex];

  int get selectedCategoryIndex => _selectedCategoryIndex;
  set selectedCategoryIndex(int index) {
    if (selectedCategoryIndex == index) return;

    _selectedCategoryIndex = index;

    notifyListeners();
  }

  CategoriesProviderModel(this.categoryList);
}
