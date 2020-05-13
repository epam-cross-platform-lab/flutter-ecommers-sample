import 'package:ecommers/core/common/validator/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class ShippingAddressProviderModel extends ChangeNotifier {
  bool isFullNameValid,
      isAddressValid,
      isCityValid,
      isStateProvinceRegionValid,
      isZipCodeValid,
      isCountryValid;
  List<ShippingAddressModel> _shipingAddresses = <ShippingAddressModel>[];
  List<ShippingAddressModel> selectedShippingAddress = <ShippingAddressModel>[];
  ShippingAddressModel shippingAddress = ShippingAddressModel();

  List<ShippingAddressModel> get shippingAddresses => _shipingAddresses;

  Future initialize() async {
    _shipingAddresses = await shippingAddressService.getShippingAddresses() ??
        <ShippingAddressModel>[];
    selectedShippingAddress =
        await shippingAddressService.getSelectedShippingAddress();
    notifyListeners();
  }

  Future addOrEditShippingAddress() async {
    if (!_isShippingAddressValid()) {
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
    if (selectedShippingAddress.isNotEmpty &&
        removedItem.id == selectedShippingAddress[0]?.id) {
      selectedShippingAddress.removeAt(0);
      await shippingAddressService.removeSelectedShippingAddress(removedItem);
    }

    await shippingAddressService.removeShippingAddresses(removedItem);
    notifyListeners();
    return removedItem;
  }

  Future selectShippingAddress(ShippingAddressModel shippingAddress) async {
    if (selectedShippingAddress.isEmpty) {
      await shippingAddressService.addSelectedShippingAddress(shippingAddress);
      selectedShippingAddress.add(shippingAddress);
      notifyListeners();
    }

    if (selectedShippingAddress[0].id == shippingAddress.id) return;

    if (selectedShippingAddress[0].id != shippingAddress.id) {
      await shippingAddressService
          .updateSelectedShippingAddress(shippingAddress);
      selectedShippingAddress[0] = shippingAddress;
      notifyListeners();
    }
  }

  bool _isShippingAddressValid() {
    isFullNameValid =
        ShippingValidator.isFullNameValid(shippingAddress.fullName);
    isAddressValid = ShippingValidator.isAddressValid(shippingAddress.address);
    isCityValid = ShippingValidator.isCityValid(shippingAddress.city);
    isZipCodeValid = ShippingValidator.isZipCodeValid(shippingAddress.zipCode);
    isStateProvinceRegionValid =
        ShippingValidator.isStateValid(shippingAddress.state);
    isCountryValid = ShippingValidator.isCountryValid(shippingAddress.country);

    return isFullNameValid &&
        isAddressValid &&
        isCityValid &&
        isZipCodeValid &&
        isStateProvinceRegionValid &&
        isCountryValid;
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
