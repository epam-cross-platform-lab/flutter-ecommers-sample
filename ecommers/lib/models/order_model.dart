class OrderModel {
  String title;
  String description;
  String imagePath;
  double cost;
  int count;

  OrderModel(
      {this.description,
      this.cost,
      this.imagePath,
      this.title,
      this.count});
}