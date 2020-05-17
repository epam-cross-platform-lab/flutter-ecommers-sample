
import 'package:ecommers/core/models/data_models/product.dart';
import 'package:ecommers/core/models/data_models/shopify/shopify_model.dart';
import 'package:ecommers/data/repository/shopify_queries.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShopifyProductsRepository {
 

  Future fetchProducts(
      {int fromId,
      int count,
                }) async {

    final options = QueryOptions(documentNode: gql(ShopifyQueries.fetchFirstProducts));
    final QueryResult result= await shopifyGrapgQLClient.queryManager.query(options);

     final  productList = ShopifyModel.fromJson( result.data as Map<String, dynamic>);

    final a=productList;
  }

  
}
