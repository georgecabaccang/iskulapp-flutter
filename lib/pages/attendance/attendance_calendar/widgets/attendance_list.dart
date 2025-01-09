import 'package:flutter/material.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_list_item_data.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_list_item_card.dart';
import 'package:school_erp/pages/common_widgets/lists/custom_list_view.dart';

class AttendanceList extends StatelessWidget {
    final List<Student> students;
    final List<Attendance> attendance;
    final int range;

    const AttendanceList({
        super.key,
        required this.students,
        required this.attendance,
        required this.range
    });

    // Configured like this it to keep it pure.
    List<AttendanceListItemData> _handleDisplayOfStudentData(List<Student> students, List<Attendance> attendance, int range ) {
        List<AttendanceListItemData> itemData = [];

        for (var student in students) {
            itemData.add(AttendanceListItemData.generateData(student, attendance, range));
        }

        return itemData;
    }

    @override
    Widget build(BuildContext context) {
        return CustomListView(
            listOfData: _handleDisplayOfStudentData(students, attendance, range), 
            itemBuilder: (context, itemDetails) => AttendanceListItemCard(attendanceData: itemDetails)
        );
    }

}