import 'package:ecommers/core/common/validator/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';

class ShippingAddressProviderModel extends ChangeNotifier {
  bool isValidFullName = true,
      isValidAddress = true,
      isValidCity = true,
      isValidStateProvinceRegion = true,
      isValidZipCode = true,
      isValidCountry = true;
  List<ShippingAddressModel> _shipingAddresses = <ShippingAddressModel>[];
  ShippingAddressModel _selectedShippingAddress;
  ShippingAddressModel shippingAddress = ShippingAddressModel();

  List<ShippingAddressModel> get shippingAddresses => _shipingAddresses;
  ShippingAddressModel get selectedShippingAddress => _selectedShippingAddress;

  Future initialize() async {
    _shipingAddresses = await shippingAddressService.getShippingAddresses() ??
        <ShippingAddressModel>[];
    _selectedShippingAddress =
        _shipingAddresses.firstWhere((m) => m.isSelected, orElse: () => null);
    notifyListeners();
  }

  Future addOrEditShippingAddress() async {
    if (!_isValidShippingAddress()) {
      notifyListeners();
      return;
    }

    final bool checkEdit = _shipingAddresses.any((e) =>
        shippingAddress.id != null && e.id.contains(shippingAddress?.id));
    if (checkEdit) {
      navigationService.goBack();
      return;
    }

    final itemShippingAddress =
        await shippingAddressService.createShippingAddress(shippingAddress);

    if (itemShippingAddress != null) {
      _shipingAddresses.add(itemShippingAddress);
      notifyListeners();
    }
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

  bool _isValidShippingAddress() {
    isValidFullName = ShippingValidator.isValidFullName(shippingAddress.fullName);
    isValidAddress = ShippingValidator.isValidAddress(shippingAddress.address);
    isValidCity = ShippingValidator.isValidCity(shippingAddress.city);
    isValidZipCode = ShippingValidator.isValidZipCode(shippingAddress.zipCode);
    isValidStateProvinceRegion = ShippingValidator.isValidState(shippingAddress.state);
    isValidCountry = ShippingValidator.isValidCountry(shippingAddress.country);

    return isValidFullName && isValidAddress && isValidCity  && isValidZipCode && isValidStateProvinceRegion && isValidCountry;
  }

  void clean() {
    shippingAddress = ShippingAddressModel();
    isValidCountry = true;
    isValidAddress = true;
    isValidCity = true;
    isValidFullName = true;
    isValidStateProvinceRegion = true;
    isValidZipCode = true;
  }
}
