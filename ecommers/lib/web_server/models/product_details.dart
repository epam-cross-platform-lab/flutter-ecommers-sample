import 'package:json_annotation/json_annotation.dart';

part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails {
  @JsonKey(name: 'brand')
  final String brand;

  @JsonKey(name: 'condition')
  final String condition;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'material')
  final String material;

  @JsonKey(name: 'fitting')
  final String fitting;

  ProductDetails(
    this.brand,
    this.condition,
    this.category,
    this.material,
    this.fitting,
  );

  static const fromJsonFactory = _$ProductDetailsFromJson;

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}
