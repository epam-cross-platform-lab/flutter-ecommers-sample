import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/cache_wrappers/order_model_wrapper.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/core/services/index.dart';

class CartRepository extends RepositoryBase<OrderModelWrapper> {
  static const filterFieldUserId = 'userId';
  static const filterFieldOrderId = 'id';
  CartRepository()
      : super(
          filterFieldForItem: filterFieldOrderId,
          filterFieldForUser: filterFieldUserId,
          repositoryKey: CacheDefines.orders,
        );

  Future<List<OrderModel>> getAllOrders() async {
    final oederWrappers = await cacheDatabase.getByEqualsFilter(
        repositoryKey,
        OrderModelWrapper.fromJson,
        {filterFieldUserId: membershipService.id});

    return oederWrappers.map((e) => e.order).toList();
  }

  Future dropOrders() async {
    await cacheDatabase.deleteDataByFilter(repositoryKey, {
      filterFieldForUser: membershipService.id}); 
  }

}
