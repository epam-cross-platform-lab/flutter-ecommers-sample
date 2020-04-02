import 'dart:async';
import 'dart:io';

import 'package:http_server/http_server.dart';

import './request_handler.dart';
import './services/data_provider.dart';

class LocalServer {
  static const int _port = 8090;
  static final String _localHost = InternetAddress.loopbackIPv4.address;
  static HttpServer _server;

  static Uri uri = Uri(scheme: 'http', host: _localHost, port: _port);

  static Future setup() async {
    _server = await HttpServer.bind(
      _localHost,
      _port,
      shared: true,
    );

    DataProvider.fetchProducts();

    _server.transform(HttpBodyHandler()).listen((HttpRequestBody body) async {
      await Future.delayed(const Duration(seconds: 2));
      RequestHandler.process(body);
    });
  }

  static void closeConnection() {
    if (_server == null) {
      return;
    }

    _server.close();
  }
}
