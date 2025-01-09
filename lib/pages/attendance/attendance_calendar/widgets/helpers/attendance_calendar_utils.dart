import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/theme/colors.dart';

class AttendanceCalendarUtils {

    // CAN UNCOMMENT THIS IF STILL NEEDED.
    // This function is configured like this to keep it pure.
    // static List<EntityDisplayData> peopleOptions(
    //     FilterByType? filter,
    //     List<MockStudent> studentsOfSection,
    //     List<MockTeacher> teachersOfSection,
    // ) {
    //     if (filter == null) return [];
    //     if (filter.value == "teacher") return teachersOfSection;
    //     return studentsOfSection;
    // }

    static String dateToStringConverter(DateTime date) {
        String formattedDate = DateFormat('dd MMM, yyyy').format(date);
        return formattedDate;
    }

    static Widget buildStatus(BuildContext context, String label, Color color, bool isInCircle) {
        double screenWidth = MediaQuery.of(context).size.width;

        double containerSize = isInCircle ? screenWidth * 0.075 : screenWidth * 0.06; 
        double fontSize = screenWidth * 0.022;
        double paddingHorizontal = screenWidth * 0.002;
        double textSpacing = screenWidth * 0.01;

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal), 
            child: Row(
                children: [
                    Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                        ),
                        child: isInCircle 
                            ? Center(
                                child: Text(
                                    label.toString(),
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                    ),
                                ),
                            )
                            : SizedBox.shrink() 
                    ),
                    if (!isInCircle) 
                    Row(
                        children: [
                            SizedBox(width: textSpacing),
                            Text(
                                label, 
                                style: TextStyle(fontSize: fontSize)
                            )
                        ],
                    ),
                ],
            ),
        );
    }

    static Map<DateTime, Attendance> convertAttendanceDetails(List<Attendance> attendanceDetails) {
        final Map<DateTime, Attendance> dateDetails = {};

        for (var detail in attendanceDetails) {
            dateDetails[detail.attendanceDate] = detail;
        }

        return dateDetails;
    }
}

