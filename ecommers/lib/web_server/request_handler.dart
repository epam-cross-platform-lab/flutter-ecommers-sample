import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http_server/http_server.dart';

import '../core/common/index.dart';
import '../core/models/data_models/index.dart';
import './data_access/products_data_access.dart';
import './data_access/user_data_access.dart';
import './product_query_params.dart';
import './services/authorization_service.dart';
import './services/data_provider.dart';

class RequestHandler {
  static final UserDataAccess _userDataAccess = UserDataAccess.instance;
  static final ProductsDataAccess _productsDataAccess =
      ProductsDataAccess.instance;

  static const int itemsPortion = 20;

  static String getMethod = 'GET';
  static String postMethod = 'POST';

  static void process(HttpRequestBody body) {
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
      case ApiDefines.productsLatest:
        _handleProductLatestRequest(body);
        break;
      case ApiDefines.productsRecommended:
        _handleProductsRecommendedRequest(body);
        break;
      case ApiDefines.productsRecent:
        _handleProductsRecentRequest(body);
        break;
      case ApiDefines.categories:
        _handleCategoriesRequest(body);
        break;
      case ApiDefines.notes:
        _handleNotesRequest(body);
        break;
      //TODO: add functionality
      case ApiDefines.profile:
      case ApiDefines.profileOrders:
      case ApiDefines.profilePendingPayment:
      case ApiDefines.profilePendingShipment:
      default:
        _handleUnsupportedRequest(body);
    }
  }

  static bool isNotAuthorized(HttpRequest request) {
    if (!AuthorizationService.isAuthorized(
        request.headers[HttpHeaders.authorizationHeader]?.first)) {
      request.response
        ..statusCode = HttpStatus.forbidden
        ..close();

      return true;
    }

    return false;
  }

  static Future _handleLoginRequest(HttpRequestBody body) async {
    final userMap = body.body as Map<String, dynamic>;
    final user = User.fromJsonFactory(userMap);

    if (await _userDataAccess.isUserExists(user)) {
      body.request.response
        ..headers.contentType = ContentType.json
        ..write(AuthorizationService.signToken(userMap))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
      ..close();
  }

  static Future _handleAuthorizationRequest(HttpRequestBody body) async {
    final userMap = body.body as Map<String, dynamic>;
    final user = User.fromJsonFactory(userMap);

    final validationModel = await _userDataAccess.isNewUserValid(user);

    if (validationModel.isValid) {
      await _userDataAccess.saveUser(userMap);

      body.request.response
        ..headers.contentType = ContentType.json
        ..write(AuthorizationService.signToken(userMap))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
      ..write(validationModel.error)
      ..close();
  }

  static Future _handleProductsRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final params =
        ProductQueryParams.fromQueryParameters(body.request.uri.queryParameters);

    final filteredProducts = await DataProvider.getFilteredProducts(params);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(filteredProducts))
      ..close();
  }

  static Future _handleProductLatestRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    var resultProducts = [...await DataProvider.products];
    resultProducts.sort((a, b) => b.catalogAddDate.compareTo(a.catalogAddDate));

    resultProducts = resultProducts.take(itemsPortion).toList();

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(resultProducts))
      ..close();
  }

  static Future _handleProductsRecommendedRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    const recommendedCount = 5;
    final random = Random();

    final resultProducts = (await DataProvider.products)
        .skip(random.nextInt(5000))
        .take(recommendedCount)
        .toList();

    final productsJson = json.encode(resultProducts);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(productsJson)
      ..close();
  }

  static Future _handleProductsRecentRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    if (body.request.method == getMethod) {
      _handleProductsRecentGetRequest(body);
    } else if (body.request.method == postMethod) {
      _handleProductsRecentPostRequest(body);
    }
  }

  static Future _handleProductsRecentGetRequest(HttpRequestBody body) async {
    final authorizationHeader =
        body.request.headers[HttpHeaders.authorizationHeader].first;
    final user = AuthorizationService.getJwtSubject(authorizationHeader);

    final recentlyViewedProducts =
        await _productsDataAccess.getAllRecentProducts(user.username);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(recentlyViewedProducts))
      ..close();
  }

  static Future _handleProductsRecentPostRequest(HttpRequestBody body) async {
    final authorizationHeader =
        body.request.headers[HttpHeaders.authorizationHeader].first;
    final user = AuthorizationService.getJwtSubject(authorizationHeader);

    final productMap = body.body as Map<String, dynamic>;

    _productsDataAccess.saveRecentProduct(productMap, user.username);

    body.request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  static Future _handleCategoriesRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final categoriesJson = await DataProvider.fetchCategoriesJson();

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(categoriesJson)
      ..close();
  }

  static Future _handleNotesRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final notesJson = await DataProvider.fetchNotesJson();

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(notesJson)
      ..close();
  }

  static Future _handleUnsupportedRequest(HttpRequestBody body) async {
    const String unsupported = 'Unsupported API';

    body.request.response
      ..headers.contentType = ContentType.text
      ..statusCode = HttpStatus.notImplemented
      ..write(unsupported)
      ..close();
  }
}
