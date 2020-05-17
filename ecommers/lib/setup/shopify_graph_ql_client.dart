import 'package:ecommers/core/common/custom_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShopifyGrapgQLClient extends GraphQLClient {
  static const _shipifyApiUri =
      'https://flutter-ecommerce.myshopify.com/api/2020-04/graphql';
  static const _shopifyAccessToken = '8dbf69d3d1d9a2d8099501809a4a666a';

  static const _contentTypeHeader = 'application/graphql';
  static const _acceptHeader = 'application/json';

  ShopifyGrapgQLClient()
      : super(
          link: _buildLink(),
          cache: OptimisticCache(
            dataIdFromObject: typenameDataIdFromObject,
          ),
        );

  static Link _buildLink() {
    final HttpLink httpLink = HttpLink(uri: _shipifyApiUri);
    final CustomAuthLink authLink = CustomAuthLink(
      getHeaders: () {
        return {
          'ContentTtype': _contentTypeHeader,
          'Accept': _acceptHeader,
          'X-Shopify-Storefront-Access-Token': _shopifyAccessToken,
        };
      },
    );

    return authLink.concat(httpLink);
  }
}
