import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';

class ProductsGridProviderModel extends ProviderModelBase {
  List<Product> _products;

  List<Product> get products => _products;

  ProductsGridProviderModel(
    BuildContext context,
    Categories categoryType,
    String subCategory,
    SortType sortType,
  ) : super(context) {
    getData(categoryType, subCategory, sortType);
  }

  Future getData(
      Categories categoryType, String subCategory, SortType sortType) async {
    isBusy = true;

    _products = await productService.fetchProducts(
        category: categoryType, subCategory: subCategory, sortType: sortType);

    isBusy = false;
  }
}
