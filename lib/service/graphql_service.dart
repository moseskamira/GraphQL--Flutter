import 'package:graph_ql/model/post.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../query/graphql_query.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService({required this.client});

  Future<List<Post>> fetchPosts() async {
    final QueryOptions options = QueryOptions(
      document: gql(posts),
      fetchPolicy: FetchPolicy.cacheFirst,
    );
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final List<dynamic> dynamicList = result.data?['posts']['data'] ?? [];
    final listData = dynamicList.map((post) => Post.fromJson(post)).toList();

    return listData;
  }

  Future<Post> postDetail(String postId) async {
    final QueryOptions options = QueryOptions(
      document: gql(postDetails),
      variables: {"pID": postId},
      fetchPolicy: FetchPolicy.cacheFirst,
    );
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    dynamic jsonData = result.data!['post'];
    return Post.fromJson(jsonData);
  }
}
