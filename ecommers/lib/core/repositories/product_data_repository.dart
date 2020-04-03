import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductDataRepository {
  final Map<Categories, List<Product>> _products =
      <Categories, List<Product>>{};

  Future<List<Product>> getProductListByType(Categories type) async {
    if (_products.isNotEmpty && _products.containsKey(type)) {
      return _products[type];
    }

    final cachedData = await _provideProductsByTypeFromCache(type);
    if (cachedData != null && cachedData.isNotEmpty) {
      _products.putIfAbsent(type, () => cachedData);
      return cachedData;
    }

    final remoteProducts = await _getProductsByTypeRemotely(type);
    if (remoteProducts != null && remoteProducts.isNotEmpty) {
      _products.putIfAbsent(type, () => remoteProducts);
      _saveProductListForTypeToCache(type, remoteProducts);
    }

    return remoteProducts;
  }
}

Future<List<Product>> _provideProductsByTypeFromCache(
    Categories type) async {
  final productsWrapper = await cacheDatabase.getByEqualsFilter(
      CacheDefines.products,
      ProductsCacheWrapper.fromJson,
      'key',
      EnumToString.parse(type));

  return productsWrapper != null && productsWrapper.isNotEmpty
      ? productsWrapper.first.products
      : null;
}

Future _saveProductListForTypeToCache(
    Categories type, List<Product> products) async {
  await cacheDatabase.saveMap(
    CacheDefines.products,
    ProductsCacheWrapper(EnumToString.parse(type), products).toJson(),
  );
}

Future<List<Product>> _getProductsByTypeRemotely(Categories type) async {
  // final response = await apiService.products(type);

  // if (response.isSuccessful) {
  //   return response.body;
  // }

  return null;
}
