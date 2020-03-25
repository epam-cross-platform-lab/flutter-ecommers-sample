class ProductReviewsModel {
  final double countOfStars;
  final int profileImageColor;
  final int profileImageTextColor;
  final String name;
  final String nameAbbreviation;
  final DateTime date;
  final String description;
  final List<String> screenshotsPathes;

  ProductReviewsModel({
    this.countOfStars,
    this.profileImageColor,
    this.profileImageTextColor,
    this.name,
    this.nameAbbreviation,
    this.date,
    this.description,
    this.screenshotsPathes,
  });
}