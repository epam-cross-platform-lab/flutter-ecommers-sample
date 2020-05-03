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
  }) {
    return productsRepository.fetchProducts(
        fromId: from,
        count: to,
        subCategory: subCategory,
        category: EnumToString.parse(category),
        searchQuery: searchQuery,
        sortType: sortType);
  }

  Future<List<Product>> fetchLatestProducts(int fromId, int count) async {
    return productsRepository.loadLatestProducts(fromId, count);
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
