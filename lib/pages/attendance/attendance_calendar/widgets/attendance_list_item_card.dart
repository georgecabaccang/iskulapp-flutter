import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_list_item_data.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';

class AttendanceListItemCard extends StatelessWidget{
    final AttendanceListItemData attendanceData;

    const AttendanceListItemCard({
        super.key,
        required this.attendanceData
    });

    @override
    Widget build(BuildContext context) {
        return CustomItemCard(
            itemContents: [
                Text(attendanceData.student.displayName)
            ]);
    }

}