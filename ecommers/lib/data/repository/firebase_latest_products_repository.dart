import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/shared/dependency_service.dart';

class FirebaseLattestProductsRepository {
  final _databaseReference = Firestore.instance;
  CollectionReference _getProductsCollection() =>
      _databaseReference.collection('products');

  Future<List<Product>> loadLatestProducts(int fromId, int count) async {
    var result = <Product>[];

    try {
      var query =
          _getProductsCollection().orderBy('catalogAddDate', descending: true);

      query = await _applyStartAfter(query, fromId);

      final remoteData = await query.limit(count).getDocuments();

      result =
          remoteData.documents.map((e) => Product.fromJson(e.data)).toList();
    } catch (ex) {
      logger.ex(ex);
    }

    return result;
  }

  Future<List<Product>> fetchProducts(
      {int fromId,
      int count,
      String subCategory,
      String category,
      SortType sortType,
      String searchQuery}) async {
    var result = <Product>[];

    try {
      Query query = _getProductsCollection();

      if (searchQuery != null) {
        query = query.where('searchIndex',
            arrayContains: searchQuery.toLowerCase());
      }

      if (category != null) {
        query = query.where('category_lower_case',
            isEqualTo: category.toLowerCase());
      }

      if (subCategory != null) {
        query = query.where('subCategory_lower_case',
            isEqualTo: subCategory.toLowerCase());
      }

      switch (sortType) {
        case SortType.rate:
          query = query.orderBy('rate', descending: true);
          break;
        case SortType.cost:
          query = query.orderBy('price');
          break;
        case SortType.costDesc:
          query = query.orderBy('price', descending: true);
          break;
        default:
          query = query.orderBy('catalogAddDate', descending: true);
          break;
      }

      query = await _applyStartAfter(query, fromId);

      final remoteData = await query.limit(count).getDocuments();

      result =
          remoteData.documents.map((e) => Product.fromJson(e.data)).toList();
    } catch (ex) {
      logger.ex(ex);
    }

    return result;
  }

  Future<Query> _applyStartAfter(Query query, int fromId) async {
    if (fromId != null) {
      final document = (await _databaseReference
              .collection('products')
              .where('id', isEqualTo: fromId)
              .limit(1)
              .getDocuments())
          .documents
          .lastWhere((element) => true, orElse: () => null);

      if (document != null) {
        return query.startAfterDocument(document);
      } else {
        throw 'Last item cannot be found';
      }
    }
    return query;
  }
}
