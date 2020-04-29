import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/web_server/query_params/index.dart';
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
    if (_resultProducts.isCompleted) return;

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
    List<Product> resultProducts = [...await products].toList();

    final categories = json.decodeList<Category>(
      await fetchCategoriesJson(),
      Category.fromJsonFactory,
    );

    if (params.category != null) {
      resultProducts = resultProducts
          .where((p) => _isCategoryMatched(categories, p, params.category))
          .toList();
    }
    if (params.subCategory.isNotNullOrEmpty) {
      resultProducts = resultProducts
          .where((p) => p.subCategory == params.subCategory)
          .toList();
    }
    if (params.searchQuery.isNotNullOrEmpty) {
      resultProducts = resultProducts
          .where((p) =>
              p.title.toLowerCase().contains(params.searchQuery.toLowerCase()))
          .toList();
    }
    if (params.sortType != null) {
      final compareFunction = ProductComparator.bySortType(params.sortType);
      resultProducts.sort(compareFunction);
    }
    if (params.from != null && params.to != null) {
      resultProducts = resultProducts
          .skip(params.from)
          .take(params.to - params.from)
          .toList();
    } else {
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
