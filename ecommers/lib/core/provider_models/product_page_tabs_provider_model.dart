import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/widgets.dart';

class ProductPageTabsProviderModel extends ProviderModelBase {
  final Product _productModel;

  List<ProductSizeModel> _sizes;
  List<ProductSizeModel> get sizes => _sizes;
  set sizes(List<ProductSizeModel> sizes) => _sizes = sizes ?? [];

  List<ProductColorModel> _colors;
  List<ProductColorModel> get colors => _colors;
  set colors(List<ProductColorModel> colors) => _colors = colors ?? [];

  String _skuId;
  String get skuId => _skuId;
  set skuId(String skuId) => _skuId = skuId ?? '';

  ProductPageTabsProviderModel(this._productModel,
      {@required BuildContext context})
      : super(context) {
    final models = _productModel?.models;

    if (models?.isNotEmpty == true) {
      skuId = models[0]?.skuId?.toString();

      colors = _getColors(models);
      sizes = _getSizes(models);

      if (colors?.isNotEmpty == true) {
        colors[0].isSelected = true;
      }

      if (sizes?.isNotEmpty == true) {
        sizes[0].isSelected = true;
      }
    }
  }

  void updateSkuId(ProductSkuIdModel skuIdModel) {
    skuId = _productModel?.models
        ?.firstWhere((product) => product.size == skuIdModel.size)
        ?.skuId
        ?.toString();
    notifyListeners();
  }

  List<ProductColorModel> _getColors(List<ProductModel> models) {
    return models
        ?.map((product) => ProductColorModel(
            color: product.color.argb,
            images: product.imageUrls
                ?.map((url) => CarouselImage(tag: _productModel.id, path: url))
                ?.toList()))
        ?.toList();
  }

  List<ProductSizeModel> _getSizes(List<ProductModel> models) {
    return models
        ?.map((product) => ProductSizeModel(size: product.size))
        ?.toList();
  }
}
