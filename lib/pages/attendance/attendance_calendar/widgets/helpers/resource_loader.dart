import 'package:flutter/services.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'dart:convert';

class ResourceLoader {
    final List<AttendanceDetails> studentAttendance = [];
    final List<AttendanceDetails> teacherAttendance = [];
    final List<MockTeacher> teachers = [];
    final List<MockStudent> students = [];

    Future<void> loadResources() async {
        await Future.wait([
                loadStudentAttendance(),
                loadTeacherAttendance(),
                loadTeachers(),
                loadStudents()
            ]);
    }

    Future<void> loadStudentAttendance() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/attendance.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var attendanceDetailsJson in decodedResponse) {
            AttendanceDetails attendanceDetails = AttendanceDetails.fromJson(attendanceDetailsJson);
            studentAttendance.add(attendanceDetails);
        } 
    }

    Future<void> loadTeacherAttendance() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/teacher_attendance.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var attendanceDetailsJson in decodedResponse) {
            AttendanceDetails attendanceDetails = AttendanceDetails.fromJson(attendanceDetailsJson);
            teacherAttendance.add(attendanceDetails);
        } 
    }

    Future<void> loadTeachers() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/teachers.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var teacher in decodedResponse) {
            MockTeacher mockTeacher = MockTeacher.fromJson(teacher);
            teachers.add(mockTeacher);
        }
    }

    Future<void>  loadStudents() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/students.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var student in decodedResponse) {
            MockStudent mockStudent = MockStudent.fromJson(student);
            students.add(mockStudent);
        }
    }
}