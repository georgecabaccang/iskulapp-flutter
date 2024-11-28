import 'package:flutter/material.dart';
import 'package:school_erp/pages/calendar/enums/attendance_filter_enum.dart';
import 'package:school_erp/pages/calendar/widgets/attendance_header.dart';
import 'package:school_erp/pages/calendar/widgets/attendance_list.dart';
import 'package:school_erp/pages/common_widgets/calendar.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class CalendarAttendancePage extends StatefulWidget {
    final DateTime focusDate;

    CalendarAttendancePage({super.key, DateTime? focusDate})
        : focusDate = focusDate ?? DateTime.now();

    @override
    createState() => _CalendarAttendancePageState();
}

class _CalendarAttendancePageState extends State<CalendarAttendancePage> {
    late DateTime _selectedDay;
    late DateTime _focusedDay;
    String _selectedFilter = AttendanceFilterEnum.all.label;
    late List<DateTime> _daysInMonth;
    // final PageStorageBucket _bucket = PageStorageBucket();

    @override
    void initState() {
        super.initState();
        _selectedDay = DateTime.now();
        _focusedDay = widget.focusDate;
        _daysInMonth = _getDaysInMonth(_focusedDay);
    }

    void _onMonthChanged(DateTime focusedDay) {
        setState(() {
                _focusedDay = focusedDay;
                _daysInMonth = _getDaysInMonth(focusedDay);
            }
        );
    }

    List<DateTime> _getDaysInMonth(DateTime date) {
        DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
        return List<DateTime>.generate(
            lastDayOfMonth.day,
            (index) => DateTime(date.year, date.month, index + 1),
        );
    }

    void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
        setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(title: 'Calendar', content: [
                Calendar(focusedDay: _focusedDay, selectedDay: _selectedDay, onDaySelected: _handleDaySelected, onPageChanged: (focusedDay) {
                        _onMonthChanged(focusedDay);
                    }
                ),
                const SizedBox(height: 20.0),
                AttendanceHeader(
                    selectedFilter: _selectedFilter, 
                    onChanged:  (newValue) {
                        setState(() {
                                _selectedFilter = newValue!;
                            });}, 
                ),
                AttendanceList(daysInMonth: _daysInMonth)
            ],
        );
    }
}
