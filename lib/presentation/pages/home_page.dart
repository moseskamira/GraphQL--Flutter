import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_ql/route/routes_names.dart';

import '../../data/models/post.dart';
import '../bloc/cubits/posts_cubit.dart';
import '../bloc/cubits/posts_cubit_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY Posts"),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsCubit, PostsCubitStates>(
        listener: (BuildContext context, state) {
          if (state is PostsSuccess) {
            final postData = state.posts;
            if (postData != null && postData.isNotEmpty) {
              posts = postData;
            }
          }
          if (state is PostsError) {}
        },
        builder: (BuildContext context, state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          }
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
