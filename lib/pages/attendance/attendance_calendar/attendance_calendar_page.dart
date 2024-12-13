import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/decorators/custom_calender_builders.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'dart:convert';

class AttendanceCalendarPage extends StatefulWidget{

    const AttendanceCalendarPage({super.key});

    @override
    createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
    late DateTime _firstDay;
    late DateTime _lastDay;
    late DateTime _focusedDay;
    List<DateDetails> _details = [];

    @override
    void initState() {
        super.initState();
        _firstDay = DateTime.utc(2000, 1, 1); 
        _lastDay = DateTime.utc(3000, 12, 31); 
        _focusedDay = DateTime.now(); 
        _loadAttendance();
    }

    Future<void> _loadAttendance() async {
        final String response = await rootBundle.loadString('assets/attendance.json');
        final List<dynamic> decoded = json.decode(response);

        setState(() {
                _details =List<DateDetails>.from(
                    decoded.map((detail) => DateDetails.fromJson(detail)));
            }
        );
    }

    void _onChangeFocusedDate(DateTime selectedDay, DateTime focusedDay) {
        setState(() {
                _focusedDay = focusedDay;
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Attendance", 
            content: [
                AttendanceCalendar(
                    details: _details,
                    firstDay: _firstDay, 
                    lastDay: _lastDay,  
                    focusedDay: _focusedDay,
                    onChangeFocusedDate: _onChangeFocusedDate,
                )
            ]
        );
    }
}

