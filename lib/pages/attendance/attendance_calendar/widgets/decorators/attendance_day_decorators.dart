import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class AttendanceDayDecorators {
    static Color getDecorationForStatus(String status){
        // Will change this. Fow, is okay.
        return status == AttendanceStatus.present.value 
            ? Colors.green.withOpacity(0.5) 
            : status == AttendanceStatus.late.value 
                ? const Color.fromARGB(255, 240, 190, 50).withOpacity(0.7) 
                :  status == AttendanceStatus.leave.value
                    ? const Color.fromARGB(220, 0, 190, 210)
                    : Colors.red.withOpacity(0.7);
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