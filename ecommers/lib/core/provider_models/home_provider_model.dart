import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';

class HomeProviderModel extends ProviderModelBase {
  List<Category> categoryList;
  List<Product> productsLatest;

  HomeProviderModel(BuildContext context) : super(context) {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchCategories(),
      _fetchLatestProducts(),
    });

    isBusy = false;
  }

  Future _fetchCategories() async {
    categoryList = await categoryService.fetchCategoryList();
  }

  Future _fetchLatestProducts() async {
    productsLatest = await productService.fetchLatestProducts();
  }
}
