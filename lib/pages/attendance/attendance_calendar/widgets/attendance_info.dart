import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class AttendanceInfo extends StatelessWidget{
    final AttendanceDetails details;

    const AttendanceInfo({super.key, required this.details});

    @override
    Widget build(BuildContext context) {
        return  Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                            DateFormat('dd MMM, yyyy').format(details.attendanceDate),
                            style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                ),
                Row(
                    children: [
                        Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details.status.displayName),
                    ],
                ),

                if (details.status == AttendanceStatus.late) 
                Row(
                    children: [
                        Text('Late Time: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details.timeIn ?? 'No late time recorded'),
                    ],
                ),

            ],
        );

    }
}