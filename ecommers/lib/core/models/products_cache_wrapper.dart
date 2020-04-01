import 'package:ecommers/core/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_cache_wrapper.g.dart';

@JsonSerializable()
class ProductsCacheWrapper {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'products')
  final List<ProductModel> products;

  ProductsCacheWrapper(this.key, this.products);

  static const fromJson = _$ProductsCacheWrapperFromJson;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'products': products.map((product) => product.toJson()),
      };
}
