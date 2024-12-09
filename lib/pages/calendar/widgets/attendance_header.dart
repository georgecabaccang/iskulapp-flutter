import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_base_enum.dart';
import 'package:school_erp/pages/calendar/enums/attendance_filter_enum.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/drop_down_filter.dart';

class AttendanceHeader<T extends BaseEnum> extends StatelessWidget{
    final String selectedFilter;
    final ValueChanged<String?> onChanged;

    const AttendanceHeader({super.key, required this.selectedFilter, required this.onChanged});

    @override
    Widget build(BuildContext context) {
        return   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                        'Attendance',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                        ),
                    ),
                    DropdownFilter(
                        hasMarker: true,
                        selectedFilter: selectedFilter,
                        onChanged: onChanged,
                        filterOptions: AttendanceFilterEnum.values,
                    ),
                ],
            ),
        );
    }
}