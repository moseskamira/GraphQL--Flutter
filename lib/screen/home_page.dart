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
        options: QueryOptions(document: gql(document)),
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

          return RefreshIndicator(
            onRefresh: () async => refetch?.call(),
            child: ListView.separated(
              itemBuilder: (context, continentIndex) {
                return ExpansionTile(
                  title:
                      Text(result.data!["continents"][continentIndex]["name"]),
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result
                          .data!["continents"][continentIndex]["countries"]
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            result.data!["continents"][continentIndex]
                                ["countries"][index]["name"],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: result.data!["continents"].length,
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
