import 'package:flutter/material.dart';
import 'package:graph_ql/model/user.dart';
import 'package:graph_ql/query/graphql_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Query(
        options: QueryOptions(document: gql(users)),
        builder: (QueryResult result, {fetchMore, refetch}) {
          List<User> users = [];
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(child: Text("Error loading products"));
          }
          dynamic dynamicList = result.data!["users"]["data"];
          if (dynamicList is List) {
            users = dynamicList
                .map((item) => User.fromJson(item as Map<String, dynamic>))
                .toList();
          } else {
            print("No could be found.");
          }
          return Column(
            children: users.map((user) => Text('${user.name}')).toList(),
          );
        },
      ),
    );
  }
}
