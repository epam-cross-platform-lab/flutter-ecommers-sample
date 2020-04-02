import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class CategoryService {
  Future<List<Category>> fetchCategoryList() async {
    final response = await apiService.categories();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}