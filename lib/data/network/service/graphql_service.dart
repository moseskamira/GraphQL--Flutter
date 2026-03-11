import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/post.dart';
import '../query/graphql_query.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService({required this.client});

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
