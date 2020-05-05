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
}
