import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/widgets.dart';

class ProductPageProviderModel extends ChangeNotifier with BusyNotifier  {
  static  const String undefineTagValue = 'undef';
  
  final Product _productModel;
  dynamic heroImageTag;

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

  String get selectSize => _sizes.firstWhere((element) => element.isSelected,  orElse: () => sizes[0]).size;
  String get selectColor => _colors.firstWhere((element) => element.isSelected,  orElse: () => _colors[0]).title;

  ProductPageProviderModel(this._productModel) {
    _initProductImages();
    _initProductTab();
    _saveRecentProduct();
    heroImageTag = _productModel.id;
  }

  void updateImages(List<CarouselImage> assets) {
    images = assets;
    notifyListeners();
  }

  void navigateToCart() {
    const int shellCartIndex = 2;
    
    heroImageTag = undefineTagValue;
    notifyListeners();
    
    navigationService.goBackToShell(index: shellCartIndex);
  }

  void _initProductImages() {
    if (_productModel?.models?.isNotEmpty == true &&
        _productModel.models[0] != null &&
        _productModel.models[0].imageUrls?.isNotEmpty == true) {
      images = [
        CarouselImage(
            path: _productModel.models[0].imageUrls.first,
            previewImage: _productModel.previewImage),
        ..._productModel.models[0].imageUrls
            .skip(1)
            .map((url) => CarouselImage(path: url))
            .toList()
      ];
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
        title: product?.color?.title,
        images: product.imageUrls
            ?.map((url) => CarouselImage(path: url))
            ?.toList());
  }

  List<ProductSizeModel> _getSizes(List<ProductModel> models) {
    return models
        ?.map((product) => ProductSizeModel(size: product.size))
        ?.toList();
  }
}
