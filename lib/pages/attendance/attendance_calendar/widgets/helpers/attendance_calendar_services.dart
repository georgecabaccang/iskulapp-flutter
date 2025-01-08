import 'package:flutter/services.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/models/section.dart';
import 'dart:convert';

import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'package:school_erp/repositories/sections_repository.dart';

class AttendanceCalendarServices {
    static Future< List<Section>> loadSectionsOfTeacher(String teacherId, String academicYearId) async {
        try {
            SectionRepository sectionRepo = SectionRepository();

            final List<Section> responseSections = await sectionRepo.getTeacherSectionsAll(teacherId: teacherId, academicYearId: academicYearId);

            if (responseSections.isEmpty) {
                throw Exception("Failed to fetch sections.");
            }

            return responseSections;
        } catch (error) {
            rethrow;
        }
    }

    // Refactor this code to request data with the query for per section
    // EXAMPLE: SELECT * FROM attendance WHERE section_id = section.id
    static Future<List<AttendanceDetails>> loadStudentAttendance(MockSection section) async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/attendance.json');
        final List<dynamic> decodedResponse = json.decode(response);

        List<AttendanceDetails> studentAttendance = [];

        for (var attendanceDetailsJson in decodedResponse) {
            AttendanceDetails attendanceDetails = AttendanceDetails.fromJson(attendanceDetailsJson);
            studentAttendance.add(attendanceDetails);
        } 

        return studentAttendance = studentAttendance.where((attendance) => attendance.sectionId == section.id).toList();
    }

    // Refactor this code to request data with the query for students of section
    // EXAMPLE: SELECT * FROM students WHERE section_id = section.id
    static Future< List<MockStudent>> loadStudentsOfSection(MockSection section) async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/students.json');
        final List<dynamic> decodedResponse = json.decode(response);

        List<MockStudent> students = [];

        for (var student in decodedResponse) {
            MockStudent mockStudent = MockStudent.fromJson(student);
            students.add(mockStudent);
        }

        return students = students.where((student) => student.sectionId == section.id).toList();
    }
}