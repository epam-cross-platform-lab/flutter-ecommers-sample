import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';

class DataProvider {
  static const String productsFilename = 'products.json';
  static const String categoriesFilename = 'categories.json';
  static const String notesFilename = 'notes.json';

  static Future<List<Product>> products = _resultProducts.future;

  static final Completer<List<Product>> _resultProducts = Completer<List<Product>>();


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

    final productsMap =
        (jsonDecode(productsString) as Iterable).cast<Map<String, dynamic>>();

    final products = productsMap.map((e) => Product.fromJson(e)).toList();

    sendPort.send(products);
  }
}
