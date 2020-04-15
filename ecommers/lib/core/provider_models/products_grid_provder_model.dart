import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/mixins/items_loading_notifier.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart' as services;

class ProductsGridProviderModel extends ProviderModelBase
    with ItemsLoadingNotifier {
  final Categories _categoryType;
  final String _subCategory;
  final SortType _sortType;
  String _searchQuery;

  CancelableOperation<List<Product>> _fetchProductsOperation;

  List<Product> _products;
  List<Product> get products => _products;

  ProductsGridProviderModel({
    @required BuildContext context,
    Categories categoryType,
    String subCategory,
    SortType sortType,
  })  : _categoryType = categoryType,
        _subCategory = subCategory,
        _sortType = sortType,
        super(context);

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
    isitemsLoading = true;

    final products = await paginator.loadNextPage(_fetchMoreProducts);

    _products.addAll(products);

    isitemsLoading = false;
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
    return services.productService.fetchProducts(
      category: _categoryType,
      subCategory: _subCategory,
      searchQuery: _searchQuery,
      sortType: _sortType,
      from: from,
      to: to,
    );
  }
}
