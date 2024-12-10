import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/timetable/helpers/timetable.dart';
import 'package:school_erp/pages/timetable/widget/timetable_tabbar.dart';
import 'package:school_erp/theme/colors.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/timetable/widget/timetable_card.dart';

class TimeTablePage extends StatefulWidget {
    const TimeTablePage({super.key});

    @override
    createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> with TickerProviderStateMixin {
    late TabController _tabController;
    late Timetable? timeTable;
    bool _isLoading = true;

    @override
    void initState() {
        super.initState();
        _tabController = TabController(length: 6, vsync: this);
        _loadTimetable();
    }

    Future<void> _loadTimetable() async {
        try {
            if (!mounted) return;

            setState(() {
                    _isLoading = true;
                });

            final String response = await rootBundle.loadString('assets/timetable.json');
            if (response.isNotEmpty) {
                setState(() {
                        _isLoading = false;
                        timeTable = Timetable.fromJson(json.decode(response));
                    }
                );
            }

            setState(() {
                    _isLoading = false;
                }
            );

        } 
        // Handler errors better when real data is being retrieved
        catch (e) {
            if (!mounted) return;
            setState(() {
                    _isLoading = false;
                }
            );
        }

    }

    @override
    void dispose() {
        _tabController.dispose();
        super.dispose();
    }

    Widget _buildTabContent(DaysOfTheWeek day) {
        if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
        }
        final classes = List<ClassDetails>.from(timeTable?.data[day] ?? []);
        return TimetableCard( classes: classes);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Column(
                children: [
                    const CustomAppBar(title: 'Timetable'),
                    AppContent(
                        content: [
                            const SizedBox(height: 25),
                            TimeTableTabBar(controller: _tabController),
                            Expanded(
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                        ...[for (var day in DaysOfTheWeek.values) _buildTabContent(day)]                                                                                                                
                                    ],
                                ),
                            ),
                        ],
                    ),
                ],
            ),
        );
    }
}
