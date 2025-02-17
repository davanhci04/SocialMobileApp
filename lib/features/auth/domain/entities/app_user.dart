class AppUser {
  final String uid;
  final String email;
  final String name;

  // Constructor
  AppUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  // Convert AppUser -> JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // Convert JSON -> AppUser
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
