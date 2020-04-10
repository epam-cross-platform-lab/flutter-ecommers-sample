import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/cache_wrappers/categories_cache_wrapper.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/index.dart';

class CategoryDataRepository {
  Future<List<Category>> getCategories() async {
    final cachedData = await _provideCategoriesFromCache();

    if (cachedData?.categories?.isNotEmpty == true) {
      if (DateTime.now().difference(cachedData.lastUpdatedDate).inDays >= 1) {
        await cacheDatabase.dropData(CacheDefines.categories);
      } else {
        return cachedData.categories;
      }
    }

    final remoteCategories = await _fetchCategoryList();
    if (remoteCategories != null && remoteCategories.isNotEmpty) {
      _saveCategoriesToCache(remoteCategories);
    }

    return remoteCategories;
  }

  Future<CategoriesCacheWrapper> _provideCategoriesFromCache() async {
    final categoriesWrapper = await cacheDatabase.getAll(
        CacheDefines.categories, CategoriesCacheWrapper.fromJson);

    return categoriesWrapper != null && categoriesWrapper.isNotEmpty
        ? categoriesWrapper.first
        : null;
  }

  Future _saveCategoriesToCache(List<Category> categories) async {
    await cacheDatabase.saveMap(
        CacheDefines.categories,
        json.decode(json.encode(CategoriesCacheWrapper(
                CacheDefines.categories, DateTime.now(), categories)))
            as Map<String, dynamic>);
  }

  Future<List<Category>> _fetchCategoryList() async {
    final response = await apiService.categories();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
