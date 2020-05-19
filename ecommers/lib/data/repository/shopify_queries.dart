class ShopifyQueries {
  static const String fetchProducts = '''
query fetchProducts(\$count: Int!, \$fromId: String, \$searchQuery: String, \$sortType: ProductSortKeys, \$descending: Boolean){
  products(first:\$count, after:\$fromId, query:\$searchQuery, sortKey:\$sortType, reverse:\$descending ) {
    edges {
      cursor
      node {
        id
        title 
        description
        vendor
        tags
        productType
        totalInventory
        variants(first: 10) {
          edges {
            node {
              id
              price
              sku
              compareAtPrice
            }
          }
        }
        images(first: 10) {
          edges {
            node {
              id
              originalSrc
            }
          }
        }
        options {
          values
          id
          name
        }
      }
    }
  }
}
''';
}
