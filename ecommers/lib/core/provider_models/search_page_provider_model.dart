import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class SearchPageProviderModel extends ChangeNotifier with BusyNotifier {
  List<Product> _recentProducts;
  List<Product> _recommendedProducts;

  List<Product> get recentProducts => _recentProducts;
  List<Product> get recommendedProducts => _recommendedProducts;

  SearchPageProviderModel() {
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
