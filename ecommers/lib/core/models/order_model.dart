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
}
