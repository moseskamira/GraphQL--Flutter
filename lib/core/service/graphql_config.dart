import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink("https://graphqlzero.almansi.me/api");

  static ValueNotifier<GraphQLClient> valueNotifierClient() => ValueNotifier(
        GraphQLClient(
          link: httpLink,
          cache: GraphQLCache(),
        ),
      );
}
