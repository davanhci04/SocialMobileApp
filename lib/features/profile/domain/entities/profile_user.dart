import 'package:untitled/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
  });

  // Cập nhật người dùng hồ sơ
  ProfileUser copyWith({String? bio, String? profileImageUrl}) {
    return ProfileUser(
      uid: this.uid,
      email: this.email,
      name: this.name,
      bio: bio ?? this.bio,  // ✅ Dùng 'bio' thay vì 'newBio'
      profileImageUrl: profileImageUrl ?? this.profileImageUrl, // ✅ Đồng bộ tên
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
    );
  }
}
