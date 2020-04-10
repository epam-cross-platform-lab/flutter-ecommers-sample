import 'package:ecommers/core/models/data_models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_cache_wrapper.g.dart';

@JsonSerializable()
class ProductsCacheWrapper {
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'subCategory')
  final String subCategory;
  @JsonKey(name: 'lastUpdatedDate')
  final DateTime lastUpdatedDate;
  @JsonKey(name: 'products')
  final List<Product> products;

  ProductsCacheWrapper(this.category, this.subCategory, this.lastUpdatedDate, this.products);

  static const fromJson = _$ProductsCacheWrapperFromJson;

  Map<String, dynamic> toJson() => _$ProductsCacheWrapperToJson(this);
}
