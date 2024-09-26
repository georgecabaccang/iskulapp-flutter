import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './widgets/attendance_title.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class CalendarAttendancePage extends StatefulWidget {
  final DateTime focusDate;

  CalendarAttendancePage({super.key, DateTime? focusDate})
      : focusDate = focusDate ?? DateTime.now();

  @override
  _CalendarAttendancePageState createState() => _CalendarAttendancePageState();
}

class AnimationState {
  bool animate;
  bool isAttendanceSelected;
  bool isBackNavigation;

  AnimationState({
    this.animate = false,
    this.isAttendanceSelected = true,
    this.isBackNavigation = false,
  });
}

class _CalendarAttendancePageState extends State<CalendarAttendancePage> {
  late AnimationState animationState;
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  String _selectedFilter = 'All';
  late List<DateTime> _daysInMonth;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    animationState = AnimationState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = widget.focusDate;
    _daysInMonth = _getDaysInMonth(_focusedDay);
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animationState.animate = true;
      });
    });
  }

  void _onMonthChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _daysInMonth = _getDaysInMonth(focusedDay);
    });
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF5278C1),
          ),
          AnimatedWhiteBox(
            animationState: animationState,
            bucket: _bucket,
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: _handleDaySelected,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _onMonthChanged(focusedDay);
            },
            daysInMonth: _daysInMonth,
            selectedFilter: _selectedFilter, // Pass the selected filter
            onFilterChanged: (newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
          ),
          FadingAppBar(
            animationState: animationState,
            onBackPressed: () {
              setState(() {
                animationState.isBackNavigation = true;
              });
              Future.delayed(const Duration(milliseconds: 800), () {
                Navigator.pop(context);
              });
            },
            selectedFilter: _selectedFilter,
            onFilterChanged: (newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}

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
            color: Colors.white,
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
                      CalendarWidget(
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
                            DropdownFilter(
                              selectedFilter: selectedFilter,
                              onChanged: onFilterChanged,
                            ),
                          ],
                        ),
                      ),
                      AttendanceList(daysInMonth: daysInMonth),
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

class FadingAppBar extends StatelessWidget {
  final AnimationState animationState;
  final VoidCallback onBackPressed;
  final String selectedFilter;
  final ValueChanged<String?> onFilterChanged;

  const FadingAppBar({
    super.key,
    required this.animationState,
    required this.onBackPressed,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: animationState.isBackNavigation
                  ? 0.0
                  : (animationState.animate ? 1.0 : 0.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBackPressed,
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: animationState.isBackNavigation
                        ? 0.0
                        : (animationState.animate ? 1.0 : 0.0),
                    child: const AttendanceButton(),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
