import 'package:json_annotation/json_annotation.dart';

part 'product_variant_info.g.dart';

@JsonSerializable()
class ProductVariantInfo {
  final String id;
  final String price;
  final String sku;
  final String barcode;
  final int inventoryQuantity;
  final String compareAtPrice;

  ProductVariantInfo({
    this.id,
    this.price,
    this.sku,
    this.barcode,
    this.inventoryQuantity,
    this.compareAtPrice,
  });

  static const fromJsonFactory = _$ProductVariantInfoFromJson;

  factory ProductVariantInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantInfoToJson(this);
}
