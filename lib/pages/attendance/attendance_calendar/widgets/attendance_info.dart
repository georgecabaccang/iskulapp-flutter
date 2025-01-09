import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/models/attendance.dart';

class AttendanceInfo extends StatelessWidget{
    final Attendance details;

    const AttendanceInfo({super.key, required this.details});

    // TO BE REMOVED, STILL THINKING ABOUT THIS.
    // String _formatTime(String? time) {
    //     if (time == null) return "No time-in recorded.";

    //     // Can be a one-liner, but opted for this for readability.
    //     DateFormat format = DateFormat("HH:mm");
    //     DateTime timeFromString = format.parse(time);
    //     DateFormat outputFormat = DateFormat("hh:mm a");
    //     return outputFormat.format(timeFromString);
    // }

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
                        Text(details.status!.displayName),
                    ],
                ),

                Row(
                    children: [
                        Text('Time in: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details.timeIn.toString()),
                    ],
                ),

            ],
        );

    }
}