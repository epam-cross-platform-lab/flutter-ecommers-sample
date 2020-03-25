
import 'package:ecommers/core/models/category_model.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';

class HomeProviderModel extends ProviderModelBase {
  List<CategoryModel> categoryList;

  HomeProviderModel(BuildContext context) : super(context) {
    fetchCategories();
  }

  Future fetchCategories() async {
    isBusy = true;

    categoryList = await categoryService.getCategoryList();

    isBusy = false;
  }
}