import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:uuid/uuid.dart';

class ShippingAddressService {

  Future<List<ShippingAddressModel>> getShippingAddresses() async {
     return shippingAddressRepository.getAllShippingAdderess();
  }
  
  Future<ShippingAddressModel> createShippingAddress(ShippingAddressModel shippingAddressModel) async {
    try {
      final uuid = Uuid();
      shippingAddressModel.id = uuid.v1();
      await shippingAddressRepository.add(
        shippingAddressModel,
      );

      return shippingAddressModel;
    } catch (ex) {
      return null;
    }
  }

 Future removeShippingAddresses(ShippingAddressModel shippingAddressModel) async {
    return shippingAddressRepository.remove(shippingAddressModel);
  }

  Future editShippingAddresses(ShippingAddressModel shippingAddressModel) async {
    return shippingAddressRepository.edit(shippingAddressModel);
  }

}
