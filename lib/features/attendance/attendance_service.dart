import 'package:powersync/powersync.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/repositories/attendance_repository.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;

class AttendanceService {
  final PowerSyncDatabase db;
  final AttendanceRepository _attendanceRepository;

  AttendanceService(
      {AttendanceRepository? attendanceRepository, PowerSyncDatabase? database})
      : db = database ?? ps.db,
        _attendanceRepository = attendanceRepository ??
            AttendanceRepository(database: database ?? ps.db);

  Future<Attendance> upsert(
    Attendance attendance,
  ) async {
    return await _attendanceRepository.upsert(attendance);
  }
}
