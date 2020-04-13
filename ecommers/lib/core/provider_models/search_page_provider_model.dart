import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class SearchPageProviderModel extends ProviderModelBase {
  List<Product> _latestProducts;
  List<Product> _recommendedProducts;

  List<Product> get latestProducts => _latestProducts;
  List<Product> get recommendedProducts => _recommendedProducts;

  SearchPageProviderModel(BuildContext context) : super(context) {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchLatestProducts(),
      _fetchRecommendedProducts(),
    });

    isBusy = false;
  }

  void clearLetestProducts() {
    _latestProducts.clear();
    notifyListeners();
  }

  Future refreshRecommendedProducts() async {
    isBusy = true;

    await _fetchRecommendedProducts();
    notifyListeners();

    isBusy = false;
  }

  Future _fetchLatestProducts() async {
    _latestProducts = await productService.fetchLatestProducts();
  }

  Future _fetchRecommendedProducts() async {
    _recommendedProducts = await productService.fetchRecommendedProducts();
  }
}
