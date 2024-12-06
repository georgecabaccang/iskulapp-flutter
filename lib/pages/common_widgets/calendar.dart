import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
    final DateTime focusedDay;
    final DateTime selectedDay;
    final void Function(DateTime, DateTime) onDaySelected;
    final ValueChanged<DateTime> onPageChanged;

    const Calendar({
        super.key,
        required this.focusedDay,
        required this.selectedDay,
        required this.onDaySelected,
        required this.onPageChanged,
    });

    @override
    Widget build(BuildContext context) {
        return TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2123, 12, 31),
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
                onDaySelected(selectedDay, focusedDay);
            },
            headerStyle: const HeaderStyle(titleCentered: true),
            onPageChanged: (focusedDay) {
                onPageChanged(focusedDay);
            },
            availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
            });
    }
}