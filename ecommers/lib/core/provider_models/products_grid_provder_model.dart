import 'package:async/async.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';

class ProductsGridProviderModel extends ChangeNotifier
    with BusyNotifier, ItemsLoadingNotifier {
  final Categories _categoryType;
  final String _subCategory;
  final SortType _sortType;
  String _searchQuery;

  CancelableOperation<List<Product>> _fetchProductsOperation;

  List<Product> _products;
  List<Product> get products => _products;

  ProductsGridProviderModel({
    Categories categoryType,
    String subCategory,
    SortType sortType,
  })  : _categoryType = categoryType,
        _subCategory = subCategory,
        _sortType = sortType;

  Future updateProducts(String searchQuery) async {
    if (_fetchProductsOperation != null &&
        !_fetchProductsOperation.isCompleted) {
      _fetchProductsOperation.cancel();
    }

    _searchQuery = searchQuery;

    _products = await _fetchProducts();
  }

  @override
  Future loadMoreProducts() async {
    isItemsLoading = true;

    final products = await paginator.loadNextPage(_fetchMoreProducts);

    _products.addAll(products);

    isItemsLoading = false;
  }

  Future<List<Product>> _fetchProducts() async {
    isBusy = true;

    paginator.reset();

    _fetchProductsOperation = CancelableOperation.fromFuture(
      paginator.loadNextPage(_fetchMoreProducts),
      onCancel: () => isBusy = false,
    );

    return _fetchProductsOperation.value.then(
      (value) {
        isBusy = false;
        return value;
      },
    );
  }

  Future<List<Product>> _fetchMoreProducts(int from, int to) {
    return productService.fetchProducts(
      category: _categoryType,
      subCategory: _subCategory,
      searchQuery: _searchQuery,
      sortType: _sortType,
      from: from,
      to: to,
    );
  }
}
