import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/core/repositories/index.dart';

class PaymentMethodRepository extends RepositoryBase<PaymentMethodModel> {
  static const filterFieldId = 'id';

  PaymentMethodRepository()
      : super(
          filterFieldForItem: filterFieldId,
          repositoryKey: CacheDefines.paymentMethods,
        );

  Future<List<PaymentMethodModel>> getAllOPaymentMethods() async {
    return cacheDatabase.getAll(repositoryKey, PaymentMethodModel.fromJson);
  }

  Future<List<PaymentMethodModel>> getSelectedPaymentMethod() {
    return cacheDatabase.getAll(
        CacheDefines.selectedPaymentMethodId, PaymentMethodModel.fromJson);
  }

  Future addSelectedPaymentMethod(PaymentMethodModel item) {
    return cacheDatabase.saveMap(CacheDefines.selectedPaymentMethodId,
        json.decode(json.encode(item)) as Map<String, dynamic>);
  }

  Future updateSelectedPaymentMethod(PaymentMethodModel item) async {
    return cacheDatabase.updateByEqualsFilter(
         CacheDefines.paymentMethods, json.decode(json.encode(item)) as Map<String, dynamic>, {
      filterFieldForItem: item.id,
    });
  }

  Future removeSelectedPaymentMethod(PaymentMethodModel item) {
    return cacheDatabase
        .deleteDataByFilter(CacheDefines.selectedPaymentMethodId, {
      filterFieldForItem: item.id,
    });
  }
}
