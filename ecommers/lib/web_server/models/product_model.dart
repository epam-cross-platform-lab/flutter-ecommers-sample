import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: 'size')
  final String size;

  @JsonKey(name: 'color')
  final String color;

  @JsonKey(name: 'skuId')
  final int skuId;

  @JsonKey(name: 'imageUrls')
  final List<String> imageUrls;

  @JsonKey(name: 'isAvailable')
  final bool isAvailable;

  @JsonKey(name: 'totalCount')
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

