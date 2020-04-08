import 'package:json_annotation/json_annotation.dart';
import 'data_models/index.dart';

part 'categories_cache_wrapper.g.dart';

@JsonSerializable()
class CategoriesCacheWrapper {
  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'lastUpdatedDate')
  final DateTime lastUpdatedDate;
  @JsonKey(name: 'categories')
  final List<Category> categories;

  CategoriesCacheWrapper(this.key, this.lastUpdatedDate, this.categories);

  static const fromJson = _$CategoriesCacheWrapperFromJson;

  Map<String, dynamic> toJson() => _$CategoriesCacheWrapperToJson(this);
}