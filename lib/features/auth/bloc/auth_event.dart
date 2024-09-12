sealed class AuthEvent {}

final class AuthCheckRequested extends AuthEvent {}

final class LoginRequested extends AuthEvent {
  LoginRequested(this.email, this.password);

  final String email;
  final String password;
}

final class LogoutRequested extends AuthEvent {}
