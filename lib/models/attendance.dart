import 'package:flutter/material.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/enums/attendance_status.dart';
import 'package:school_erp/utils/time_utils/formatter.dart';
import 'package:school_erp/utils/time_utils/parser.dart';
import './base_model/base_model.dart';

class Attendance extends BaseModel {
  final String studentId;
  final String sectionId;
  final DateTime attendanceDate;
  final String? checkedBy;
  final TimeOfDay? timeIn;
  final AttendanceStatus? status;

  Attendance._({
    super.id,
    required this.studentId,
    required this.sectionId,
    required this.attendanceDate,
    this.checkedBy,
    this.timeIn,
    this.status,
  });

  factory Attendance({
    String? id,
    required String studentId,
    required String sectionId,
    required DateTime attendanceDate,
    required String checkedBy,
    required AttendanceStatus status,
    TimeOfDay? timeIn,
  }) {
    return Attendance._(
      id: id,
      studentId: studentId,
      sectionId: sectionId,
      checkedBy: checkedBy,
      attendanceDate: attendanceDate,
      timeIn: timeIn,
      status: status,
    );
  }

  factory Attendance.initial({
    required String studentId,
    required String sectionId,
    required DateTime attendanceDate,
  }) {
    return Attendance._(
        studentId: studentId,
        sectionId: sectionId,
        attendanceDate: attendanceDate);
  }

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'student_id': studentId,
        'section_id': sectionId,
        'checked_by': checkedBy,
        'attendance_date': toDateString(attendanceDate),
        'time_in': timeIn != null ? formatTimeOfDay(timeIn!) : null,
        'status': status!.value,
      };

  factory Attendance.fromRow(sqlite.Row row) {
    return Attendance(
      id: row['id'],
      studentId: row['student_id'],
      sectionId: row['section_id'],
      checkedBy: row['checked_by'],
      attendanceDate: DateTime.parse(row['attendance_date'] as String),
      timeIn: row['time_in'] != null ? parseTimeOfDay(row['time_in']) : null,
      status: AttendanceStatus.fromString(row['status']),
    );
  }
  Attendance copyWith({
    String? checkedBy,
    TimeOfDay? timeIn,
    AttendanceStatus? status,
  }) {
    return Attendance._(
        id: id,
        studentId: studentId,
        sectionId: sectionId,
        attendanceDate: attendanceDate,
        checkedBy: checkedBy ?? this.checkedBy,
        timeIn: timeIn ?? this.timeIn,
        status: status ?? this.status);
  }
}
