import 'package:json_annotation/json_annotation.dart';

import 'product_variant_info.dart';

part 'product_variant.g.dart';

@JsonSerializable()
class ProductVariant {
  final ProductVariantInfo node;

  ProductVariant({this.node});

  static const fromJsonFactory = _$ProductVariantFromJson;

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);
}
