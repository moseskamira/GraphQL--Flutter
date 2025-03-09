import 'package:flutter/material.dart';
import 'package:graph_ql/ui/routes/routes_names.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/model/post.dart';
import '../../core/service/graphql_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY Posts"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: GraphQLService(client: GraphQLProvider.of(context).value)
            .fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) {
            return Text('No Data Found');
          }
          final List<Post> posts = snapshot.data!;
          return ListView.separated(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    arguments: {'postId': '${posts[index].id}'},
                    RoutesNames.postDetails,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text('${posts[index].title}'),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
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
