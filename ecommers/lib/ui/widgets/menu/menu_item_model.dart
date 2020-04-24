class MenuItemModel {
  final String svgAssetIconPath;
  final String title;
  final String subTitle;
  final Function() onTappedFunction;

  const MenuItemModel({
    this.svgAssetIconPath,
    this.title,
    this.subTitle,
    this.onTappedFunction,
  });
}