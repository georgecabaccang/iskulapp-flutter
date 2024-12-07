import 'package:school_erp/features/auth/auth.dart';

String getTeacherId(AuthenticatedUser user) {
  if (user.loginType != 'teacher') {
    throw Exception('Only teachers can create assignments');
  }

  return user.loginId;
}

AuthenticatedUser getAuthUser(AuthState authState) {
  return switch (authState) {
    Authenticated(:final user) => user,
    _ => throw Exception('User must be authenticated'),
  };
}
