import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/web_server/local_database.dart';

class ProductsDataAccess {
  static const String recentProductsStoreKey = 'RecentProducts';

  static final ProductsDataAccess _instance = ProductsDataAccess._();
  static ProductsDataAccess get instance => _instance;

  final LocalDatabase _database = LocalDatabase.instance;

  ProductsDataAccess._();

  Future<List<Product>> getAllRecentProducts(String key) async {
    return _database.getAll(
        '$recentProductsStoreKey$key', Product.fromJsonFactory);
  }

  Future saveRecentProduct(
    Map<String, dynamic> recentProductMap,
    String key,
  ) async {
    _database.saveMap('$recentProductsStoreKey$key', recentProductMap);
  }
}
