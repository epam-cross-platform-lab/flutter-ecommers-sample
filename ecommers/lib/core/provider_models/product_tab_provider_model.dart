import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:flutter/widgets.dart';

class ProductTabProviderModel extends ProviderModelBase {
  List<ProductColorModel> _colors;
  List<ProductSizeModel> _sizes;

  List<ProductSizeModel> get sizes => _sizes;
  set sizes(List<ProductSizeModel> sizes) => _sizes = sizes ?? [];

  List<ProductColorModel> get colors => _colors;
  set colors(List<ProductColorModel> colors) => _colors = colors ?? [];

  ProductTabProviderModel(this._colors, this._sizes,
      {@required BuildContext context})
      : super(context);

  void selectSize(int index) {
    sizes.forEach(_unselectSizes);
    sizes[index].isSelected = true;

    notifyListeners();
  }

  void selectColor(int index) {
    colors.forEach(_unselectColors);
    colors[index].isSelected = true;

    notifyListeners();
  }

  void _unselectSizes(ProductSizeModel size) {
    size.isSelected = false;
  }

  void _unselectColors(ProductColorModel color) {
    color.isSelected = false;
  }
}
