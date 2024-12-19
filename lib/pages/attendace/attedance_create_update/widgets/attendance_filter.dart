import 'package:flutter/material.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/widgets/filter/date_selector.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/widgets/filter/section_filter.dart';

class AttendanceFilter extends StatelessWidget {
  final Section? selectedSection;
  final List<Section> sectionList;
  final DateTime selectedDate;
  final ValueChanged<Section?> onSectionSelected;
  final ValueChanged<DateTime?> onDateSelected;

  const AttendanceFilter({
    required this.selectedSection,
    required this.sectionList,
    required this.selectedDate,
    required this.onSectionSelected,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final boxWidth = sw * 0.10;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SectionFilter(
            selectedSection: selectedSection,
            sectionList: sectionList,
            onSectionSelected: onSectionSelected,
          ),
        ),
        SizedBox(width: boxWidth),
        Expanded(
          flex: 1,
          child: DateSelector(
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
          ),
        ),
      ],
    );
  }
}
