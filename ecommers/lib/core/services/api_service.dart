import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/api_query_params.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  @Post(path: ApiDefines.login)
  Future<Response<LoginModel>> login(@Body() Map<String, dynamic> user);

  @Post(path: ApiDefines.auth)
  Future<Response<LoginModel>> auth(@Body() Map<String, dynamic> user);

  @Get(path: ApiDefines.products)
  Future<Response<List<Product>>> products({
    @Query(ApiQueryParams.category) String category,
    @Query(ApiQueryParams.subCategory) String subCategory,
    @Query(ApiQueryParams.rangeFrom) int rangeFrom,
    @Query(ApiQueryParams.rangeTo) int rangeTo,
    @Query(ApiQueryParams.searchQuery) String searchQuery,
    @Query(ApiQueryParams.sortType) String sortType,
  });

  @Get(path: ApiDefines.productsLatest)
  Future<Response<List<Product>>> productsLatest();

  @Get(path: ApiDefines.productsRecommended)
  Future<Response<List<Product>>> productRecommended();

  @Get(path: ApiDefines.productsRecent)
  Future<Response<List<Product>>> productsRecent();

  @Post(path: ApiDefines.productsRecent)
  Future<Response> productsRecentPost(@Body() Map<String, dynamic> product);

  @Get(path: ApiDefines.categories)
  Future<Response<List<Category>>> categories();

  @Get(path: ApiDefines.notes)
  Future<Response<List<Note>>> notes();
}
