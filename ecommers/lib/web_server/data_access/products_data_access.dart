import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/web_server/local_database.dart';

class ProductsDataAccess {
  static final ProductsDataAccess _instance = ProductsDataAccess._();
  static ProductsDataAccess get instance => _instance;

  final LocalDatabase _database = LocalDatabase.instance;

  ProductsDataAccess._();

  String _generateRecentKey(String key) {
    const String recentProductsStoreKey = 'RecentProducts';

    return '$recentProductsStoreKey$key';
  }

  Future<List<Product>> getAllRecentProducts(String key) async {
    return _database.getAll(_generateRecentKey(key), Product.fromJsonFactory);
  }

  Future saveRecentProduct(
    Map<String, dynamic> recentProductMap,
    String key,
  ) async {
    _database.saveMap(_generateRecentKey(key), recentProductMap);
  }

  Future deleteRecentProducts(
    String key,
  ) async {
    _database.deleteAll(_generateRecentKey(key));
  }
}
