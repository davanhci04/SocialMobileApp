import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/post/domain/entities/post.dart';
import 'package:untitled/features/post/domain/repos/post_repo.dart';
import 'package:untitled/features/post/presentation/cubits/post_states.dart';
import 'package:untitled/features/storage/domain/storage_repo.dart';

class PostCubit extends Cubit<PostStates>{
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({
    required this.postRepo,
    required this.storageRepo,
  }) :super(PostsInitial());


  // create a new post
  Future<void> createPost(Post post,
    {String? imagePath, Uint8List? imageBytes}) async{
      String? imageUrl;

      try {
        //handle image upload for mobile platforms [using file path]
      if(imagePath != null){
        emit(PostsUpLoading());
        imageUrl = await storageRepo.uploadProfileImageMobile(imagePath, post.id);
      }

      //handle image upload for web platforms [using file path]
      else if(imageBytes != null){
        emit(PostsUpLoading());
        imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      // give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      // create post in the backend
      postRepo.createPost(newPost);
      } catch (e) {
        emit(PostsError("Failed to create post: $e"));
      }
    }

    // fetch all posts
    Future<void> fetchAllPosts() async{
      try {
        
        emit(PostsLoading());
        final posts = await postRepo.fetchAllPosts();
        emit(PostsLoaded(posts));
      } catch (e) {
        emit(PostsError("Failed to fetch posts: $e"));
      }
    }

    // delete a post
    Future<void> deletePost(String postId) async {
      try {
        await postRepo.deletePost(postId);
      } catch (e) {}
    }
}