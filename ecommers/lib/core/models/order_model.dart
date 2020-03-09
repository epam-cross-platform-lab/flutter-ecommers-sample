class OrderModel {
  final String title;
  final String description;
  final String imagePath;
  final double cost;
  int count;

  OrderModel({
    this.description,
    this.cost,
    this.imagePath,
    this.title,
    this.count,
  });
}
