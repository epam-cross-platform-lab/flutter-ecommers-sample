class ShopifyQueries{
 static const String fetchFirstProducts = '''
{
  products(first: 10) {
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
 static const String fetchProductsFrom = '''
{
  products(first: 50, after: "eyJsYXN0X2lkIjo0NjEyMDQyMzU4ODY0LCJsYXN0X3ZhbHVlIjoiNDYxMjA0MjM1ODg2NCJ9") {
    edges {
      cursor
      node {
        id
        title 
        description
        vendor
        tags
        options {
          id
          values
        }
      }
    }
  }
}
''';
 static const String sortProductsFrom = '''
{
  products(first: 50, after: "eyJsYXN0X2lkIjo0NjEyMDQyMzU4ODY0LCJsYXN0X3ZhbHVlIjoiNDYxMjA0MjM1ODg2NCJ9", sortKey:PRODUCT_TYPE) {
    edges {
      cursor
      node {
        id
        title 
        description
        vendor
        tags
        productType
        totalVariants
        options {
          id
          name
        }
      }
    }
  }
}
''';
  static const String search = '''
query SearchProducts(\$search: String!){
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
}