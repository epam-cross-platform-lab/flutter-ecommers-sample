import 'dart:convert';

import 'package:ecommers/core/models/cache_wrappers/wrapper.dart';
import 'package:ecommers/core/services/index.dart';

class RepositoryBase<T extends Wrapper> {
  final String filterFieldForUser;
  final String filterFieldForItem;
  final String repositoryKey;
  RepositoryBase({
    this.filterFieldForUser,
    this.filterFieldForItem,
    this.repositoryKey,
  });

  Future edit(Wrapper item) async {
    await cacheDatabase.updateByEqualsFilter(
        repositoryKey, json.decode(json.encode(item)) as Map<String, dynamic>, {
      filterFieldForUser: membershipService.id,
      filterFieldForItem: item.id,
    });
  }

  Future add(T paymentMethodWrapper) async {
    await cacheDatabase.saveMap(repositoryKey,
        json.decode(json.encode(paymentMethodWrapper)) as Map<String, dynamic>);
  }

  Future remove(T item) async {
    await cacheDatabase.deleteDataByFilter(repositoryKey, {
      filterFieldForUser: membershipService.id,
      filterFieldForItem: item.id,
    });
  }
}
