import 'package:flutter/material.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_info.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/decorators/custom_calender_builders.dart';
import 'package:school_erp/pages/common_widgets/modals/animated_custom_modal.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatelessWidget{
    final DateTime firstDay;
    final DateTime lastDay;
    final DateTime focusedDay;
    final void Function(DateTime, DateTime) onChangeFocusedDate;
    final Map<DateTime, Attendance> details;

    const AttendanceCalendar({
        super.key, 
        required this.firstDay, 
        required this.lastDay, 
        required this.focusedDay, 
        required this.onChangeFocusedDate, 
        required this.details
    });

    @override
    Widget build(BuildContext context) {
        return TableCalendar(
            focusedDay: focusedDay,
            firstDay: firstDay,
            lastDay: lastDay, 
            headerStyle: const HeaderStyle(titleCentered: true),
            availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
            },
            onDaySelected: (selectedDay, focusedDay) {
                Attendance? dayDetails = details[selectedDay];
                if (dayDetails != null) {
                    AnimatedCustomModal.show(
                        context, 
                        [AttendanceInfo(details: dayDetails)]
                    );
                }

                onChangeFocusedDate(selectedDay, focusedDay);
            },
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor
                ), 
                cellPadding: EdgeInsets.all(5)
            ),
            calendarBuilders: CustomCalenderBuilders.calendarBuilders(details)
        );
    }
}

