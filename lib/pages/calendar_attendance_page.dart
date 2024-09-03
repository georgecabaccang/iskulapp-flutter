import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class CalendarAttendancePage extends StatefulWidget {
  final DateTime focusDate;

  CalendarAttendancePage({Key? key, DateTime? focusDate})
      : focusDate = focusDate ?? DateTime.now(),
        super(key: key);

  @override
  _CalendarAttendancePageState createState() => _CalendarAttendancePageState();
}

class AnimationState {
  bool animate = false;
  bool isAttendanceSelected = true;
  bool isBackNavigation = false;

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
  String _selectedFilter = 'All'; // Variable to store the selected filter
  late List<DateTime> _daysInMonth; // List to hold days of the current month

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue background color
          Container(
            color: const Color(0xFF5278C1),
          ),
          // White box that starts at the same position as in the HomePage
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            top: animationState.isBackNavigation
                ? 420.5
                : (animationState.animate ? 100.0 : 380.0),
            left: 0,
            right: 0,
            bottom: 0,
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
                          _buildCalendar(),
                          const SizedBox(height: 20.0),
                          _buildAttendanceTitle(),
                          const SizedBox(height: 10.0),
                          _buildAttendanceList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AppBar and Toggle Button with fading effect
          _buildFadingAppBar(context),
        ],
      ),
    );
  }

  Widget _buildFadingAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            16.0, 14.0, 16.0, 0.0), // Adjust top padding to 30.0
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
                    onPressed: () {
                      setState(() {
                        animationState.isBackNavigation =
                            true; // Trigger fade out
                      });
                      Future.delayed(const Duration(milliseconds: 800), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: animationState.isBackNavigation
                        ? 0.0
                        : (animationState.animate ? 1.0 : 0.0),
                    child: _buildAttendanceButton(),
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

  Widget _buildAttendanceButton() {
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

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2123, 12, 31),
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _onMonthChanged(focusedDay);
      },
    );
  }

  Widget _buildAttendanceTitle() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0), // Adjusted padding for space
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Attendance",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildDropdownFilter(),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter() {
    return DropdownButton<String>(
      value: _selectedFilter,
      items: [
        _buildDropdownItem('All', Colors.white, Colors.grey),
        _buildDropdownItem('Absent', Colors.red, Colors.transparent),
        _buildDropdownItem('Late', Colors.orange, Colors.transparent),
        _buildDropdownItem('Holiday', Colors.green, Colors.transparent),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedFilter = newValue!;
        });
      },
      underline: SizedBox(), // Removes the default underline
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(
      String label, Color color, Color borderColor) {
    return DropdownMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Container(
            width: 20, // Increased width
            height: 20, // Increased height
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

  Widget _buildAttendanceList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _daysInMonth.length,
        itemBuilder: (context, index) {
          DateTime date = _daysInMonth[index];
          String day = DateFormat('dd').format(date);
          String shortMonth =
              DateFormat('MMM').format(date); // Shortened month name
          String weekday = DateFormat('EEEE').format(date); // Full weekday name

          // Example attendance data: holidays on weekends
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
                          ), // Display shortened month name below the date
                        ),
                      ],
                    ),
                    const SizedBox(width: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:
                              30.0), // Add left padding for status and weekday
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
                            ), // Display day of the week below status
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 60.0), // Trim the divider by 40 pixels
                child: Divider(), // Line to separate each day
              ),
            ],
          );
        },
      ),
    );
  }
}
