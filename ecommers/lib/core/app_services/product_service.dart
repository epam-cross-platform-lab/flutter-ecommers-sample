import 'package:enum_to_string/enum_to_string.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ProductService {
  Future<List<Product>> fetchProducts({
    Categories category,
    String subCategory,
    int rangeFrom,
    int rangeTo,
    String searchQuery,
    SortType sortType,
  }) async {
    final response = await apiService.products(
      category: EnumToString.parse(category),
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

  Future<List<Product>> fetchLatestProducts() async {
    final response = await apiService.productsLatest();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
