import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/date_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class AttendanceInfo extends StatelessWidget{
    final DateDetails details;

    const AttendanceInfo({super.key, required this.details});

    @override
    Widget build(BuildContext context) {
        return  Column(
            children: [
                Row(
                    children: [
                        Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details.attendanceStatus.displayName),
                    ],
                ),

                if (details.attendanceStatus == AttendanceStatus.late) 
                Row(
                    children: [
                        Text('Late Time: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details.lateTime ?? 'No late time recorded'),
                    ],
                ),

            ],
        );

    }
}