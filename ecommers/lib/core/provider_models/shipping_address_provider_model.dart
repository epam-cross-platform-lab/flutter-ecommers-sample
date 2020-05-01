import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';

class ShippingAddressProviderModel extends ChangeNotifier {
  
  List<ShippingAddressModel> _shipingAddresses = <ShippingAddressModel>[];
  ShippingAddressModel _selectedShippingAddress; 
  ShippingAddressModel shippingAddress = ShippingAddressModel();

  ShippingAddressProviderModel() {
    _initialize();
  }

  List<ShippingAddressModel> get shippingAddresses => _shipingAddresses;
  ShippingAddressModel get selectedShippingAddress => _selectedShippingAddress;

  Future _initialize() async {
    _shipingAddresses = await shippingAddressService.getShippingAddresses() ??
        <ShippingAddressModel>[];
    _selectedShippingAddress =
        _shipingAddresses.firstWhere((m) => m.isSelected, orElse: () => null);
    notifyListeners();
  }

  Future addOrEditShippingAddress() async {
    final bool checkEdit = _shipingAddresses.any((e) => shippingAddress.id != null && e.id.contains(shippingAddress?.id));
    if(checkEdit){
      shippingAddress = ShippingAddressModel();
      navigationService.goBack();
      return;
    }

    final itemShippingAddress =
        await shippingAddressService.createShippingAddress(shippingAddress);

    if (itemShippingAddress != null) {
      _shipingAddresses.add(itemShippingAddress);
      notifyListeners();
    }
    shippingAddress = ShippingAddressModel();
    navigationService.goBack();
  }

  
  Future<ShippingAddressModel> removeShippingAddress(int index) async {
    final removedItem = _shipingAddresses.removeAt(index);
    if (removedItem.id == selectedShippingAddress.id) {
      _selectedShippingAddress = null;
    }

    await shippingAddressService.removeShippingAddresses(removedItem);
    return removedItem;
  }

  void selectShippingAddress(ShippingAddressModel shippingAddressModel) {
    if (_selectedShippingAddress == null) {
      _selectedShippingAddress = shippingAddressModel..isSelected = true;
      shippingAddressService.editShippingAddresses(_selectedShippingAddress);
      notifyListeners();
    }

    if (shippingAddressModel.id == _selectedShippingAddress.id) return;

    shippingAddressModel.isSelected = true;
    _selectedShippingAddress.isSelected = false;
    notifyListeners();

    shippingAddressService.editShippingAddresses(_selectedShippingAddress);
    shippingAddressService.editShippingAddresses(shippingAddressModel);

    _selectedShippingAddress = shippingAddressModel;
  }

}
