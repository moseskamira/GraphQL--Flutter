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

const String updatePost = """
        mutation UpdatePost(\$pId: ID!, \$input: UpdatePostInput!) {
          updatePost(id:\$pId, input: \$input) {
            id
            title
            body
          }
        }
      """;
