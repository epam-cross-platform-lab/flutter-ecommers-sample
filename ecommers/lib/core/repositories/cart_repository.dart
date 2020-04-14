import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';

class CartRepository {
  static const filterField = 'id';

  Future<List<OrderModel>> getAllOrders() async {
    return cacheDatabase.getAll(
        membershipService.id.toString(), OrderModel.fromJson);
  }

  Future dropOrders() async {
    await cacheDatabase.dropData(membershipService.id.toString());
  }

  Future editOrder(OrderModel order) async {
    await cacheDatabase.updateByEqualsFilter(
      membershipService.id.toString(),
      order.toJson(),
      filterField,
      order.id,
    );
  }

  Future addOrder(OrderModel order) async {
    await cacheDatabase.saveMap(
      membershipService.id.toString(),
      order.toJson(),
    );
  }

  Future removeOrder(OrderModel order) async {
    await cacheDatabase.deleteDataByFilter(
      membershipService.id.toString(),
      filterField,
      order.id,
    );
  }
}
