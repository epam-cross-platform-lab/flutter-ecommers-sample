import 'package:json_annotation/json_annotation.dart';

import 'shopify_product_info.dart';

part 'shopify_product.g.dart';

@JsonSerializable()
class ShopifyProduct {
  final String cursor;
  final ShopifyProductInfo node;

  ShopifyProduct({
    this.cursor,
    this.node,
  });

  static const fromJsonFactory = _$ShopifyProductFromJson;

  factory ShopifyProduct.fromJson(Map<String, dynamic> json) =>
      _$ShopifyProductFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyProductToJson(this);
}
