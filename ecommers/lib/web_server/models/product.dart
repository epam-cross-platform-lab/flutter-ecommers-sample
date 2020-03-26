import 'package:ecommers/web_server/models/product_details.dart';
import 'package:ecommers/web_server/models/product_model.dart';
import 'package:ecommers/web_server/models/product_review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'subCategory')
  final String subCategory;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'baseColor')
  final String baseColor;

  @JsonKey(name: 'baseColor')
  final String catalogAddDate;

  @JsonKey(name: 'styleImages')
  final List<String> images;

  @JsonKey(name: 'rate')
  final double rate;

  @JsonKey(name: 'models')
  final List<ProductModel> models;

  @JsonKey(name: 'details')
  final ProductDetails details;

  @JsonKey(name: 'reviews')
  final List<ProductReview> reviews;

  Product(
    this.id,
    this.gender,
    this.category,
    this.title,
    this.price,
    this.baseColor,
    this.images,
    this.rate,
    this.models,
    this.details,
    this.reviews,
    this.subCategory,
    this.catalogAddDate,
  );

  static const fromJsonFactory = _$ProductFromJson;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
