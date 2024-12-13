import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/theme/colors.dart';

// Implment DisplayValues to the enum that is going to be used with this widget.
class CustomTabBar<T extends DisplayValues> extends StatefulWidget {
    final TabController controller;
    final List<T> tabs;

    const CustomTabBar({super.key, required this.controller, required this.tabs});

    @override
    createState() => _CustomTabBar();
}

class _CustomTabBar extends State<CustomTabBar> {
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
                                    widget.tabs[index].displayName
                                ),
                            ),
                        );
                    }),
            ),
        );
    }
}
