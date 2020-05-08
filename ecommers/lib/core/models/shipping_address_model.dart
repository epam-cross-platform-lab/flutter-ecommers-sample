import 'package:ecommers/core/models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel implements ItemBase {
  @override
  String id;
  String fullName;
  String address;
  String city;
  String state;
  String zipCode;
  String country;

  ShippingAddressModel({
    this.id,
    this.fullName,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  static const fromJson = _$ShippingAddressModelFromJson;

  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);
}
