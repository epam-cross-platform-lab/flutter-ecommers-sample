import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/json_serializable_converter.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/services/api_service.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/web_server/local_server.dart';
import 'package:get_it/get_it.dart';

extension GetItExtension on GetIt {
  void registerHttpClient() {
    final chopper = ChopperClient(
      baseUrl: LocalServer.uri.origin,
      services: [
        ApiService.create(),
      ],
      interceptors: [
        (Request request) async {
          if (membershipService.isNotExpired == true) {
            final headers = Map<String, String>.from(request.headers);

            headers.addAll({
              HttpHeaders.authorizationHeader:
                  'bearer ${membershipService.accessToken}',
            });

            return request.copyWith(
              headers: headers,
            );
          }

          return request;
        }
      ],
      converter: const JsonSerializableConverter(
        factories: {
          LoginModel: LoginModel.fromJsonFactory,
          Product: Product.fromJsonFactory,
          Category: Category.fromJsonFactory,
        },
      ),
    );

    registerLazySingleton<ApiService>(() => ApiService.create(chopper));
  }
}
