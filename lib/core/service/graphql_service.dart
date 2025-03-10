import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/post.dart';
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

  Future<dynamic> updateFetchedPost(Post updateRequest) async {
    final QueryOptions options = QueryOptions(
      document: gql(updatePost),
      variables: {
        'input': {
          'title': updateRequest.title,
          'body': updateRequest.body,
        },
        'pId': updateRequest.id,
      },
      fetchPolicy: FetchPolicy.cacheFirst,
    );
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data!['updatePost'];
  }

  Future<bool> deleteSelectedPost(String pID) async {
    final QueryOptions options = QueryOptions(
      document: gql(deletePost),
      variables: {'postId': pID},
      fetchPolicy: FetchPolicy.cacheFirst,
    );
    final result = await client.query(options);
    if (result.hasException) {
      return false;
    }
    return result.data?['deletePost'] == true;
  }
}
