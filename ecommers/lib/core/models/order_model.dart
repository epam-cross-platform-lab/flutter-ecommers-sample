import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final double cost;
  int count;

  OrderModel({
    this.id,
    this.description,
    this.cost,
    this.imagePath,
    this.title,
    this.count,
  });

  static const fromJson = _$OrderModelFromJson;

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
