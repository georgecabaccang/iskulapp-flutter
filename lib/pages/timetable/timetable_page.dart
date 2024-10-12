import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/timetable/widget/timetable_tabbar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/timetable/widget/timetable_card.dart';
import 'package:school_erp/theme/colors.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? timetableData; // To hold the loaded timetable data

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadTimetable(); // Load the timetable data
  }

  Future<void> _loadTimetable() async {
    // Load JSON data from assets
    final String response =
        await rootBundle.loadString('assets/timetable.json');
    setState(() {
      timetableData = json.decode(response); // Decode JSON
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const CustomAppBar(title: 'Add Assignment'),
          AppContent(content: [
            const SizedBox(height: 24,),
            TimeTableTabBar(controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  timetableData != null
                      ? TimetableCard(
                          day: "Monday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Monday']))
                      : const Center(child: CircularProgressIndicator()),
                  // Loading indicator
                  timetableData != null
                      ? TimetableCard(
                          day: "Tuesday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Tuesday']))
                      : const Center(child: CircularProgressIndicator()),
                  timetableData != null
                      ? TimetableCard(
                          day: "Wednesday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Wednesday']))
                      : const Center(child: CircularProgressIndicator()),
                  timetableData != null
                      ? TimetableCard(
                          day: "Thursday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Thursday']))
                      : const Center(child: CircularProgressIndicator()),
                  timetableData != null
                      ? TimetableCard(
                          day: "Friday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Friday']))
                      : const Center(child: CircularProgressIndicator()),
                  timetableData != null
                      ? TimetableCard(
                          day: "Saturday",
                          subjects: List<Map<String, dynamic>>.from(
                              timetableData!['timetable']['Saturday']))
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
