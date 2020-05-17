import 'package:json_annotation/json_annotation.dart';

import 'shopify_image.dart';

part 'shopify_image_list.g.dart';

@JsonSerializable()
class ShopifyImageList {
  final List<ShopifyImage> edges;

  ShopifyImageList({this.edges});

  static const fromJsonFactory = _$ShopifyImageListFromJson;

  factory ShopifyImageList.fromJson(Map<String, dynamic> json) =>
      _$ShopifyImageListFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyImageListToJson(this);
}
