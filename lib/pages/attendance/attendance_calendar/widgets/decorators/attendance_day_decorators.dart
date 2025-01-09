import 'package:flutter/material.dart';
import 'package:school_erp/enums/attendance_status.dart';
import 'package:school_erp/theme/colors.dart';

class AttendanceDayDecorators {
    static Color getDecorationForStatus(String status){
        // Mapping this has a little overhead, but has better scaling.
        // Can be a swtich statement if no new statuses will be added.
        final statusColors = {
            AttendanceStatus.present.value: AppColors.presentColor,
            AttendanceStatus.late.value: AppColors.lateColor,
            AttendanceStatus.authorizedAbsence.value: AppColors.leaveColor,
        };

        return statusColors[status] ?? AppColors.absentColor;
    }

    static Widget sundayDecorations(int day) {
        return SizedBox(
            child: LayoutBuilder(
                builder: (context, constraints) {
                    double parentWidth = constraints.maxWidth;
                    double parentHeight = constraints.maxHeight;

                    double childWidth = parentWidth / 1.5;
                    double childHeight = parentHeight / 1.5;

                    return Stack(
                        children: [
                            Align(
                                alignment: Alignment.center, 
                                child: Container(
                                    width: childWidth, 
                                    height: childHeight, 
                                    decoration: BoxDecoration(shape: BoxShape.circle, 
                                        color: const Color.fromARGB(100, 180, 200, 230),
                                    ),
                                ),
                            ),
                            Align(
                                alignment: Alignment.center, 
                                child: Text(
                                    '$day',
                                    style: TextStyle(
                                        color: const Color.fromARGB(255, 175, 180, 190),
                                    ),

                                ),
                            ),
                        ],
                    );
                }  )
        );
    }



}