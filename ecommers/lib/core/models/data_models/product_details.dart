import 'package:json_annotation/json_annotation.dart';

part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails {
  final String brand;
  final String condition;
  final String category;
  final String material;
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
