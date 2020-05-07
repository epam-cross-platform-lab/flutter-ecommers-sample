import 'package:ecommers/core/common/validator/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class ShippingAddressProviderModel extends ChangeNotifier {
  bool isFullNameValid = true,
      isAddressValid = true,
      isCityValid = true,
      isStateProvinceRegionValid = true,
      isZipCodeValid = true,
      isCountryValid = true;
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
    isFullNameValid = ShippingValidator.isValidFullName(shippingAddress.fullName);
    isAddressValid = ShippingValidator.isValidAddress(shippingAddress.address);
    isCityValid = ShippingValidator.isValidCity(shippingAddress.city);
    isZipCodeValid = ShippingValidator.isValidZipCode(shippingAddress.zipCode);
    isStateProvinceRegionValid = ShippingValidator.isValidState(shippingAddress.state);
    isCountryValid = ShippingValidator.isValidCountry(shippingAddress.country);

    return isFullNameValid && isAddressValid && isCityValid  && isZipCodeValid && isStateProvinceRegionValid && isCountryValid;
  }

  void clean() {
    shippingAddress = ShippingAddressModel();
    isCountryValid = true;
    isAddressValid = true;
    isCityValid = true;
    isFullNameValid = true;
    isStateProvinceRegionValid = true;
    isZipCodeValid = true;
  }
}
