import 'package:json_annotation/json_annotation.dart';

part 'product_option.g.dart';

@JsonSerializable()
class ProductOption {
  final List<String> values;
  final String id;
  final String name;
  final int position;

  ProductOption({
    this.values,
    this.id,
    this.name,
    this.position,
  });

  static const fromJsonFactory = _$ProductOptionFromJson;

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionToJson(this);
}
