import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_list_item_data.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';
import 'package:school_erp/theme/colors.dart';

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        attendanceData.student.displayName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                    ),
                                ],
                            ),
                        ),
                        Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                        AttendanceCalendarUtils.buildStatus(context, attendanceData.totalPresent.toString(), AppColors.presentColor, true),
                                        AttendanceCalendarUtils.buildStatus(context, attendanceData.totalLate.toString(), AppColors.lateColor, true), 
                                        AttendanceCalendarUtils.buildStatus(context, attendanceData.totalAbsent.toString(), AppColors.absentColor, true),
                                        AttendanceCalendarUtils.buildStatus(context, attendanceData.totalLeave.toString(), AppColors.leaveColor, true)
                                    ],
                                )
                            ],
                        )
                    ],
                )
            ]
        );
    }
}