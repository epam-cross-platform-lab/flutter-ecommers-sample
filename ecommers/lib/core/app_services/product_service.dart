import 'package:chopper/chopper.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';

class ProductService {
  Future<List<Product>> fetchProducts({
    Categories category,
    String subCategory,
    int from,
    int to,
    String searchQuery,
    SortType sortType,
  }) async {
    final response = await apiService.products(
      category: EnumToString.parse(category),
      subCategory: subCategory,
      from: from,
      to: to,
      searchQuery: searchQuery,
      sortType: EnumToString.parse(sortType),
    );

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }

  Future<Product> fetchProductById(int productId) async {
    final Response<Product> response =
        await apiService.productId(id: productId);

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }

  Future<List<Product>> fetchLatestProducts(int from, int to) async {
    final response = await apiService.productsLatest(from, to);

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }

  Future<List<Product>> fetchRecentProducts() async =>
      appService.fetchData(apiService.productsRecent);

  Future<bool> recentProductsDelete() async {
    final response = await apiService.productsRecentDelete();

    return response.isSuccessful;
  }

  Future<List<Product>> fetchRecommendedProducts() async =>
      appService.fetchData(apiService.productRecommended);

  Future<bool> trySaveRecentProduct(Map<String, dynamic> product) async {
    final response = await apiService.productsRecentPost(product);
    return response.isSuccessful;
  }
}
