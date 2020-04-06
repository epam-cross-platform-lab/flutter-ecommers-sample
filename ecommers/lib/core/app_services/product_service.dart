import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ProductService {
  Future<List<Product>> fetchProducts({
    String category,
    String subCategory,
    int rangeFrom,
    int rangeTo,
    String searchQuery,
    SortType sortType,
  }) async {

    //TODO: Add category and subCategory type to params
    return productDataRepository.getProductListByCategory(
      category: 'Apparel',
      subCategory: 'Topwear',
      rangeFrom: rangeFrom,
      rangeTo: rangeTo,
      searchQuery: searchQuery,
      sortType: sortType,
    );
  }

  Future<List<Product>> fetchLatestProducts() async {
    return productDataRepository.getLatestProductList();
  }
}
