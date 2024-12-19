import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/student.dart';

part 'attendance_check_state.freezed.dart';

enum AttendanceCheckStatus { initial, success, failure }

@freezed
class AttendanceCheckState with _$AttendanceCheckState {
  const factory AttendanceCheckState({
    @Default([]) List<StudentAttendance> attendanceList,
    @Default(AttendanceCheckStatus.initial) AttendanceCheckStatus status,
    String? errorMessage,
  }) = _AttendanceCheckState;
}

class StudentAttendance {
  final Student student;
  final Attendance attendance;

  StudentAttendance({
    required this.student,
    required this.attendance,
  }) {
    if (student.id != attendance.studentId) {
      throw ArgumentError('Student ID does not match Attendance student ID');
    }
  }
}
