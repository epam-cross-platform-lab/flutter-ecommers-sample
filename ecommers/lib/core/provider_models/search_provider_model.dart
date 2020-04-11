import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class SearchProviderModel extends ProviderModelBase {
  List<Product> _productsLatest;
  List<Product> _productsRecomendation;

  List<Product> get productsLatest => _productsLatest;
  List<Product> get productsRecomendation => _productsRecomendation;

  SearchProviderModel(BuildContext context) : super(context) {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchProductsLatest(),
      _fetchProductsRecomendation(),
    });

    isBusy = false;
  }

  void clearProductsLetest() {
    _productsLatest.clear();
    notifyListeners();
  }

  Future refreshProductsRecomendation() async {
    isBusy = true;

    await _fetchProductsRecomendation();
    notifyListeners();

    isBusy = false;
  }

  Future _fetchProductsLatest() async {
    _productsLatest = await productService.fetchRecomendetioProducts();
  }

  Future _fetchProductsRecomendation() async {
    _productsRecomendation = await productService.fetchLatestProducts();
  }
}
