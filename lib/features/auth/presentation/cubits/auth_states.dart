import 'package:untitled/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// Trạng thái khởi tạo ban đầu
class AuthInitial extends AuthState {}

// Trạng thái đang xử lý đăng nhập/đăng ký
class AuthLoading extends AuthState {}

// Trạng thái đã xác thực (đăng nhập thành công)
class Authenticated extends AuthState {
  final AppUser user ;
  Authenticated(this.user);
}

// Trạng thái chưa xác thực (đăng nhập thất bại hoặc chưa đăng nhập)
class Unauthenticated extends AuthState {}

// Trạng thái lỗi khi đăng nhập hoặc xử lý xác thực
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
