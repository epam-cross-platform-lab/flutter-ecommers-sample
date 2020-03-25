import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategoryList() async {
    final response = await apiService.categories();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}