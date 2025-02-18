import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/features/auth/domain/repos/auth_repo.dart';
import 'package:untitled/features/auth/domain/entities/app_user.dart';

import '../presentation/cubits/auth_states.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      email = email.trim(); // Xóa khoảng trắng đầu/cuối email

      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );
      return user;
    } catch (e) {
      print(" Login failed: $e"); // Log lỗi để debug
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim(); // Xóa khoảng trắng đầu/cuối email

      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: name,
        );

        // Lưu thông tin user vào Firestore
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set(user.toJson());
        return user;
      }

      return null;
    } catch (e) {
      print(" Registration failed: $e"); // Log lỗi để debug
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null && user.email != null) {
      return AppUser(uid: user.uid, email: user.email!.trim(), name: '');
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
