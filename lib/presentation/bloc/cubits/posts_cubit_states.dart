import 'package:equatable/equatable.dart';
import 'package:graph_ql/data/models/post.dart';

abstract class PostsCubitStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsCubitStates {}

class PostsLoading extends PostsCubitStates {}

class PostDetailLoading extends PostsCubitStates {}

class PostsSuccess extends PostsCubitStates {
  final List<Post>? posts;

  PostsSuccess(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostDetailSuccess extends PostsCubitStates {
  final Post? post;

  PostDetailSuccess(this.post);

  @override
  List<Object?> get props => [post];
}

class PostDetailError extends PostsCubitStates {
  final String? errorMessage;

  PostDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
