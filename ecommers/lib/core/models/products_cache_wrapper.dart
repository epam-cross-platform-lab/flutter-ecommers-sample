import 'package:json_annotation/json_annotation.dart';
import 'data_models/index.dart';

part 'products_cache_wrapper.g.dart';

@JsonSerializable()
class ProductsCacheWrapper {
  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'lastUpdatedDate')
  final DateTime lastUpdatedDate;
  @JsonKey(name: 'products')
  final List<Product> products;

  ProductsCacheWrapper(this.key, this.lastUpdatedDate, this.products);

  static const fromJson = _$ProductsCacheWrapperFromJson;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
        'products': products.map((product) => product.toSpecifiedJson()),
      };
}
