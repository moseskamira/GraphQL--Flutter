String posts = """query {
  posts {
    data {
      id
      title
      body
    }
  }
}
  """;

const String postDetails = """
  query GetPost(\$pID: ID!) {
    post(id: \$pID) {
      id
      title
      body
    }
  }
""";
