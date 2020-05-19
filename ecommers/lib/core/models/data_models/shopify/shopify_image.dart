import 'package:json_annotation/json_annotation.dart';

import 'shopify_image_info.dart';

part 'shopify_image.g.dart';

@JsonSerializable()
class ShopifyImage {
  final ShopifyImageInfo node;

  ShopifyImage({this.node});

  static const fromJsonFactory = _$ShopifyImageFromJson;

  factory ShopifyImage.fromJson(Map<String, dynamic> json) =>
      _$ShopifyImageFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyImageToJson(this);
}
