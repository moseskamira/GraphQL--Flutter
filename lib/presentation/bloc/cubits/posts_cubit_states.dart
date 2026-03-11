import 'package:equatable/equatable.dart';
import 'package:graph_ql/data/models/post.dart';

abstract class PostsCubitStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsCubitStates {}

class PostsLoading extends PostsCubitStates {}

class PostDeleteLoading extends PostsCubitStates {}

class PostUpdateLoading extends PostsCubitStates {}

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

class PostUpdateSuccess extends PostsCubitStates {
  final Post? post;

  PostUpdateSuccess(this.post);

  @override
  List<Object?> get props => [post];
}

class PostDeleteSuccess extends PostsCubitStates {
  final String? message;

  PostDeleteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PostDetailError extends PostsCubitStates {
  final String? errorMessage;

  PostDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostUpdateError extends PostsCubitStates {
  final String? errorMessage;

  PostUpdateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostDeleteError extends PostsCubitStates {
  final String? errorMessage;

  PostDeleteError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
