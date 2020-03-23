import 'package:ecommers/web_server/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_review.g.dart';

@JsonSerializable()
class ProductReview {
  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'date')
  final DateTime date;

  @JsonKey(name: 'comment')
  final String comment;

  @JsonKey(name: 'imageUrls')
  final List<String> imageUrls;

  @JsonKey(name: 'rate')
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
