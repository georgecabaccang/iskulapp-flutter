import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  @override
  void initState() {
    super.initState();
    animationState = AnimationState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = widget.focusDate;
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animationState.animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue background color
          Container(
            color: Color(0xFF5278C1),
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
                      child: _buildCalendar(),
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
                    child: _buildToggleButton(),
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

  Widget _buildToggleButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF96B1E5),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCapsuleButton(
              "ATTENDANCE", animationState.isAttendanceSelected),
          _buildCapsuleButton("HOLIDAY", !animationState.isAttendanceSelected),
        ],
      ),
    );
  }

  Widget _buildCapsuleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          animationState.isAttendanceSelected = (text == "ATTENDANCE");
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold, // Make text bold
          ),
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
    );
  }
}
