import 'package:untitled/features/post/domain/entities/post.dart';

abstract class PostState {}

class PostsInitial extends PostState {}

class PostsLoading extends PostState {}

class PostUploading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
