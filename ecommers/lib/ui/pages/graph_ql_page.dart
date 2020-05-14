import 'package:ecommers/core/common/custom_link.dart';
import 'package:ecommers/ui/widgets/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GrapgQLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: 'https://flutter-ecommerce.myshopify.com/api/2020-04/graphql');
    final CustomAuthLink authLink = CustomAuthLink(
    getHeaders: () {return {
                            'ContentTtype' : 'application/graphql',
                            'Accept' : 'application/json',
      'X-Shopify-Storefront-Access-Token' : '8dbf69d3d1d9a2d8099501809a4a666a',
                            };},

  );
    final Link link = authLink.concat(httpLink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GraphQLProvider(
        client: client,
        child: ProductListView(),
      ),
    );
  }
}