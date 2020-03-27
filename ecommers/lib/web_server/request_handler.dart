import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ecommers/core/common/api_query_params.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/web_server/data_access/products_data_access.dart';
import 'package:ecommers/web_server/services/product_comparator.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:http_server/http_server.dart';
import '../core/common/index.dart';
import '../extensions/string_extension.dart';

import 'data_access/user_data_access.dart';

import 'services/authorization_service.dart';
import 'services/data_provider.dart';

class RequestHandler {
  static final UserDataAccess _userDataAccess = UserDataAccess.instance;
  static final ProductsDataAccess _productsDataAccess =
      ProductsDataAccess.instance;

  static String getMethod = 'GET';
  static String postMethod = 'GET';

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
      case ApiDefines.productsLatest:
        _handleProductLatestRequest(body);
        break;
      case ApiDefines.productsRecommended:
        _handleProductsRecommendedRequest(body);
        break;
      case ApiDefines.productsRecent:
        if (body.request.method == getMethod) {
          _handleProductsRecentRequest(body);
        } else if (body.request.method == postMethod) {
          _handleProductsRecentPostRequest(body);
        }
        break;
      case ApiDefines.categories:
        _handleCategoriesRequest(body);
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

  bool isNotAuthorized(HttpRequest request) {
    if (AuthorizationService.isAuthorized(
        request.headers.value(HttpHeaders.authorizationHeader))) {
      request.response
        ..statusCode = HttpStatus.forbidden
        ..close();

      return true;
    }

    return false;
  }

  Future _handleLoginRequest(HttpRequestBody body) async {
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

  Future _handleAuthorizationRequest(HttpRequestBody body) async {
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

  Future _handleProductsRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    const int itemsPortion = 20;

    Iterable<Product> resultProducts = await DataProvider.products;
    final queryParameters = body.request.uri.queryParameters;

    final category = queryParameters[ApiQueryParams.category];
    final subCategory = queryParameters[ApiQueryParams.subCategory];
    final rangeFrom = queryParameters[ApiQueryParams.rangeFrom];
    final rangeTo = queryParameters[ApiQueryParams.rangeTo];
    final searchQuery = queryParameters[ApiQueryParams.searchQuery];
    final sortType = queryParameters[ApiQueryParams.sortType];

    if (category.isNotNullOrEmpty) {
      resultProducts = resultProducts.where((p) => p.category == category);
    } else if (subCategory.isNotNullOrEmpty) {
      resultProducts =
          resultProducts.where((p) => p.subCategory == subCategory);
    } else if (rangeFrom.isNotNullOrEmpty && rangeTo.isNotNullOrEmpty) {
      resultProducts =
          resultProducts.skip(int.parse(rangeFrom)).take(int.parse(rangeTo));
    } else if (searchQuery.isNotNullOrEmpty) {
      resultProducts =
          resultProducts.where((p) => p.title.contains(searchQuery));
    }

    if (resultProducts.length > itemsPortion) {
      resultProducts = resultProducts.take(itemsPortion);
    } else if (sortType.isNotNullOrEmpty) {
      final compareFunction = ProductComparator.bySortType(
          EnumToString.fromString(SortType.values, sortType));
      resultProducts.toList().sort(compareFunction);
    }

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(resultProducts))
      ..close();
  }

  Future _handleProductLatestRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    const latestProductsCount = 20;

    final resultProducts = [...await DataProvider.products];
    resultProducts.sort((a, b) => b.catalogAddDate.compareTo(a.catalogAddDate));
    resultProducts.take(latestProductsCount);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(resultProducts))
      ..close();
  }

  Future _handleProductsRecommendedRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    const recommendedCount = 5;
    final random = Random();

    final resultProducts = (await DataProvider.products)
        .skip(random.nextInt(5000))
        .take(recommendedCount);
    final productsJson = json.encode(resultProducts);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(productsJson)
      ..close();
  }

  Future _handleProductsRecentRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final user = AuthorizationService.getJwtSubject(
        body.request.headers.value(HttpHeaders.authorizationHeader));
    final recentlyViewedProducts =
        await _productsDataAccess.getAllRecentProducts(user.username);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(json.encode(recentlyViewedProducts))
      ..close();
  }

  Future _handleProductsRecentPostRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final productMap = body.body as Map<String, dynamic>;

    final user = AuthorizationService.getJwtSubject(
        body.request.headers.value(HttpHeaders.authorizationHeader));

    _productsDataAccess.saveRecentProduct(productMap, user.username);

    body.request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  Future _handleCategoriesRequest(HttpRequestBody body) async {
    if (isNotAuthorized(body.request)) return;

    final categoriesJson = json.encode(await DataProvider.categories);

    body.request.response
      ..headers.contentType = ContentType.json
      ..write(categoriesJson)
      ..close();
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
