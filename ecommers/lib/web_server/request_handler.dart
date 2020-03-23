import 'dart:io';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/web_server/data_access/user_data_access.dart';
import 'package:http_server/http_server.dart';

import 'models/user.dart';

class RequestHandler {
  static final UserDataAccess _userDataAccess = UserDataAccess.instance;

  void process(HttpRequestBody body) {
    final path = body.request.uri.path.toString();

    switch (path) {
      case ApiDefines.login:
        _handleLoginRequest(body);
        break;
      case ApiDefines.auth:
        _handleAuthorizationRequest(body);
        break;
      case ApiDefines.products:
        _handleProductsRequest(body);
        break;
      default:
        _handleUnsupportedRequest(body);
    }
  }

  Future _handleLoginRequest(HttpRequestBody body) async {
    const String jsonFile = 'login.json';

    final userMap = body.body as Map<String, dynamic>;
    final user = User.fromJsonFactory(userMap);

    if (await _userDataAccess.isUserExists(user)) {
      body.request.response
        ..headers.contentType = ContentType.json
        ..write(await FileManager.readJson(jsonFile))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
      ..close();
  }

  Future _handleAuthorizationRequest(HttpRequestBody body) async {
    const String jsonFile = 'login.json';

    final userMap = body.body as Map<String, dynamic>;
    final user = User.fromJsonFactory(userMap);

    final validationModel = await _userDataAccess.isNewUserValid(user);

    if (validationModel.isValid) {
      await _userDataAccess.saveUser(userMap);

      body.request.response
        ..headers.contentType = ContentType.json
        ..write(await FileManager.readJson(jsonFile))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
      ..write(validationModel.error)
      ..close();
  }

  Future _handleProductsRequest(HttpRequestBody body) async {
    final categoryType =
        getCategoryType(body.request.uri.queryParameters['type']);
    final products = await _getProducts(categoryType);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(products)
      ..close();
  }

  Categories getCategoryType(String typeString) {
    return Categories.values.firstWhere((e) => e.toString() == typeString);
  }

  Future<String> _getProducts(Categories type) async {
    String jsonFileName = '';

    switch (type) {
      case Categories.shoes:
        jsonFileName = 'products_shoes.json';
        break;
      case Categories.beauty:
        jsonFileName = 'products_beauty.json';
        break;
      case Categories.apparel:
      default:
        jsonFileName = 'products_apparel.json';
    }

    return FileManager.readJson(jsonFileName);
  }

  Future _handleUnsupportedRequest(HttpRequestBody body) async {
    const String unsupported = 'Unsupported API';

    body.request.response
      ..headers.contentType = ContentType.text
      ..statusCode = HttpStatus.notImplemented
      ..write(unsupported)
      ..close();
  }
}
