import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_attendance_animation.dart';
import 'widgets/attendance_title.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/theme/colors.dart';

class AnimationState {
  final bool animate;
  final bool isBackNavigation;

  AnimationState({
    this.animate = false,
    this.isBackNavigation = false,
  });
}

class CalendarAttendancePage extends StatefulWidget {
  final DateTime focusDate;

  const CalendarAttendancePage({super.key, required this.focusDate});

  @override
  _CalendarAttendancePageState createState() => _CalendarAttendancePageState();
}

class _CalendarAttendancePageState extends State<CalendarAttendancePage>
    with SingleTickerProviderStateMixin {
  late CalendarAnimationManager animationManager;
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late List<DateTime> _daysInMonth;
  final PageStorageBucket _bucket = PageStorageBucket();
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    animationManager = CalendarAnimationManager(vsync: this);
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = widget.focusDate;
    _daysInMonth = _getDaysInMonth(_focusedDay);
    _startAnimation();
  }

  void _startAnimation() {
    animationManager.startAnimation();
  }

  void _onMonthChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _daysInMonth = _getDaysInMonth(focusedDay);
    });
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
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

  void _handleBackPress() {
    animationManager.reverseAnimation();
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationManager.controller,
        builder: (context, child) {
          return Stack(
            children: [
              Container(color:AppColors.primaryColor),
              Positioned(
                top: animationManager.topPosition,
                left: 0,
                right: 0,
                bottom: 0,
                child: child ?? Container(),
              ),
              CalendarAppBar(
                animationManager: animationManager,
                onBackPressed: _handleBackPress,
              )
            ],
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: CalendarContent(
                  animationManager: animationManager,
                  bucket: _bucket,
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  calendarFormat: _calendarFormat,
                  selectedFilter: _selectedFilter,
                  daysInMonth: _daysInMonth,
                  onDaySelected: _handleDaySelected,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: _onMonthChanged,
                  onFilterChanged: (newValue) {
                    setState(() {
                      _selectedFilter = newValue ?? 'All';
                    });
                  },
                  onBackPressed: _handleBackPress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationManager.dispose();
    super.dispose();
  }
}

class CalendarContent extends StatelessWidget {
  final CalendarAnimationManager animationManager;
  final PageStorageBucket bucket;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final String selectedFilter;
  final List<DateTime> daysInMonth;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final Function(String?) onFilterChanged;
  final VoidCallback onBackPressed;

  const CalendarContent({
    super.key,
    required this.animationManager,
    required this.bucket,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.selectedFilter,
    required this.daysInMonth,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.onFilterChanged,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucket,
      key: const PageStorageKey<String>('calendarAttendancePage'),
      child: AnimatedBuilder(
        animation: animationManager.controller,
        builder: (context, child) {
          return Opacity(
            opacity: animationManager.opacity,
            child: child,
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                // Ensuring the white box is visible and remains at full opacity
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    // All widgets inside this column will share the same opacity
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
                          const AttendanceTitle(),
                          DropdownFilter(
                            selectedFilter: selectedFilter,
                            onChanged: onFilterChanged,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AttendanceList(daysInMonth: daysInMonth),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarAppBar extends StatelessWidget {
  final CalendarAnimationManager animationManager;
  final VoidCallback onBackPressed;

  const CalendarAppBar({
    super.key,
    required this.animationManager,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        child: AnimatedBuilder(
          animation: animationManager.controller,
          builder: (context, child) {
            return Opacity(
              opacity: animationManager.opacity,
              child: child,
            );
          },
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                onPressed: onBackPressed,
              ),
              const Spacer(),
              const AttendanceButton(),
              const Spacer(flex: 2),
            ],
          ),
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
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
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
      items: const [
        DropdownMenuItem(
          value: 'All',
          child: FilterItem(
            label: 'All',
            color: AppColors.whiteColor,
            borderColor: Colors.grey,
          ),
        ),
        DropdownMenuItem(
          value: 'Absent',
          child: FilterItem(label: 'Absent', color:AppColors.dangerColor),
        ),
        DropdownMenuItem(
          value: 'Late',
          child: FilterItem(label: 'Late', color: AppColors.warningColor),
        ),
        DropdownMenuItem(
          value: 'Holiday',
          child: FilterItem(label: 'Holiday', color: AppColors.successColor),
        ),
      ],
      onChanged: onChanged,
      underline: const SizedBox(),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String label;
  final Color color;
  final Color borderColor;

  const FilterItem({
    super.key,
    required this.label,
    required this.color,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        color: AppColors.whiteColor,
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
