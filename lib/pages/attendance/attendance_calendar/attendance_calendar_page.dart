import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/date_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
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
    final Map<DateTime, DateDetails> _details = {};

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
        final Map<String, dynamic> decoded = json.decode(response);

        Map<DateTime, DateDetails> loadedDetails = {};

        decoded.forEach((key, value) {
                Date date = Date.fromJson({key: value});
                loadedDetails.addAll(date.date);
            }
        );

        setState(() {
                _details.addAll(loadedDetails);  
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

