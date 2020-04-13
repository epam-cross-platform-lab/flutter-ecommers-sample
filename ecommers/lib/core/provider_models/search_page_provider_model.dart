import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class SearchPageProviderModel extends ProviderModelBase {
  List<Product> _latestProducts;
  List<Product> _recomendedProducts;

  List<Product> get latestProducts => _latestProducts;
  List<Product> get recomendedProducts => _recomendedProducts;

  SearchPageProviderModel(BuildContext context) : super(context) {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchLatestProducts(),
      _fetchRecomendedProducts(),
    });

    isBusy = false;
  }

  void clearLetestProducts() {
    _latestProducts.clear();
    notifyListeners();
  }

  Future refreshRecomendedProducts() async {
    isBusy = true;

    await _fetchRecomendedProducts();
    notifyListeners();

    isBusy = false;
  }

  Future _fetchLatestProducts() async {
    _latestProducts = await productService.fetchLatestProducts();
  }

  Future _fetchRecomendedProducts() async {
    _recomendedProducts = await productService.fetchRecomendedProducts();
  }
}
