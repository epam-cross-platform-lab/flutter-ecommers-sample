import 'package:ecommers/web_server/local_database.dart';
import 'package:ecommers/web_server/models/index.dart';

class ProductsDataAccess {
  static const String recentProductsStoreKey = 'RecentProducts';

  static final ProductsDataAccess _instance = ProductsDataAccess._();
  static ProductsDataAccess get instance => _instance;

  final LocalDatabase _database = LocalDatabase.instance;

  ProductsDataAccess._();

  List<Product> _allRecentProducts;

  Future<List<Product>> getAllRecentProducts(String key) async {
    return _allRecentProducts ??= await _database.getAll(
        '$recentProductsStoreKey$key', Product.fromJsonFactory);
  }

  Future saveRecentProduct(
    Map<String, dynamic> recentProductMap,
    String username,
  ) async {
    _allRecentProducts ??= [];
    _allRecentProducts.add(Product.fromJsonFactory(recentProductMap));

    await _database.saveMap(
        '$recentProductsStoreKey$username', recentProductMap);
  }
}
