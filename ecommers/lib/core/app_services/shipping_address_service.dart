import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';


class ShippingAddressService {

  Future<List<ShippingAddressModel>> getShippingAddresses() async {
    return null; 
  }
  
  Future<ShippingAddressModel> createShippingAddress(ShippingAddressModel shippingAddressModel) async {
    try {
      await shippingAddressRepository.add(
        shippingAddressModel,
      );

      return shippingAddressModel;
    } catch (ex) {
      return null;
    }
  }

  Future removeShippingAddress(ShippingAddressModel paymentMethodModel) async {
    return null;
  }

}
