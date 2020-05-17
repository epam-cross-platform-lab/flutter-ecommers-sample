import 'package:json_annotation/json_annotation.dart';

import 'product_variant.dart';

part 'product_variant_list.g.dart';

@JsonSerializable()
class ProductVariantList {
  final List<ProductVariant> edges;

  ProductVariantList({this.edges});

  static const fromJsonFactory = _$ProductVariantListFromJson;

  factory ProductVariantList.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantListToJson(this);
}
