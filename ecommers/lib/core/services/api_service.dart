import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  @Post(path: ApiDefines.login)
  Future<Response<LoginModel>> login(@Body() Map<String, dynamic> login);

  @Post(path: ApiDefines.auth)
  Future<Response<LoginModel>> auth(@Body() Map<String, dynamic> auth);

  @Get(path: ApiDefines.products)
  Future<Response<List<ProductModel>>> products(@Query() Categories type);
}
