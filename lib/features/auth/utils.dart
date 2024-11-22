import 'package:school_erp/features/auth/auth.dart';

String getTeacherId(AuthenticatedUser user) {
  if (user.loginType != 'teacher') {
    throw Exception('Only teachers can create assignments');
  }

  if (user.loginId == null) {
    throw Exception('Teacher ID not found');
  }
  return user.loginId!;
}
