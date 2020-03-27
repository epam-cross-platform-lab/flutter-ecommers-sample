import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';

class DataProvider {
  static Future<List<Product>> products = _resultProducts.future;
  static Future<List<Category>> categories = _resultCategories.future;

  static final Completer<List<Product>> _resultProducts = Completer<List<Product>>();
  static final Completer<List<Category>> _resultCategories = Completer<List<Category>>();


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

    final productsJson = await FileManager.readJson('products.json');

    (await isolatedPort.future).send(productsJson);

    await _resultProducts.future;
    isolate.kill();
  }

  static Future fetchCategories() async {
    final categoriesJson = await FileManager.readJson('categories.json');

    final categoriesMap =
        (jsonDecode(categoriesJson) as Iterable).cast<Map<String, dynamic>>();

    _resultCategories.complete(categoriesMap.map((e) => Category.fromJson(e)).toList());
  }

  static Future _getProducts(SendPort sendPort) async {
    final currentPort = ReceivePort();
    sendPort.send(currentPort.sendPort);

    final String productsString = await currentPort.first as String;

    final productsMap =
        (jsonDecode(productsString) as Iterable).cast<Map<String, dynamic>>();

    final products = productsMap.map((e) => Product.fromJson(e)).toList();

    sendPort.send(products);
  }
}
