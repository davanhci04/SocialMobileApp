import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/features/profile/domain/entities/profile_user.dart';
import 'package:untitled/features/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'] ,
            name: userData['name'] ,
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString() ,
          );
        }
      }
      return null;
    } catch (e) {
      throw Exception('Không thể lấy thông tin hồ sơ: $e');
    }
  }

  @override
  Future<void> updateProfile(ProfileUser profileUser) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(profileUser.uid)
          .update({
        'bio': profileUser.bio ,
        'profileImageUrl': profileUser.profileImageUrl ,
      });
    } catch (e) {
      throw Exception('Không thể cập nhật hồ sơ: $e');
    }
  }
}