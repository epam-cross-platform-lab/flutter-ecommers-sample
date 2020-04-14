import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String size;
  final String color;
  final int skuId;
  final List<String> imageUrls;
  final bool isAvailable;
  final int totalCount;

  ProductModel({
    this.size,
    this.color,
    this.skuId,
    this.imageUrls,
    this.isAvailable,
    this.totalCount,
  });

  static const fromJsonFactory = _$ProductModelFromJson;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

