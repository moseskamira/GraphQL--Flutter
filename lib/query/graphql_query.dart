const String getProductsQuery = """
  query {
    products {
      id
      name
      price
      image
    }
  }
""";

const String addToCartMutation = """
  mutation AddToCart(\$productId: ID!) {
    addToCart(productId: \$productId) {
      id
      name
      price
    }
  }
""";

const String users = """
 query {
  users {
    data {
      id
      name
    }
  }
}
""";

const String posts = """
 query {
  posts {
    data {
      id
      title
    }
  }
}
""";
const String updateName = """
mutation UpdateUserName(\$id: ID!, \$newName: String!) {
  updateUser(id: \$id, name: \$newName) {
    id
    name
    email
  }
}
""";
