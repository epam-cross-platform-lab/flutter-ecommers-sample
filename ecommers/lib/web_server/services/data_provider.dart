import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future _createRecord(Product product) async {
    final databaseReference = Firestore.instance;
    final collectionRef = databaseReference.collection("products");

    final json = product.toJson();
    try {
      await databaseReference
          .collection("products")
          .document(product.id.toString())
          .setData(json, merge: true);
    } catch (ex) {
      print(ex.toString());
    }
  }

  static Future _createRecordsBatch(List<Product> products) async {
    final db = Firestore.instance;
    try {
      final batch = db.batch();

      for (final product in products) {
        final json = product.toJson();
        final document =
            db.collection("products").document(product.id.toString());

        batch.setData(document, json);
      }

      await batch.commit();
    } catch (ex) {
      print(ex.toString());
    }
  }

  static Future<List<Product>> getFilteredProducts(
      ProductQueryParams params) async {
    const int defaultItemsPortion = 20;

    List<Product> resultProducts = [...await products].toList();

    print(resultProducts.length);

    // for (int i = 0; i < resultProducts.length; i++) {
    //   print(i);
    //   await _createRecord(resultProducts[i]);
    // }

    final count = 400;

    // for (int i = 0; i < resultProducts.length - 600; i += count) {
    //   print(i);
    //   await _createRecordsBatch(resultProducts.skip(i).take(count).toList());
    // }

    // await _createRecordsBatch(resultProducts.skip(4400).take(400).toList());
    // await _createRecordsBatch(resultProducts.skip(4800).take(200).toList());

    // await _createRecord(resultProducts[0]);
    // await _createRecordsBatch(resultProducts.take(400).toList());

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
