import 'dart:convert';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';

class RepositoryBase<T extends ItemBase> {
  final String filterFieldForItem;
  final String repositoryKey;
  
  RepositoryBase({
    this.filterFieldForItem,
    this.repositoryKey,
  });

  Future edit(T item) async {
    return cacheDatabase.updateByEqualsFilter(
        repositoryKey, json.decode(json.encode(item)) as Map<String, dynamic>, {
      filterFieldForItem: item.id,
    });
  }

  Future add(T item) async {
    return cacheDatabase.saveMap(
        repositoryKey, json.decode(json.encode(item)) as Map<String, dynamic>);
  }

  Future remove(T item) async {
    return cacheDatabase.deleteDataByFilter(repositoryKey, {
      filterFieldForItem: item.id,
    });
  }
}
