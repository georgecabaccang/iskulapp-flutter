import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/string_values.dart';
import 'package:school_erp/theme/colors.dart';

class TimeTableTabBar<T extends StringValues> extends StatefulWidget {
    final TabController controller;
    final List<T> tabs;

    const TimeTableTabBar({super.key, required this.controller, required this.tabs});

    @override
    createState() => _TimeTableTabBarState();
}

class _TimeTableTabBarState extends State<TimeTableTabBar> {
    @override
    Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;

        final double responsiveTabWidth = screenWidth / 7;

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabBar(
                controller: widget.controller,
                unselectedLabelStyle: const TextStyle(color: Colors.grey),
                labelStyle:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                indicator: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(widget.tabs.length, (index) {
                        bool isSelected = widget.controller.index == index;
                        return Tab(
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isSelected ? responsiveTabWidth + 10 : responsiveTabWidth,
                                height: isSelected ? 50.0 : 40.0,
                                alignment: Alignment.center,
                                child: Text(
                                    widget.tabs[index].shortened
                                ),
                            ),
                        );
                    }),
            ),
        );
    }
}
