import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/cache_wrappers/payment_method_wrapper.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class PaymentMethodRepository  extends RepositoryBase<PaymentMethodWrapper>{
  static const filterFieldUserId = 'userId';
  static const filterFieldForPaymentMethod = 'id';

    PaymentMethodRepository()
      : super(
          filterFieldForItem: filterFieldForPaymentMethod,
          filterFieldForUser: filterFieldUserId,
          repositoryKey: CacheDefines.paymentMethods,
        );

  Future<List<PaymentMethodWrapper>> getAllOPaymentMethods() async {
    return cacheDatabase.getByEqualsFilter(
        repositoryKey,
        PaymentMethodWrapper.fromJson,
        {filterFieldUserId: membershipService.id});
  }
}
