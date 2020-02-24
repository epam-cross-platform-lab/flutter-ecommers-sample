import 'dart:io';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:http_server/http_server.dart';

class RequestHandler {
  final ContentType _jsonContentType = ContentType('application', 'json');
  final ContentType _textContentType =
      ContentType('text', 'plain', charset: 'utf-8');

  void process(HttpRequestBody body) {
    final uri = body.request.uri.toString();

    switch (uri) {
      case ApiDefines.login:
        _handleLoginRequest(body);
        break;
      default:
        _handleDefaultRequest(body);
    }
  }

  Future _handleLoginRequest(HttpRequestBody body) async {
    const String validUsername = 'admin';
    const String validPassword = 'admin';

    final requestBody = body.body;

    if (requestBody['username'] == validUsername &&
        requestBody['password'] == validPassword) {
      body.request.response
        ..headers.contentType = _jsonContentType
        ..write(await fileManager.readJson('login.json'))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
      ..close();
  }

  Future _handleDefaultRequest(HttpRequestBody body) async {
    body.request.response
      ..headers.contentType = _textContentType
      ..write('Default Header')
      ..close();
  }
}
