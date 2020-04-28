import 'dart:convert';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';

class RepositoryBase<T extends ItemBase> {
  final String filterFieldForItem;
  final String repositoryKey;
  
  RepositoryBase({
    this.filterFieldForItem,
    this.repositoryKey,
  });

  Future edit(T item) async {
    await cacheDatabase.updateByEqualsFilter(
        repositoryKey, json.decode(json.encode(item)) as Map<String, dynamic>, {
      filterFieldForItem: item.id,
    });
  }

  Future add(T item) async {
    await cacheDatabase.saveMap(repositoryKey,
        json.decode(json.encode(item)) as Map<String, dynamic>);
  }

  Future remove(T item) async {
    await cacheDatabase.deleteDataByFilter(repositoryKey, {
      filterFieldForItem: item.id,
    });
  }
}
