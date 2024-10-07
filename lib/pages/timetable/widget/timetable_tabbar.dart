import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:school_erp/theme/colors.dart';

class TimeTableTabBar extends StatelessWidget {
  final TabController controller;

  const TimeTableTabBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      controller: controller,
      radius: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      unselectedBackgroundColor: Colors.transparent,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      backgroundColor: Colors.transparent,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      tabs: const [
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("MON"),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("TUE"),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("WED"),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("THU"),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("FRI"),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text("SAT"),
          ),
        ),
      ],
    );
  }
}
