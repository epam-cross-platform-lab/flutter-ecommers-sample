import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class SearchPageProviderModel extends ProviderModelBase {
  List<Product> _recentProducts;
  List<Product> _recommendedProducts;

  List<Product> get recentProducts => _recentProducts;
  List<Product> get recommendedProducts => _recommendedProducts;

  SearchPageProviderModel(BuildContext context) : super(context) {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchRecentProducts(),
      _fetchRecommendedProducts(),
    });

    isBusy = false;
  }

  void clearRecentProducts() {
    productService.recentProductsDelete();
    _recentProducts.clear();
    notifyListeners();
  }

  Future updateRecentProducts() async {
    isBusy = true;

    await _fetchRecentProducts();

    isBusy = false;
  }

  Future refreshRecommendedProducts() async {
    isBusy = true;

    await _fetchRecommendedProducts();
    notifyListeners();

    isBusy = false;
  }

  Future _fetchRecentProducts() async {
    _recentProducts = await productService.fetchRecentProducts();
  }

  Future _fetchRecommendedProducts() async {
    _recommendedProducts = await productService.fetchRecommendedProducts();
  }
}
