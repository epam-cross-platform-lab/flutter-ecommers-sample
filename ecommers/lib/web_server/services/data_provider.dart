import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/web_server/product_query_params.dart';
import 'package:ecommers/web_server/services/product_comparator.dart';
import 'package:ecommers/extensions/index.dart';

class DataProvider {
  static const String productsFilename = 'products.json';
  static const String categoriesFilename = 'categories.json';
  static const String notesFilename = 'notes.json';

  static Future<List<Product>> products = _resultProducts.future;

  static final Completer<List<Product>> _resultProducts =
      Completer<List<Product>>();

  static Future fetchProducts() async {
    final ReceivePort mainPort = ReceivePort();
    final Completer<SendPort> isolatedPort = Completer<SendPort>();

    final isolate = await Isolate.spawn(_getProducts, mainPort.sendPort);

    mainPort.listen((dynamic resultData) async {
      if (resultData is SendPort) {
        isolatedPort.complete(resultData);
      } else if (resultData is List<Product>) {
        _resultProducts.complete(resultData);
      }
    });

    final productsJson = await FileManager.readJson(productsFilename);

    (await isolatedPort.future).send(productsJson);

    await _resultProducts.future;
    isolate.kill();
  }

  static Future<String> fetchCategoriesJson() async {
    return FileManager.readJson(categoriesFilename);
  }

  static Future<String> fetchNotesJson() async {
    return FileManager.readJson(notesFilename);
  }

  static Future _getProducts(SendPort sendPort) async {
    final currentPort = ReceivePort();
    sendPort.send(currentPort.sendPort);

    final String productsString = await currentPort.first as String;

    final products =
        json.decodeList<Product>(productsString, Product.fromJsonFactory);

    sendPort.send(products);
  }

  static Future<List<Product>> getFilteredProducts(
      ProductQueryParams params) async {
    const int defaultItemsPortion = 20;

    Iterable<Product> queryProducts = [...await products];
    List<Product> resultProducts;

    final categories = json.decodeList<Category>(
      await fetchCategoriesJson(),
      Category.fromJsonFactory,
    );

    if (params.category != null) {
      queryProducts = queryProducts
          .where((p) => _isCategoryMatched(categories, p, params.category));
    }
    if (params.subCategory.isNotNullOrEmpty) {
      queryProducts =
          queryProducts.where((p) => p.subCategory == params.subCategory);
    }
    if (params.rangeFrom != null && params.rangeTo != null) {
      queryProducts =
          queryProducts.skip(params.rangeFrom).take(params.rangeFrom);
    }
    if (params.searchQuery.isNotNullOrEmpty) {
      queryProducts = queryProducts.where(
        (p) => p.title.toLowerCase().contains(params.searchQuery.toLowerCase()),
      );
    }

    resultProducts = queryProducts.toList();
    if (params.sortType != null) {
      final compareFunction = ProductComparator.bySortType(params.sortType);
      resultProducts.sort(compareFunction);
    }

    if (resultProducts.length > defaultItemsPortion) {
      resultProducts = resultProducts.take(defaultItemsPortion).toList();
    }

    return resultProducts;
  }

  static bool _isCategoryMatched(
      List<Category> categories, Product product, Categories categoryType) {
    final categoryTitle =
        categories.firstWhere((c) => c.type == categoryType).title;

    return product.category == categoryTitle;
  }
}
