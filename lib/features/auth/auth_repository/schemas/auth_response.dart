import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
sealed class AuthResult with _$AuthResult {
  const factory AuthResult.success(
          AuthenticatedUser user, String accessToken, DateTime tokenExpiry) =
      AuthRequestSuccess;

  const factory AuthResult.failure(
    int statusCode,
    String message,
  ) = AuthRequestFailure;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}
