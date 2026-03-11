import 'package:graph_ql/data/network/network_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
}
