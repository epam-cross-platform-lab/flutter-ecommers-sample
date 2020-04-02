import 'package:ecommers/core/common/categories.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String title;
  final Categories type;
  final String color1;
  final String color2;
  final String shadowColor;
  final List<String> subCategories;

  Category(
    this.id,
    this.title,
    this.subCategories,
    this.type,
    this.color1,
    this.color2,
    this.shadowColor,
  );

  static const fromJsonFactory = _$CategoryFromJson;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
