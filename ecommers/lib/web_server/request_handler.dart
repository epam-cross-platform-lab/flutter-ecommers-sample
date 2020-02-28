import 'dart:io';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/user_model.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:http_server/http_server.dart';

class RequestHandler {
  void process(HttpRequestBody body) {
    final uri = body.request.uri.toString();

    switch (uri) {
      case ApiDefines.login:
        _handleLoginRequest(body);
        break;
      default:
        _handleUnsupportedRequest(body);
    }
  }

  Future _handleLoginRequest(HttpRequestBody body) async {
    const String jsonFile = 'login.json';

    const String validUsername = 'admin';
    const String validPassword = 'admin';

    final user = UserModel.fromJsonFactory(body.body as Map<String,dynamic>);

    if (user.username == validUsername &&
        user.password == validPassword) {
      body.request.response
        ..headers.contentType = ContentType.json
        ..write(await fileManager.readJson(jsonFile))
        ..close();

      return;
    }

    body.request.response
      ..statusCode = HttpStatus.unauthorized
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
