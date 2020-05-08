import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:uuid/uuid.dart';

class ShippingAddressService {
  Future<List<ShippingAddressModel>> getShippingAddresses() async {
    return shippingAddressRepository.getAllShippingAdderess();
  }

  Future<List<ShippingAddressModel>> getSelectedShippingAddress() async {
    return shippingAddressRepository.getSelectedShippingAddress();
  }

  Future addSelectedShippingAddress(ShippingAddressModel item) async {
    return shippingAddressRepository.addSelectedShippingAddress(item);
  }

  Future updateSelectedShippingAddress(ShippingAddressModel item) async {
    return shippingAddressRepository.updateSelectedShippingAddress(item);
  }

  Future removeSelectedShippingAddress(ShippingAddressModel item) async {
    return shippingAddressRepository.removeSelectedShippingAddress(item);
  }

  Future<ShippingAddressModel> createShippingAddress(
      ShippingAddressModel shippingAddressModel) async {
    try {
      final uuid = Uuid();
      shippingAddressModel.id = uuid.v1();
      await shippingAddressRepository.add(
        shippingAddressModel,
      );

      return shippingAddressModel;
    } catch (ex) {
      logger.ex(ex);
    }
  }

  Future removeShippingAddresses(
      ShippingAddressModel shippingAddressModel) async {
    return shippingAddressRepository.remove(shippingAddressModel);
  }

  Future editShippingAddresses(
      ShippingAddressModel shippingAddressModel) async {
    return shippingAddressRepository.edit(shippingAddressModel);
  }
}
