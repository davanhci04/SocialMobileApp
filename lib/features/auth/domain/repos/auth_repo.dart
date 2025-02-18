import 'package:untitled/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  Future<AppUser?> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<AppUser?> getCurrentUser();
}
