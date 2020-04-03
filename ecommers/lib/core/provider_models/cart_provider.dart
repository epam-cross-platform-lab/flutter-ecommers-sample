import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/widgets.dart';

class CartProvider extends ChangeNotifier {
  List<OrderModel> _orders;

  List<OrderModel> get orders => _orders;
  int get orederCount => _orders.length;

  CartProvider() {
    _initializeOrderProducts();
  }

  void removeOrEdit(OrderModel order) {
    final editOrder = _getOrderById(order.id);

    if (editOrder == null) {
      return;
    }

    if (editOrder.count > 1) {
      editOrder.count--;
      //todo call edit method
    } else {
      //todo remove from bd
      _orders.remove(editOrder);
    }
    notifyListeners();
  }

  void addOrEdit(OrderModel order) {
    final editOrder = _getOrderById(order.id);

    if (editOrder == null) {
      _orders.add(order);
      //todo add to bd
    } else {
      editOrder.count++;
      //todo call edit method
    }
    notifyListeners();
  }

  void resetCart() {
    //todo reset cart (bd)
    _orders = <OrderModel>[];
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

  void _initializeOrderProducts() {
    //todo get from bd
    _orders = <OrderModel>[OrderModel(
        title: 'Bottle Green Backpack',
        description: 'Medium, Green',
        cost: 2.58,
        imagePath: Assets.greenBackpackImage,
        count: 1),];
  }

  OrderModel _getOrderById(int id) =>
      _orders.firstWhere((o) => o.id == id, orElse: () => null);
}
