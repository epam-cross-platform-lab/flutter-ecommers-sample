import 'package:ecommers/core/models/data_models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'latest_products_cache_wrapper.g.dart';

@JsonSerializable()
class LatestProductsCacheWrapper {
  @JsonKey(name: 'lastUpdatedDate')
  final DateTime lastUpdatedDate;
  @JsonKey(name: 'products')
  final List<Product> products;

  LatestProductsCacheWrapper(this.lastUpdatedDate, this.products);

  static const fromJson = _$LatestProductsCacheWrapperFromJson;

  Map<String, dynamic> toJson() => _$LatestProductsCacheWrapperToJson(this);
}
