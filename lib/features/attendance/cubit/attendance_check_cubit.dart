import 'package:school_erp/features/attendance/attendance_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_state.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/repositories/attendance_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';

class AttendanceCheckCubit extends Cubit<AttendanceCheckState> {
  final AttendanceService _attendanceService;
  final AttendanceRepository _attendanceRepository;
  final StudentRepository _studentRepository;

  AttendanceCheckCubit({
    required AttendanceService attendanceService,
    required AttendanceRepository attendanceRepository,
    required StudentRepository studentRepository,
  })  : _attendanceService = attendanceService,
        _attendanceRepository = attendanceRepository,
        _studentRepository = studentRepository,
        super(const AttendanceCheckState());

  void getAttendanceList({
    required DateTime date,
    required String sectionId,
  }) async {
    var studentList = await _studentRepository.getStudentsBySection(sectionId);

    var initAttendanceList =
        await _attendanceRepository.getStudentsAttendanceByDateAndSection(
      attendanceDate: date,
      sectionId: sectionId,
    );

    var attendanceList = <StudentAttendance>[];

    // combine existing attendance records with students with no attendance record
    for (var student in studentList) {
      var attendance = initAttendanceList.firstWhere(
        (a) => a.studentId == student.id,
        orElse: () => Attendance.initial(
            studentId: student.id, sectionId: sectionId, attendanceDate: date),
      );
      attendanceList.add(
        StudentAttendance(student: student, attendance: attendance),
      );
    }
    emit(state.copyWith(
        attendanceList: attendanceList, status: AttendanceCheckStatus.success));
  }

  void createUpdateAttendance({
    required int index,
    required Attendance attendance,
  }) async {
    try {
      var updatedAttendance = await _attendanceService.upsert(attendance);

      final updatedList = List<StudentAttendance>.from(state.attendanceList);
      updatedList[index] = StudentAttendance(
        student: updatedList[index].student,
        attendance: updatedAttendance,
      );
      emit(state.copyWith(
          attendanceList: updatedList, status: AttendanceCheckStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: AttendanceCheckStatus.failure, errorMessage: e.toString()));
    }
  }
}
