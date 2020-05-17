import 'package:json_annotation/json_annotation.dart';

import 'shopify_product.dart';

part 'shopify_product_list.g.dart';

@JsonSerializable()
class ShopifyProductList {
  final List<ShopifyProduct> edges;

  ShopifyProductList({this.edges});

  static const fromJsonFactory = _$ShopifyProductListFromJson;

  factory ShopifyProductList.fromJson(Map<String, dynamic> json) =>
      _$ShopifyProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyProductListToJson(this);
}
