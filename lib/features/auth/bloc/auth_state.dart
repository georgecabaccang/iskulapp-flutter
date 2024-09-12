import 'package:freezed_annotation/freezed_annotation.dart';
import '../auth_repository/auth_repository.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.authenticated(
    AuthenticatedUser user,
    String accessToken,
  ) = Authenticated;

  const factory AuthState.unauthenticated() = Unauthenticated;

  const factory AuthState.failure(
    int? statusCode,
    String message,
  ) = AuthFailure;
}
