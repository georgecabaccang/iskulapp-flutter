import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_list_item_data.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';
import 'package:school_erp/theme/colors.dart';

class AttendanceListItemCard extends StatelessWidget{
    final AttendanceListItemData attendanceData;

    const AttendanceListItemCard({
        super.key,
        required this.attendanceData
    });

    Widget _buildCircle(int label, Color color) {
        return Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
                    label.toString(),
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                    ),
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return CustomItemCard(
            itemContents: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Column(
                            children: [
                                Text(attendanceData.student.displayName)
                            ],
                        ),
                        Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                        _buildCircle(attendanceData.totalPresent, AppColors.presentColor),
                                        _buildCircle(attendanceData.totalLate, AppColors.lateColor), 
                                        _buildCircle(attendanceData.totalAbsent, AppColors.absentColor),
                                        _buildCircle(attendanceData.totalLeave, AppColors.leaveColor)
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