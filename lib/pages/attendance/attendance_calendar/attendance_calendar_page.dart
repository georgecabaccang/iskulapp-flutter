import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_filters.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'dart:convert';

// For testing only. 
// Remove and replace with proper thing after.
enum Roles {student, teacher, parent}

class AttendanceCalendarPage extends StatefulWidget{

    const AttendanceCalendarPage({super.key});

    @override
    createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
    late DateTime _firstDay;
    late DateTime _lastDay;
    late DateTime _focusedDay;
    // final Map<DateTime, DateDetails> _details = {};

    // For testing purposes with students.json
    List<MockStudent> students = [];

    // For testing purposes with attendance.json
    List<AttendanceDetails> attendance = [];

    // For testing purposes for attendance for each student
    Map<DateTime, AttendanceDetails> studentAttendanceDetails = {};

    @override
    void initState() {
        super.initState();
        _firstDay = DateTime.utc(2000, 1, 1); 
        _lastDay = DateTime.utc(3000, 12, 31); 
        _focusedDay = DateTime.now(); 
        _loadAttendance();

        // Ties in with students.json testing
        _loadStudents();
    }

    Future<void> _loadAttendance() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/attendance.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var attendanceDetailsJson in decodedResponse) {
            AttendanceDetails attendanceDetails = AttendanceDetails.fromJson(attendanceDetailsJson);
            attendance.add(attendanceDetails);
        } 
    }

    void _onChangeFocusedDate(DateTime selectedDay, DateTime focusedDay) {
        setState(() {
                _focusedDay = focusedDay;
            }
        );
    }

    void _loadStudents() async {
        final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/students.json');
        final List<dynamic> decodedResponse = json.decode(response);

        for (var student in decodedResponse) {
            MockStudent mockStudent = MockStudent.fromJson(student);
            students.add(mockStudent);
        }
    }

    void _onChangeFilter(MockStudent student) {
        List<AttendanceDetails> studentAttendanceRecord = attendance.where((attendance) => attendance.studentId == student.id).toList();
        setState(() => studentAttendanceDetails = ConvertedAttendanceDetails.fromAttendanceList(studentAttendanceRecord).dateDetails);
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Attendance", 
            content: [
                AttendanceCalendar(
                    details: studentAttendanceDetails,
                    firstDay: _firstDay, 
                    lastDay: _lastDay,  
                    focusedDay: _focusedDay,
                    onChangeFocusedDate: _onChangeFocusedDate,
                ),
                AttendanceFilters(
                    role: Roles.teacher, 
                    changeFilter: _onChangeFilter,
                    students: students
                )
            ]
        );
    }
}

