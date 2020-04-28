import 'dart:convert';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/cache_wrappers/payment_method_wrapper.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ShippingAddressRepository {
  Future add(ShippingAddressModel paymentMethodWrapper) async {
    await cacheDatabase.saveMap(CacheDefines.shippingAddress,
        json.decode(json.encode(paymentMethodWrapper)) as Map<String, dynamic>);
  }
}
