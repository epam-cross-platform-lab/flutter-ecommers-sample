import 'package:json_annotation/json_annotation.dart';

part 'product_color.g.dart';

@JsonSerializable()
class ProductColor {
  final String title;
  final int argb;

  ProductColor(
    this.title,
    this.argb
  );

  static const fromJsonFactory = _$ProductColorFromJson;

  factory ProductColor.fromJson(Map<String, dynamic> json) =>
      _$ProductColorFromJson(json);

  Map<String, dynamic> toJson() => _$ProductColorToJson(this);
}
