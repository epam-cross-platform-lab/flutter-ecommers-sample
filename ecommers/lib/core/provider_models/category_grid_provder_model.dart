import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class ProductsGridProviderModel extends ProviderModelBase {
  Categories _categoryType;

  Categories get categoryType => _categoryType;

  set categoryType(Categories type) {
    _categoryType = type;
    notifyListeners();
  }

  ProductsGridProviderModel(BuildContext context) : super(context);

  Future<List<ProductModel>> getData(Categories type) async {
    isBusy = true;

    final productList = await productService.getProductList(type);

    isBusy = false;

    return productList;
  }
}
