import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final void Function(DateTime, DateTime) onDaySelected;
  final ValueChanged<CalendarFormat> onFormatChanged;
  final ValueChanged<DateTime> onPageChanged;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2123, 12, 31),
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay, focusedDay);
      },
      onFormatChanged: (format) {
        onFormatChanged(format);
      },
      onPageChanged: (focusedDay) {
        onPageChanged(focusedDay);
      },
    );
  }
}

class DropdownFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String?> onChanged;

  const DropdownFilter({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedFilter,
      items: [
        _buildDropdownItem('All', Colors.white, Colors.grey),
        _buildDropdownItem('Absent', Colors.red, Colors.transparent),
        _buildDropdownItem('Late', Colors.orange, Colors.transparent),
        _buildDropdownItem('Holiday', Colors.green, Colors.transparent),
      ],
      onChanged: onChanged,
      underline: const SizedBox(),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(
      String label, Color color, Color borderColor) {
    return DropdownMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class AttendanceButton extends StatelessWidget {
  const AttendanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        "ATTENDANCE",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AttendanceList extends StatelessWidget {
  final List<DateTime> daysInMonth;

  const AttendanceList({
    super.key,
    required this.daysInMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: daysInMonth.length,
        itemBuilder: (context, index) {
          DateTime date = daysInMonth[index];
          String day = DateFormat('dd').format(date);
          String shortMonth = DateFormat('MMM').format(date);
          String weekday = DateFormat('EEEE').format(date);

          bool isHoliday = (weekday == "Saturday" || weekday == "Sunday");
          String status = isHoliday ? "Holiday" : "Present";

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          shortMonth,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            weekday,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Divider(),
              ),
            ],
          );
        },
      ),
    );
  }
}
