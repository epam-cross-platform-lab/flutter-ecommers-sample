import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String title;
  final List<String> subCategories;

  Category(this.id, this.title, this.subCategories);

  static const fromJsonFactory = _$CategoryFromJson;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
