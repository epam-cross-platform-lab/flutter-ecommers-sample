import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import '../models/index.dart';

class DataProvider {
  static List<Product> products;
  static List<Category> categories;

  static Future fetchProducts() async {
    final ReceivePort mainPort = ReceivePort();
    final Completer<SendPort> isolatedPort = Completer<SendPort>();
    final Completer<List<Product>> resultProducts = Completer<List<Product>>();

    final isolate = await Isolate.spawn(_getProducts, mainPort.sendPort);

    mainPort.listen((dynamic resultData) async {
      if (resultData is SendPort) {
        isolatedPort.complete(resultData);
      } else if (resultData is List<Product>) {
        resultProducts.complete(resultData);
      }
    });

    final productsJson = await FileManager.readJson('products.json');

    (await isolatedPort.future).send(productsJson);

    products = await resultProducts.future;
    isolate.kill();
  }

  static Future fetchCategories() async {
    final categoriesJson = await FileManager.readJson('categories.json');

    final categoriesMap =
        (jsonDecode(categoriesJson) as Iterable).cast<Map<String, dynamic>>();

    categories = categoriesMap.map((e) => Category.fromJson(e)).toList();
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
