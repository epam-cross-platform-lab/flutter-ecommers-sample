import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:ecommers/core/common/file_manager.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/web_server/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http_server/http_server.dart';

class LocalServer {
  static const int _port = 8090;
  static final String _localHost = InternetAddress.loopbackIPv4.address;
  static HttpServer _server;

  static Uri uri = Uri(scheme: 'http', host: _localHost, port: _port);

  static List<Product> products;

  static Future setup() async {
    _server = await HttpServer.bind(
      _localHost,
      _port,
      shared: true,
    );

    //products = await compute(_parseProducts, '${FileManager.jsonPath}products.json');
    
    _server.transform(HttpBodyHandler()).listen((HttpRequestBody body) async {
      await Future.delayed(const Duration(seconds: 2));
      requestHandler.process(body);
    });
  }

  static void closeConnection() {
    if (_server == null) {
      return;
    }

    _server.close();
  }

  // static Future _fetchData() async {
  //   final ReceivePort receivePort = ReceivePort();

  //   await Isolate.spawn(_fetchDataCallback, receivePort.sendPort);

  //   final isolatePort = await receivePort.first as SendPort;

  //   isolatePort.send('products.json');

  //   products = await receivePort.first as List<Product>;
  // }

  // static Future _fetchDataCallback(SendPort incomingPort) async {
  //   final isolatePort = ReceivePort();
  //   incomingPort.send(isolatePort.sendPort);

  //   isolatePort.listen((jsonFilename) async {
  //     incomingPort.send(
  //         await _parseProducts(await FileManager.readJson('products.json')));
  //   });
  // }

  static Future<List<Product>> _parseProducts(String jsonPath) async {
    final data = await rootBundle.load(jsonPath);
    final json = utf8.decode(data.buffer.asUint8List());

    final Iterable productsMap = json as Iterable;

    return productsMap
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
