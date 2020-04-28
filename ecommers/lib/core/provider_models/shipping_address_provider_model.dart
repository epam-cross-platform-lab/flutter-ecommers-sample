import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';

class ShippingAddressProviderModel extends ChangeNotifier {
  List<ShippingAddressModel> _shipingAddresses = <ShippingAddressModel>[];
  ShippingAddressModel _selectedPaymentMethod; 
  ShippingAddressModel item = ShippingAddressModel();

  ShippingAddressProviderModel() {
    _initialize();
  }

  List<ShippingAddressModel> get shippingAddresses => _shipingAddresses;
  ShippingAddressModel get selectedShippingAddress => _selectedPaymentMethod;

  Future _initialize() async {
    _shipingAddresses = await shippingAddressService.getShippingAddresses() ??
        <ShippingAddressModel>[];
    _selectedPaymentMethod =
        _shipingAddresses.firstWhere((m) => m.isSelected, orElse: () => null);
    notifyListeners();
  }

  Future addShippingAddress() async {
    final itemShippingAddress =
        await shippingAddressService.createShippingAddress(item);

    if (itemShippingAddress != null) {
      _shipingAddresses.add(itemShippingAddress);
      notifyListeners();
    }

    navigationService.goBack();
  }

  Future<ShippingAddressModel> removeShippingAddress(int index) async {
    final removedItem = _shipingAddresses.removeAt(index);
    if (removedItem.id == selectedShippingAddress.id) {
      _selectedPaymentMethod = null;
    }

    await shippingAddressService.removeShippingAddress(removedItem);
    return removedItem;
  }
}
