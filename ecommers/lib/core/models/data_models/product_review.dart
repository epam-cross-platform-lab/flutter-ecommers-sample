import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'product_review.g.dart';

@JsonSerializable()
class ProductReview {
  final User user;
  final DateTime date;
  final String comment;
  final List<String> imageUrls;
  final int rate;

  ProductReview(
    this.user,
    this.date,
    this.comment,
    this.imageUrls,
    this.rate,
  );

  static const fromJsonFactory = _$ProductReviewFromJson;

  factory ProductReview.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}
