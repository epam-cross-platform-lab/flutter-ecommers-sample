import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';

class ProductsGridProviderModel extends ProviderModelBase {
  CancelableOperation<List<Product>> _fetchProductsOperation;
  List<Product> _products;

  List<Product> get products => _products;

  ProductsGridProviderModel({
    @required BuildContext context,
  }) : super(context);

  Future _fetchProducts(
    Categories categoryType,
    String subCategory,
    String searchQuery,
    SortType sortType,
  ) async {
    isBusy = true;

    _fetchProductsOperation = CancelableOperation.fromFuture(
      productService.fetchProducts(
        category: categoryType,
        subCategory: subCategory,
        searchQuery: searchQuery,
        sortType: sortType,
      ),
      onCancel: () => isBusy = false,
    );

    _fetchProductsOperation.value.then((value) {
      _products = value;
      isBusy = false;
    });
  }

  Future updateProducts(
    Categories categoryType,
    String subCategory,
    String searchQuery,
    SortType sortType,
  ) async {
    if (_fetchProductsOperation != null &&
        !_fetchProductsOperation.isCompleted) {
      _fetchProductsOperation.cancel();
    }

    await _fetchProducts(categoryType, subCategory, searchQuery, sortType);
  }
}
