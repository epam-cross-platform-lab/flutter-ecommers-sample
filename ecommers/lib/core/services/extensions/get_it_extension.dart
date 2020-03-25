import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/json_serializable_converter.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/services/api_service.dart';
import 'package:ecommers/web_server/local_server.dart';
import 'package:get_it/get_it.dart';

extension GetItExtension on GetIt {
  void registerHttpClient() {
    final chopper = ChopperClient(
      baseUrl: LocalServer.uri.origin,
      services: [
        ApiService.create(),
      ],
      converter: const JsonSerializableConverter(
        factories: {
          LoginModel: LoginModel.fromJsonFactory,
          ProductModel: ProductModel.fromJsonFactory,
          CategoryModel: CategoryModel.fromJsonFactory,
        },
      ),
    );

    registerLazySingleton<ApiService>(() => ApiService.create(chopper));
  }
}
