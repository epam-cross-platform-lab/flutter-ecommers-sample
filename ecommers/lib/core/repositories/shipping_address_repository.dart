import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/shared/dependency_service.dart';

class ShippingAddressRepository extends RepositoryBase<ShippingAddressModel> {
  static const filterFieldId = 'id';

  ShippingAddressRepository()
      : super(
          filterFieldForItem: filterFieldId,
          repositoryKey: CacheDefines.shippingAddress,
        );

  Future<List<ShippingAddressModel>> getSelectedShippingAddress() {
    return cacheDatabase.getAll(
        CacheDefines.selectedShippingAddressId, ShippingAddressModel.fromJson);
  }

  Future addSelectedShippingAddress(ShippingAddressModel item) {
    return cacheDatabase.saveMap(CacheDefines.selectedShippingAddressId,
        json.decode(json.encode(item)) as Map<String, dynamic>);
  }

  Future updateSelectedShippingAddress(ShippingAddressModel item) async {
    return cacheDatabase.updateByEqualsFilter(
        repositoryKey, json.decode(json.encode(item)) as Map<String, dynamic>, {
      filterFieldForItem: item.id,
    });
  }

  Future removeSelectedShippingAddress(ShippingAddressModel item) {
    return cacheDatabase
        .deleteDataByFilter(CacheDefines.selectedShippingAddressId, {
      filterFieldForItem: item.id,
    });
  }

  Future<List<ShippingAddressModel>> getAllShippingAdderess() async {
    return cacheDatabase.getAll(repositoryKey, ShippingAddressModel.fromJson);
  }
}
