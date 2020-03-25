import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'subCategory')
  final List<String> subCategories;

  CategoryModel(this.id, this.title, this.subCategories);

  static const fromJsonFactory = _$CategoryModelFromJson;

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

