import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/category_model.dart';

import '../models/product.dart';

class ProductsProvider {
  static List<Product> products;
  static List<CategoryModel> categories;

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

    int categoryId = 1;

    categories = products
        .map((e) => e.category)
        .toSet()
        .map((e) => CategoryModel(categoryId++, e, <String>[]))
        .toList(growable: false);
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
