import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel  {
  final String id;
  final String fullName;
  final String address;
  final String state;
  final int zipCode;
  final String country;
  bool isSelected;

  ShippingAddressModel({
    this.id,
    this.fullName,
    this.address,
    this.state,
    this.zipCode,
    this.country,
    this.isSelected = false,
  });

  static const fromJson = _$ShippingAddressModelFromJson;

  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);
}
