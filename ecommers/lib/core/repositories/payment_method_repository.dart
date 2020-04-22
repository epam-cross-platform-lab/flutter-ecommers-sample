import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/payment_method_wrapper.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class PaymentMethodRepository {
  static const filterFieldForUser = 'userId';
  static const filterFieldForPaymentMethod = 'id';

  Future<List<PaymentMethodWrapper>> getAllOPaymentMethods() async {
    return cacheDatabase.getByEqualsFilter(
      CacheDefines.paymentMethods,
      PaymentMethodWrapper.fromJson,
      filterFieldForUser,
      membershipService.id,
    );
  }

  Future editPaymentMethod(PaymentMethodWrapper paymentMethodWrapper) async {
    await cacheDatabase.updateByEqualsFilter(
      CacheDefines.paymentMethods,
      json.decode(json.encode(paymentMethodWrapper)) as Map<String, dynamic>,
      filterFieldForPaymentMethod,
      paymentMethodWrapper.id,
    );
  }

  Future addPaymentMethod(PaymentMethodWrapper paymentMethodWrapper) async {
    await cacheDatabase.saveMap(CacheDefines.paymentMethods,
        json.decode(json.encode(paymentMethodWrapper)) as Map<String, dynamic>);
  }

  Future removePaymentMethod(PaymentMethodWrapper paymentMethodWrapper) async {
    await cacheDatabase.deleteDataByFilter(
      CacheDefines.paymentMethods,
      filterFieldForPaymentMethod,
      paymentMethodWrapper.id,
    );
  }
}
