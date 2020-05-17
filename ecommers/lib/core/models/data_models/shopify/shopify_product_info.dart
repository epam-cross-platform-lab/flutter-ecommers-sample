import 'package:json_annotation/json_annotation.dart';

import 'product_option.dart';
import 'product_variant_list.dart';
import 'shopify_image_list.dart';

part 'shopify_product_info.g.dart';

@JsonSerializable()
class ShopifyProductInfo {
  final String id;
  final String title;
  final String description;
  final String vendor;
  final List<String> tags;
  final String productType;
  final int totalVariants;
  final int totalInventory;
  final bool isGiftCard;
  final ProductVariantList variants;
  final ShopifyImageList images;
  final List<ProductOption> options;

  ShopifyProductInfo({
    this.id,
    this.title,
    this.description,
    this.vendor,
    this.tags,
    this.productType,
    this.totalVariants,
    this.totalInventory,
    this.isGiftCard,
    this.variants,
    this.images,
    this.options,
  });

  static const fromJsonFactory = _$ShopifyProductInfoFromJson;

  factory ShopifyProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ShopifyProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShopifyProductInfoToJson(this);
}
