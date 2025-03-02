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
  List<User> _returnUsers(QueryResult result) {
    final dynamicList = result.data?["users"]?["data"];
    if (dynamicList is List) {
      return dynamicList
          .map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Query(
        options: QueryOptions(document: gql(users)),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Error loading users: ${result.exception.toString()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          final List<User> users = _returnUsers(result);
          if (users.isEmpty) {
            return const Center(child: Text("No users found."));
          }
          return RefreshIndicator(
            onRefresh: () async => refetch?.call(),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(user.name?[0] ?? "?")),
                  title: Text(user.name ?? "Unknown"),
                  subtitle: Text("ID: ${user.id ?? "N/A"}"),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(
          () {},
        ), // Trigger a rebuild
        child: const Icon(Icons.add),
      ),
    );
  }
}
