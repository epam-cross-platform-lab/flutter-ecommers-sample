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
    isValidFullName = _isValidFullName();
    isValidAddress = _isValidAddress();
    isValidCity = _isValidCity();
    isValidZipCode = _isValidZipCode();
    isValidStateProvinceRegion = _isValidState();
    isValidCountry = _isValidCountry();

    return isValidFullName && isValidAddress && isValidCity  && isValidZipCode && isValidStateProvinceRegion && isValidCountry;
  }

  bool _isValidFullName() =>
      shippingAddress.fullName != null && shippingAddress.fullName.length > 3;

  bool _isValidAddress() =>
      shippingAddress.address != null && shippingAddress.address.length > 2;

  bool _isValidCity() =>
      shippingAddress.city != null && shippingAddress.city.length > 2;

  bool _isValidState() =>
      shippingAddress.state != null && shippingAddress.state.length > 3;

  bool _isValidZipCode() =>
      shippingAddress.zipCode != null && shippingAddress.zipCode.length > 2;
  
  bool _isValidCountry() => 
      shippingAddress.country != null && shippingAddress.country.length > 3;

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
