import 'package:enum_to_string/enum_to_string.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ProductService {
  Future<List<Product>> fetchProducts({
    Categories category,
    String subCategory,
    int from,
    int to,
    String searchQuery,
    SortType sortType,
  }) async {
    return productDataRepository.getProducts(
      category: EnumToString.parse(category),
      subCategory: subCategory,
      rangeFrom: from,
      rangeTo: to,
      searchQuery: searchQuery,
      sortType: sortType,
    );
    }

  Future<List<Product>> fetchLatestProducts(int from, int to) async {
    return productDataRepository.getLatestProducts(from, to);
  }

  Future<List<Product>> fetchRecommendedProducts() async =>
      appService.fetchData(apiService.productRecommended);
}
