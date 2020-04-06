import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/widgets.dart';

class CartProvider extends ChangeNotifier {
  List<OrderModel> _orders;

  List<OrderModel> get orders => _orders;
  int get orderCount => _orders.length;

  void removeOrEdit(OrderModel order) {
    final editOrder = _getOrderById(order.id);

    if (editOrder == null) {
      return;
    }

    if (editOrder.count > 1) {
      editOrder.count--;
      cartRepository.editOrder(order);
    } else {
      _orders.remove(editOrder);
      cartRepository.removeOrder(order);
    }
    notifyListeners();
  }

  void addOrEdit(OrderModel order) {
    final editOrder = _getOrderById(order.id);

    if (editOrder == null) {
      _orders.add(order);
      cartRepository.addOrder(order);
    } else {
      editOrder.count++;
      cartRepository.editOrder(order);
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
            totalOrderCost + nextOrder.count * nextOrder.cost);

    return totalCost * (100 - salePercent) / 100;
  }

  void initializeOrderProducts() {
    _orders = <OrderModel>[
      OrderModel(
          title: 'Bottle Green Backpack',
          description: 'Medium, Green',
          id: 1,
          cost: 2.58,
          imagePath: Assets.greenBackpackImage,
          count: 1),
    ];
    notifyListeners();
  }

  OrderModel _getOrderById(int id) =>
      _orders.firstWhere((o) => o.id == id, orElse: () => null);
}
