import 'package:json_annotation/json_annotation.dart';

import 'product_details.dart';
import 'product_model.dart';
import 'product_review.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String gender;
  final String category;
  final String subCategory;
  final String title;
  final double price;
  final String baseColor;
  final int catalogAddDate;

  @JsonKey(name: 'styleImages')
  final List<String> images;

  final double rate;
  final List<ProductModel> models;
  final ProductDetails details;
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

  Map<String, dynamic> toSpecifiedJson() => <String, dynamic>{
        'id': id,
        'gender': gender,
        'category': category,
        'subCategory': subCategory,
        'title': title,
        'price': price,
        'baseColor': baseColor,
        'catalogAddDate': catalogAddDate,
        'styleImages': images,
        'rate': rate,
        'models': models.map((model) => model.toJson()),
        'details': details.toJson(),
        'reviews': reviews.map((review) => review.toJson()),
      };
}
