import 'package:graph_ql/data/network/network_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/post.dart';
import '../network/query/graphql_query.dart';

class PostRepository {
  final GraphQLClient client;

  PostRepository(this.client);

  Future<NetworkResponse> fetchPosts() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(posts),
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final QueryResult queryResult = await client.query(options);
      return NetworkResponse(true, data: queryResult);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }

  Future<NetworkResponse> getPostDetail(String postId) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(postDetails),
        variables: {"pID": postId},
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final QueryResult queryResult = await client.query(options);
      return NetworkResponse(true, data: queryResult);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }

  Future<NetworkResponse> updateFetchedPost(Post updateRequest) async {
    try {
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
      final QueryResult queryResult = await client.query(options);
      return NetworkResponse(true, data: queryResult);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }
}
