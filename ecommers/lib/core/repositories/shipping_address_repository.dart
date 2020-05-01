import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class ShippingAddressRepository extends RepositoryBase<ShippingAddressModel> {
  static const filterFieldId = 'id';

  ShippingAddressRepository()
      : super(
          filterFieldForItem: filterFieldId,
          repositoryKey: CacheDefines.shippingAddress,
        );

  Future<List<ShippingAddressModel>> getAllShippingAdderess() async {
    return cacheDatabase.getAll(repositoryKey, ShippingAddressModel.fromJson);
  }
}