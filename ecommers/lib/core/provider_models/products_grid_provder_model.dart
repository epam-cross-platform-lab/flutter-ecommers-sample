import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class ProductsGridProviderModel extends ProviderModelBase {
  final Categories _categoryType;

  ProductsGridProviderModel(BuildContext context, Categories type)
      : _categoryType = type,
        super(context);

  Future<List<Product>> getData() async {
    isBusy = true;

    final productList = await productService.getProductList(_categoryType);

    isBusy = false;

    return productList;
  }
}
