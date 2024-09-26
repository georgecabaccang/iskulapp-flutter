import '../modified_attendance.dart' as modified;
import '../modified_attendance.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_widget.dart' as widgets;
import 'attendance_title.dart';
import 'package:school_erp/theme/colors.dart';

class AnimatedWhiteBox extends StatelessWidget {
  final AnimationState animationState;
  final PageStorageBucket bucket;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final void Function(DateTime, DateTime) onDaySelected;
  final ValueChanged<CalendarFormat> onFormatChanged;
  final ValueChanged<DateTime> onPageChanged;
  final List<DateTime> daysInMonth;
  final String selectedFilter;
  final ValueChanged<String?> onFilterChanged;

  const AnimatedWhiteBox({
    super.key,
    required this.animationState,
    required this.bucket,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.daysInMonth,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      top: animationState.isBackNavigation
          ? 420.5
          : (animationState.animate ? 100.0 : 380.0),
      left: 0,
      right: 0,
      bottom: 0,
      child: PageStorage(
        bucket: bucket,
        key: const PageStorageKey<String>('calendarAttendancePage'),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: AnimatedOpacity(
                  opacity: animationState.isBackNavigation
                      ? 0.0
                      : (animationState.animate ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      widgets.CalendarWidget(
                        // Using alias for CalendarWidget
                        focusedDay: focusedDay,
                        selectedDay: selectedDay,
                        calendarFormat: calendarFormat,
                        onDaySelected: onDaySelected,
                        onFormatChanged: onFormatChanged,
                        onPageChanged: onPageChanged,
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: AttendanceTitle(),
                            ),
                            modified.DropdownFilter(
                              // Using alias for DropdownFilter
                              selectedFilter: selectedFilter,
                              onChanged: onFilterChanged,
                            ),
                          ],
                        ),
                      ),
                      modified.AttendanceList(
                        daysInMonth: daysInMonth,
                      ), // Using alias for AttendanceList
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
