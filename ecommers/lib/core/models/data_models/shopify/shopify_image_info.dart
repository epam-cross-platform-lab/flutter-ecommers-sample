import 'package:json_annotation/json_annotation.dart';

part 'shopify_image_info.g.dart';

@JsonSerializable()
class ShopifyImageInfo {
  final String id;
  final String originalSrc;

  ShopifyImageInfo({
    this.id,
    this.originalSrc,
  });

  static const fromJsonFactory = _$ShopifyImageInfoFromJson;

  factory ShopifyImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ShopifyImageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyImageInfoToJson(this);
}
