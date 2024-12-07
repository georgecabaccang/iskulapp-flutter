import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AuthenticatedUser with _$AuthenticatedUser {
  const factory AuthenticatedUser({
    required String id,
    required String email,
    required String role,
    @JsonKey(name: 'login_type') required String loginType,
    @JsonKey(name: 'login_id') required String loginId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'school_id') required String schoolId,
    @JsonKey(name: 'school_name') required String schoolName,
    @JsonKey(name: 'academic_year_id') required String academicYearId,
    @JsonKey(name: 'academic_year_name') required String academicYearName,
  }) = _AuthenticatedUser;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);
}
