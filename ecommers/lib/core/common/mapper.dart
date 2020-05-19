import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/data_models/product_color.dart';
import 'package:ecommers/core/models/data_models/shopify/shopify_product.dart';
import 'package:ecommers/extensions/index.dart';

class Mapper {
  static Product convertShopifyToProduct(ShopifyProduct shopifyProduct) {
    final images = shopifyProduct.node.images.edges
        .map((im) => im.node.originalSrc)
        .toList();
    final details = ProductDetails(
        brand: shopifyProduct.node.vendor,
        category: shopifyProduct.node.productType,
        material: shopifyProduct.node.options.getItem(2)?.values?.getItem(0));

    return Product(
      id: int.tryParse(shopifyProduct.node.variants.edges[0].node.sku),
      title: shopifyProduct.node.title,
      cursor: shopifyProduct.cursor,
      category: shopifyProduct.node.productType,
      subCategory: shopifyProduct.node.tags.getItem(2),
      rate: double.tryParse(shopifyProduct.node.tags.getItem(0)),
      gender: shopifyProduct.node.tags.getItem(3),
      price: double.tryParse(shopifyProduct.node.variants.edges[0].node.price),
      previewImage: shopifyProduct.node.images.edges[0].node.originalSrc,
      baseColor: _getColor(shopifyProduct.node.options.getItem(1)?.values[0]),
      images: images,
      details: details,
      models: _getProductModels(shopifyProduct).toList(),
    );
  }

  static ProductColor _getColor(String shopifyColor) {
    if (shopifyColor == null) return null;

    final colorData = shopifyColor.split('/');
    
    if (colorData.length == 1) return ProductColor(colorData.getItem(0), null);

    return ProductColor(
        colorData.getItem(0), int.tryParse(colorData.getItem(1)));
  }

  static Iterable<ProductModel> _getProductModels(
      ShopifyProduct shopifyProduct) sync* {
    var index = 0;
    for (final item in shopifyProduct.node.variants.edges) {
      yield ProductModel(
        color: _getColor(
            shopifyProduct.node.options.getItem(1)?.values?.getItem(index)),
        size: shopifyProduct.node.options.getItem(0)?.values?.getItem(index),
        skuId: int.parse(item.node.sku),
        imageUrls: shopifyProduct.node.images.edges
            .map((e) => e.node.originalSrc)
            .toList(),
      );
      index++;
    }
  }
}
