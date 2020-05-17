import 'package:json_annotation/json_annotation.dart';

import 'shopify_product_list.dart';

part 'shopify_model.g.dart';

@JsonSerializable()
class ShopifyModel {
  final ShopifyProductList products;

  ShopifyModel({this.products});

  static const fromJsonFactory = _$ShopifyModelFromJson;

  factory ShopifyModel.fromJson(Map<String, dynamic> json) =>
      _$ShopifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyModelToJson(this);
}
