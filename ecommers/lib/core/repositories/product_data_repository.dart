import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/cache_wrappers/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductDataRepository {
  static const categoryFilterField = 'category';
  static const subCategoryFilterField = 'subCategory';
  static const expirationCacheDays = 1;

  Future<List<Product>> getProducts({
    String category,
    String subCategory,
    int rangeFrom,
    int rangeTo,
    String searchQuery,
    SortType sortType,
  }) async {
    final cachedData = await _provideProductsFromCache(category, subCategory);
    if (cachedData?.products?.isNotEmpty == true) {
      if (DateTime.now().difference(cachedData.lastUpdatedDate).inDays >= expirationCacheDays) {
        await cacheDatabase.deleteDataByFilter(CacheDefines.products, {
          categoryFilterField: category,
          subCategoryFilterField: subCategory
        });
      } else {
        return cachedData.products.toList();
      }
    }

    final remoteProducts = await _fetchAllProducts(
      category: category,
      subCategory: subCategory,
      rangeFrom: rangeFrom,
      rangeTo: rangeTo,
      searchQuery: searchQuery,
      sortType: sortType,
    );
    if (remoteProducts != null && remoteProducts.isNotEmpty) {
      _saveProductsToCache(category, subCategory, remoteProducts);
    }

    return remoteProducts;
  }

  Future<List<Product>> getLatestProducts() async {
    final cachedData = await _provideLatestProductsFromCache();
    if (cachedData?.products?.isNotEmpty == true) {
      if (DateTime.now().difference(cachedData.lastUpdatedDate).inDays >= expirationCacheDays) {
        await cacheDatabase.dropData(CacheDefines.latestProducts);
      } else {
        return cachedData.products;
      }
    }

    final remoteProducts = await _fetchLatestProducts();
    if (remoteProducts != null && remoteProducts.isNotEmpty) {
      _saveLatestProductsToCache(remoteProducts);
    }

    return remoteProducts;
  }

  Future<ProductsCacheWrapper> _provideProductsFromCache(
      String category, String subCategory) async {
    final productsWrapper = await cacheDatabase.getByEqualsFilter(
        CacheDefines.products,
        ProductsCacheWrapper.fromJson,
        {categoryFilterField: category, subCategoryFilterField: subCategory});

    return productsWrapper != null && productsWrapper.isNotEmpty
        ? productsWrapper?.first
        : null;
  }

  Future<ProductsCacheWrapper> _provideLatestProductsFromCache() async {
    final productsWrapper = await cacheDatabase.getAll(
        CacheDefines.latestProducts, ProductsCacheWrapper.fromJson);

    return productsWrapper != null && productsWrapper.isNotEmpty
        ? productsWrapper.first
        : null;
  }

  Future _saveProductsToCache(
      String category, String subCategory, List<Product> products) async {
    await cacheDatabase.saveMap(
        CacheDefines.products,
        json.decode(json.encode(ProductsCacheWrapper(
                category, subCategory, DateTime.now(), products)))
            as Map<String, dynamic>);
  }

  Future _saveLatestProductsToCache(List<Product> products) async {
    await cacheDatabase.saveMap(
        CacheDefines.latestProducts,
        json.decode(json
                .encode(LatestProductsCacheWrapper(DateTime.now(), products)))
            as Map<String, dynamic>);
  }

  Future<List<Product>> _fetchAllProducts({
    String category,
    String subCategory,
    int rangeFrom,
    int rangeTo,
    String searchQuery,
    SortType sortType,
  }) async {
    final response = await apiService.products(
      category: category,
      subCategory: subCategory,
      rangeFrom: rangeFrom,
      rangeTo: rangeTo,
      searchQuery: searchQuery,
      sortType: EnumToString.parse(sortType),
    );

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }

  Future<List<Product>> _fetchLatestProducts() async {
    final response = await apiService.productsLatest();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
