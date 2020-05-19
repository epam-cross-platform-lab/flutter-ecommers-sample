import 'package:ecommers/core/common/mapper.dart';
import 'package:ecommers/core/models/data_models/shopify/shopify_model.dart';
import 'package:ecommers/core/models/product_sort_keys.dart';
import 'package:ecommers/data/repository/shopify_queries.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShopifyProductsRepository {
  Future fetchProducts({
    String fromId,
    int count,
    String query,
    ProductSortKeys productSortKey,
    bool descending,
  }) async {
    final QueryOptions queryOptions = QueryOptions(
      documentNode: gql(ShopifyQueries.fetchProducts),
      variables: {
        'count': count,
        'fromId': fromId,
        'searchQuery': query,
        'sortType': _getSortType(productSortKey),
        'descending': descending,
      },
    );

    final QueryResult result =
        await shopifyGrapgQLClient.queryManager.query(queryOptions);

    final productList =
        ShopifyModel.fromJson(result.data as Map<String, dynamic>);
    final products = productList.products.edges
        .map((e) => Mapper.convertShopifyToProduct(e))
        .toList();
    return products;
  }

  String _getSortType(ProductSortKeys productSortKey) {
    switch (productSortKey) {
      case ProductSortKeys.title:
        return 'TITLE';
      case ProductSortKeys.productType:
        return 'PRODUCT_TYPE';
      case ProductSortKeys.vendor:
        return 'VENDOR';
      case ProductSortKeys.inventoryTotal:
        return 'INVENTORY_TOTAL';
      case ProductSortKeys.updatedAt:
        return 'UPDATED_AT';
      case ProductSortKeys.createdAt:
        return 'CREATED_AT';
      case ProductSortKeys.publishedAt:
        return 'PUBLISHED_AT';
      default:
        return null;
        break;
    }
  }
}
