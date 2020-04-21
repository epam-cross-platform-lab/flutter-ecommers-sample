import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/widgets.dart';

class ProductPageProviderModel extends ProviderModelBase {
  final Product _productModel;

  List<CarouselImage> _images;
  List<CarouselImage> get images => _images;
  set images(List<CarouselImage> images) => _images = images ?? [];

  ProductPageProviderModel(this._productModel, {@required BuildContext context})
      : super(context) {
    if (_productModel?.models?.isNotEmpty == true) {
      images = _productModel.models[0].imageUrls
          ?.map((url) => CarouselImage(tag: _productModel.id, path: url))
          ?.toList();
    }
  }

  void updateImages(List<CarouselImage> assets) {
    images = assets;
    notifyListeners();
  }
}
