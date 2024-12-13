import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/decorators/attendance_day_decorators.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalenderBuilders {
    static CalendarBuilders calendarBuilders(List<DateDetails> details) {
        return CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
                bool isSunday = day.weekday == 7;
                DateDetails? dayDetails;

                // immediately return decorations for sunday if isSunday to skip looping through details
                if (isSunday) return AttendanceDayDecorators.sundayDecorations(day.day);

                for (var detail in details) {
                    if (detail.date?.year == day.year &&
                        detail.date?.month == day.month &&
                        detail.date?.day == day.day) {
                        dayDetails = detail;
                        break;
                    }
                }

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
                                                color: dayDetails != null ? AttendanceDayDecorators.getDecorationForStatus(dayDetails.attendanceStatus) : Colors.transparent,
                                            ),
                                        ),
                                    ),
                                    Align(
                                        alignment: Alignment.center, 
                                        child: Text(
                                            '${day.day}',
                                        ),
                                    ),
                                ],
                            );
                        }  )
                );

            }

        );
    }
}


enum AttendanceStatus {
    present('present', "Present"),
    late("late", "Late"),
    absent("absent", "Absent"),
    authorizedAbsence("authorizedAbsence", "Leave");

    final String value;
    final String displayName;

    const AttendanceStatus(this.value, this.displayName);
}

class DateDetails {
    final DateTime? date;
    final String attendanceStatus;
    final String? lateTime;

    DateDetails({
        required this.date, 
        required this.attendanceStatus, 
        required this.lateTime
    });

    factory DateDetails.fromJson(Map<String, dynamic> json) {
        return DateDetails(
            date: DateTime.parse(json['date']),
            attendanceStatus: json['attendanceStatus'] ?? '',
            lateTime: json['lateTime'] ?? '',
        );
    }
}
