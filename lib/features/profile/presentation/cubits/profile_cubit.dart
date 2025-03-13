import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_states.dart';
import 'package:untitled/features/storage/domain/storage_repo.dart';
import '../../domain/repos/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;

  ProfileCubit({required this.profileRepo, required this.storageRepo}) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(profileUser: user));
      } else {
        emit(ProfileError(message: 'User not found'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile(
    String uid,
    String? newBio,
    Uint8List? imageWebBytes,
    String? imageMobilePath,
  ) async {
    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uid);
      if (currentUser == null) {
        emit(ProfileError(message: 'Failed to update profile'));
        return;
      }

      // profile picture update
      String? imageDownloadUrl;

      if (imageWebBytes != null || imageMobilePath != null) {
        // for mobile
        if (imageMobilePath != null) {
          // upload
          imageDownloadUrl = await storageRepo.uploadProfileImageMobile(imageMobilePath, uid);
        }
        // for web
        else if (imageWebBytes != null) {
          // upload
          imageDownloadUrl = await storageRepo.uploadProfileImageWeb(imageWebBytes, uid);
        }

        if (imageDownloadUrl == null) {
          emit(ProfileError(message: "Failed to upload image"));
          return;
        }
      }

      final updatedProfile = currentUser.copyWith(
        bio: newBio ?? currentUser.bio,
        profileImageUrl: imageDownloadUrl ?? currentUser.profileImageUrl, // Sửa lỗi ở đây
      );

      await profileRepo.updateProfile(updatedProfile);
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError(message: "Error updating profile: $e"));
    }
  }
}