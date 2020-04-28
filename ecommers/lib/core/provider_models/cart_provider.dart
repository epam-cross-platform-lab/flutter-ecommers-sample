import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/widgets.dart';

class CartProvider extends ChangeNotifier {
  List<OrderModel> _orders = <OrderModel>[];

  List<OrderModel> get orders => _orders;
  int get orderCount => _orders.length;

  Future remove(OrderModel order, {int count = 1}) async {
    final editOrder = _getOrder(order.product.id);

    if (editOrder == null) {
      return;
    }

    if (editOrder.count > count) {
      editOrder.count = editOrder.count - count;
      await cartRepository.edit(order);
    } else {
      _orders.remove(editOrder);
      await cartRepository.remove(order);
    }
    notifyListeners();
  }

  Future add(OrderModel order) async {
    final editOrder = _getOrder(order.product.id);

    if (editOrder == null) {
      _orders.add(order);
      await cartRepository.add(order);
    } else {
      editOrder.count++;
      await cartRepository.edit(order);
    }
    notifyListeners();
  }

  void resetCart() {
    _orders = <OrderModel>[];
    cartRepository.dropOrders();
    notifyListeners();
  }

  double calculateTotalCost([double salePercent = 0]) {
    if (salePercent < 0 && salePercent > 100) {
      throw ArgumentError();
    }

    final double totalCost = _orders.fold(
        0.0,
        (totalOrderCost, nextOrder) =>
            totalOrderCost + nextOrder.count * nextOrder.product.price);

    return totalCost * (100 - salePercent) / 100;
  }

  Future initializeOrderProducts() async {
    _orders = await cartRepository.getAllOrders() ?? <OrderModel>[];
    notifyListeners();
  }

  OrderModel _getOrder(int id) =>
      _orders.firstWhere((o) => o.product.id == id, orElse: () => null);
}
