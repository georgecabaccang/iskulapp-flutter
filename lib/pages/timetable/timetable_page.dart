import 'package:flutter/material.dart';
import 'package:school_erp/pages/timetable/widget/timetable_tabbar.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';
import 'package:school_erp/pages/timetable/widget/timetable_card.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> with TickerProviderStateMixin {
  late AssignmentAnimationManager animationManager;
  late TabController _tabController;
  Map<String, dynamic>? timetableData; // To hold the loaded timetable data

  @override
  void initState() {
    super.initState();
    animationManager = AssignmentAnimationManager(vsync: this);
    _tabController = TabController(length: 6, vsync: this);
    _startAnimation();
    _loadTimetable(); // Load the timetable data
  }

  void _startAnimation() {
    animationManager.startAnimation();
  }

  void _handleBackPress() {
    animationManager.reverseAnimation();
    Future.delayed(animationManager.duration, () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  Future<void> _loadTimetable() async {
    // Load JSON data from assets
    final String response = await rootBundle.loadString('assets/timetable.json');
    setState(() {
      timetableData = json.decode(response); // Decode JSON
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.primaryColor),
          AnimatedBuilder(
            animation: animationManager.controller,
            builder: (context, child) {
              return Positioned(
                top: animationManager.topPosition,
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
                  child: FadeTransition(
                    opacity: animationManager.fadeAnimation,
                    child: child ?? Container(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 25),
                TimeTableTabBar(controller: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      timetableData != null
                          ? TimetableCard(
                              day: "Monday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Monday']))
                          : const Center(child: CircularProgressIndicator()), // Loading indicator
                      timetableData != null
                          ? TimetableCard(
                              day: "Tuesday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Tuesday']))
                          : const Center(child: CircularProgressIndicator()),
                      timetableData != null
                          ? TimetableCard(
                              day: "Wednesday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Wednesday']))
                          : const Center(child: CircularProgressIndicator()),
                      timetableData != null
                          ? TimetableCard(
                              day: "Thursday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Thursday']))
                          : const Center(child: CircularProgressIndicator()),
                      timetableData != null
                          ? TimetableCard(
                              day: "Friday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Friday']))
                          : const Center(child: CircularProgressIndicator()),
                      timetableData != null
                          ? TimetableCard(
                              day: "Saturday",
                              subjects: List<Map<String, dynamic>>.from(timetableData!['timetable']['Saturday']))
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
