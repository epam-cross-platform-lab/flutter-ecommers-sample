import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/widgets.dart';

class ProductPageProviderModel extends ProviderModelBase {
  final Product _productModel;

  List<CarouselImage> _images;
  List<CarouselImage> get images => _images;
  set images(List<CarouselImage> images) => _images = images ?? [];

  List<ProductSizeModel> _sizes;
  List<ProductSizeModel> get sizes => _sizes;
  set sizes(List<ProductSizeModel> sizes) => _sizes = sizes ?? [];

  List<ProductColorModel> _colors;
  List<ProductColorModel> get colors => _colors;
  set colors(List<ProductColorModel> colors) => _colors = colors ?? [];

  String _skuId;
  String get skuId => _skuId;
  set skuId(String skuId) => _skuId = skuId ?? '';

  ProductPageProviderModel(this._productModel, {@required BuildContext context})
      : super(context) {
    _initProductImages();
    _initProductTab();
    _saveRecentProduct();
  }

  void updateImages(List<CarouselImage> assets) {
    images = assets;
    notifyListeners();
  }

  void _initProductImages() {
    if (_productModel?.models?.isNotEmpty == true) {
      images = _productModel.models[0].imageUrls
          ?.map((url) => CarouselImage(tag: _productModel.id, path: url))
          ?.toList();
    }
  }

  void _initProductTab() {
    final models = _productModel?.models;

    if (models?.isNotEmpty == true) {
      skuId = models[0]?.skuId?.toString();

      colors = _getColors(models);
      sizes = _getSizes(models);

      if (colors?.isNotEmpty == true) {
        colors
            .firstWhere(
                (element) => element.color == _productModel.baseColor.argb,
                orElse: () => colors[0])
            ?.isSelected = true;
      }

      if (sizes?.isNotEmpty == true) {
        sizes[0].isSelected = true;
      }
    }
  }

  Future _saveRecentProduct() async {
    await productService.trySaveRecentProduct(_productModel.toJson());
  }

  void updateSkuId(ProductSkuIdModel skuIdModel) {
    skuId = _productModel?.models
        ?.firstWhere(
            (product) =>
                product.color?.argb == skuIdModel.color &&
                product.size == skuIdModel.size,
            orElse: () => null)
        ?.skuId
        ?.toString();
    notifyListeners();
  }

  List<ProductColorModel> _getColors(List<ProductModel> models) {
    final uniqueColors =
        Set.of(models?.map((product) => product.color?.argb))?.toList();

    return uniqueColors
        ?.map((color) => _covertToProductColorModel(
            models?.firstWhere((product) => product.color?.argb == color)))
        ?.toList();
  }

  ProductColorModel _covertToProductColorModel(ProductModel product) {
    return ProductColorModel(
        color: product?.color?.argb ?? 0,
        images: product.imageUrls
            ?.map((url) => CarouselImage(tag: _productModel?.id, path: url))
            ?.toList());
  }

  List<ProductSizeModel> _getSizes(List<ProductModel> models) {
    return models
        ?.map((product) => ProductSizeModel(size: product.size))
        ?.toList();
  }
}
