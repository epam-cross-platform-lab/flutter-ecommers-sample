import 'dart:async';

import 'package:ecommers/core/mixins/index.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/mixins/items_loading_notifier.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/index.dart' as services;

class HomeProviderModel extends ChangeNotifier
    with ItemsLoadingNotifier, BusyNotifier {
  List<Category> _categoryList;
  List<Product> _productsLatest;
  List<Note> _notesLatest;

  List<Category> get categoryList => _categoryList;
  List<Product> get productsLatest => _productsLatest;
  List<Note> get notesLatest => _notesLatest;

  HomeProviderModel() {
    fetchAllData();
  }

  Future fetchAllData() async {
    isBusy = true;

    await Future.wait({
      _fetchCategories(),
      _fetchLatestProducts(),
      _fetchLatestNotes(),
    });

    isBusy = false;
  }

  Future _fetchCategories() async {
    _categoryList = await services.categoryService.fetchCategoryList();
  }

  Future _fetchLatestProducts() async {
    _productsLatest = await paginator
        .loadNextPage(services.productService.fetchLatestProducts);
  }

  Future _fetchLatestNotes() async {
    _notesLatest = await services.noteService.fetchLatestNotes();
  }

  @override
  FutureOr<void> loadMoreProducts() async {
    isItemsLoading = true;

    final products = await paginator
        .loadNextPage(services.productService.fetchLatestProducts);

    _productsLatest.addAll(products);

    isItemsLoading = false;
  }
}
