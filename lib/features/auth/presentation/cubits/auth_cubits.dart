import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/domain/entities/app_user.dart';
import 'package:untitled/features/auth/domain/repos/auth_repo.dart';
import 'package:untitled/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // Check if user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // Get current user
  AppUser? get currentUser => _currentUser;

  // Login with email + password
  Future<void> loginWithEmailAndPassword(String email, String pw) async {
    emit(AuthLoading());
    try {
      final AppUser? user = await authRepo.loginWithEmailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      await Future.delayed(
          const Duration(seconds: 2)); // Show error for 2 seconds
      emit(Unauthenticated());
    }
  }

  // Register with email + password
  Future<void> registerWithEmailAndPassword(
      String name, String email, String pw) async {
    emit(AuthLoading());
    try {
      final AppUser? user = await authRepo.registerWithEmailPassword(
          email: email, password: pw, name: name);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      await Future.delayed(
          const Duration(seconds: 2)); // Show error for 2 seconds
      emit(Unauthenticated());
    }
  }

  // Logout
  Future<void> logout() async {
    await authRepo.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }
}
