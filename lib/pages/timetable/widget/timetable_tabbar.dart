import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TimeTableTabBar extends StatelessWidget {
  final TabController controller;

  const TimeTableTabBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      controller: controller,
      backgroundColor: Colors.blueAccent,
      unselectedBackgroundColor: Colors.grey[300],
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      radius: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      tabs: const [
        Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Mon"),
        ),),
       Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Tues"),
        ),),
        Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Wed"),
        ),),
        Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Thurs"),
        ),),
        Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Fri"),
        ),),
        Tab(child: Padding(
          padding: EdgeInsets.only(left: 8.0,right: 8.0),
          child: Text("Sat"),
        ),),
      ],
    );
  }
}
