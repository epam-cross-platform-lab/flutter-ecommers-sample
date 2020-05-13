import 'package:flutter/material.dart' hide BackButton;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ecommers/ui/widgets/index.dart';

class ProductListView extends StatelessWidget {
  final String query = '''
{
  products(first: 30) {
    edges {
      cursor
      node {
        id
        title        
      }
    }
  }
}

                      ''';

  final String searchQuery = '''
query ReadRepositories(\$search: String!){
  products(first: 20, query: \$search) {
    edges {
      node {
        id
        title
        description
        tags
      }
    }
  }
}

                      ''';
  final String searchWord = 'pro*';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Products'),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(query),
          // variables: {
          //   'search': searchWord,
          // },
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            return const Center(child: Text('Countries not found.'));
          }

          return _countriesView(result);
        },
      ),
    );
  }

  ListView _countriesView(QueryResult result) {
    final List productList = result.data['products']['edges'] as List<dynamic>;
    return ListView.separated(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ListTile(
          title: Text(product['node']['title'].toString()),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
