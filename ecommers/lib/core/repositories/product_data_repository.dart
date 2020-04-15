import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductDataRepository {
  static const filterField = 'key';

  Future<List<Product>> getProducts({
    String category,
    String subCategory,
    int rangeFrom,
    int rangeTo,
    String searchQuery,
    SortType sortType,
  }) async {
    final cachedData = await _provideProductsFromCache(category);
    if (cachedData?.products?.isNotEmpty == true) {
      if (DateTime.now().difference(cachedData.lastUpdatedDate).inDays >= 1) {
        await cacheDatabase.deleteDataByFilter(
            CacheDefines.products, filterField, category);
      } else {
        return cachedData.products
            .where((product) => product.subCategory == subCategory)
            .toList();
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
      _saveProductsToCache(category, remoteProducts);
    }

    return remoteProducts
        .where((product) => product.subCategory == subCategory)
        .toList();
  }

  Future<List<Product>> getLatestProducts(int from, int to) async {
    final cachedData = await _provideLatestProductsFromCache();
    if (cachedData?.products?.isNotEmpty == true) {
      if (DateTime.now().difference(cachedData.lastUpdatedDate).inDays >= 1) {
        await cacheDatabase.dropData(CacheDefines.latestProducts);
      } else {
        return cachedData.products;
      }
    }

    final remoteProducts = await _fetchLatestProducts(from, to);
    if (remoteProducts != null && remoteProducts.isNotEmpty) {
      _saveLatestProductsToCache(remoteProducts);
    }

    return remoteProducts;
  }

  Future<ProductsCacheWrapper> _provideProductsFromCache(
      String category) async {
    final productsWrapper = await cacheDatabase.getByEqualsFilter(
        CacheDefines.products,
        ProductsCacheWrapper.fromJson,
        filterField,
        category);

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

  Future _saveProductsToCache(String category, List<Product> products) async {
    await cacheDatabase.saveMap(
        CacheDefines.products,
        json.decode(json.encode(
                ProductsCacheWrapper(category, DateTime.now(), products)))
            as Map<String, dynamic>);
  }

  Future _saveLatestProductsToCache(List<Product> products) async {
    await cacheDatabase.saveMap(
        CacheDefines.latestProducts,
        json.decode(json.encode(ProductsCacheWrapper(
                CacheDefines.latestProducts, DateTime.now(), products)))
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
      from: rangeFrom,
      to: rangeTo,
      searchQuery: searchQuery,
      sortType: EnumToString.parse(sortType),
    );

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }

  Future<List<Product>> _fetchLatestProducts(int from, int to) async {
    final response = await apiService.productsLatest(from, to);

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
