import 'package:untitled/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;
  final List<String> followers;
  final List<String> following;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  // Cập nhật người dùng hồ sơ
  ProfileUser copyWith({
    String? bio,
    String? profileImageUrl,
    List<String>? newFollowers,
    List<String>? newFollowing,
  }) {
    return ProfileUser(
      uid: this.uid,
      email: this.email,
      name: this.name,
      bio: bio ?? this.bio,
      // ✅ Dùng 'bio' thay vì 'newBio'
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      // ✅ Đồng bộ tên
      followers: newFollowers ?? followers,
      // ✅ Đồng bộ tên
      following: newFollowing ?? following, // ✅ Đồng bộ tên
    );
  }

  // Convert ProfileUser -> JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
    };
  }

  // Convert JSON -> ProfileUser
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
    );
  }
}
