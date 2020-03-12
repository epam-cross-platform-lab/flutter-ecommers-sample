import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'image_uri')
  final String imageUri;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'cost')
  final double cost;

  @JsonKey(name: 'rate')
  final double rate;

  ProductModel(this.id, this.imageUri, this.title, this.cost, this.rate);

  static const fromJsonFactory = _$ProductModelFromJson;

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
