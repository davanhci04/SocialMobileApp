import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/profile/presentation/cubits/profile_states.dart';
import '../../domain/repos/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

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

  Future<void> updateProfile(String uid, String? newBio) async {
    emit(ProfileLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uid);
      if (currentUser == null) {
        emit(ProfileError(message: 'Failed to update profile'));
        return;
      }

      final updatedProfile = currentUser.copyWith(
        bio: newBio ?? currentUser.bio,
      );

      await profileRepo.updateProfile(updatedProfile);
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError(message: "Error updating profile: $e"));
    }
  }
}
