import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ProductService {
  Future<List<Product>> getProductList(Categories type) async {
    final response = await apiService.products(type);

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}