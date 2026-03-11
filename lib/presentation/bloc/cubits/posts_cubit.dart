import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_ql/data/models/post.dart';
import 'package:graph_ql/presentation/bloc/cubits/posts_cubit_states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/repositories/post_repository.dart';

class PostsCubit extends Cubit<PostsCubitStates> {
  final PostRepository repository;

  PostsCubit(this.repository) : super(PostsInitial());

  Future<void> fetchPosts() async {
    emit(PostsLoading());
    final response = await repository.fetchPosts();
    if (response.success) {
      final QueryResult queryResult = response.data;
      final queryResultData = queryResult.data;
      final List<dynamic> dynamicList = queryResultData?['posts']['data'] ?? [];
      List<Post> posts =
          dynamicList.map((post) => Post.fromJson(post)).toList();
      emit(PostsSuccess(posts));
    }
  }

  Future<void> getPostsDetail(String id) async {
    emit(PostDetailLoading());
    final response = await repository.getPostDetail(id);
    if (response.success) {
      final QueryResult queryResult = response.data;
      final queryResultData = queryResult.data;
      if (queryResultData != null) {
        final dynamicPost = queryResultData['post'];
        final Post post = Post.fromJson(dynamicPost);
        emit(PostDetailSuccess(post));
      } else {
        emit(PostDetailError('Something went wrong'));
      }
    } else {
      emit(PostDetailError(response.error));
    }
  }
}
