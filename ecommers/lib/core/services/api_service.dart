import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  @Get(path: ApiDefines.productsRecommended)
  Future<Response<List<Product>>> productRecommended();

  @Get(path: ApiDefines.productsRecent)
  Future<Response<List<Product>>> productsRecent();

  @Post(path: ApiDefines.productsRecent)
  Future<Response> productsRecentPost(@Body() Map<String, dynamic> product);

  @Delete(path: ApiDefines.productsRecent)
  Future<Response> productsRecentDelete();

  @Get(path: ApiDefines.categories)
  Future<Response<List<Category>>> categories();

  @Get(path: ApiDefines.notes)
  Future<Response<List<Note>>> notes();
}
