import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/core/services/index.dart';

class CartRepository extends RepositoryBase<OrderModel> {
  static const filterFieldOrderId = 'id';
  CartRepository()
      : super(
          filterFieldForItem: filterFieldOrderId,
          repositoryKey: CacheDefines.orders,
        );

  Future<List<OrderModel>> getAllOrders() async {
    return cacheDatabase.getAll(
        repositoryKey,
        OrderModel.fromJson);

  }

  Future dropOrders() async {
    await cacheDatabase.dropData(repositoryKey); 
  }
}
