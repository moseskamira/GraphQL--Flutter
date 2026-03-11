import 'package:equatable/equatable.dart';
import 'package:graph_ql/data/models/post.dart';

abstract class PostsCubitStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsCubitStates {}

class PostsLoading extends PostsCubitStates {}

class PostsSuccess extends PostsCubitStates {
  final List<Post>? posts;

  PostsSuccess(this.posts);
}

class PostsError extends PostsCubitStates {
  final String? errorMessage;

  PostsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
