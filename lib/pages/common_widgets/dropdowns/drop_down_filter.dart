import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_base_enum.dart';

class DropdownFilter<T extends BaseEnum> extends StatelessWidget {
    final String selectedFilter;
    final ValueChanged<String?> onChanged;
    final List<T> filterOptions;
    final bool hasMarker;

    const DropdownFilter({
        super.key,
        required this.selectedFilter,
        required this.onChanged, 
        required this.filterOptions, 
        required this.hasMarker,
    });

    @override
    Widget build(BuildContext context) {
        return DropdownButton<String>(
            value: selectedFilter,
            items: filterOptions.map((filter) => _buildDropdownItem(filter)).toList(),
            onChanged: onChanged,
            underline: const SizedBox(),
            menuMaxHeight: 500,
        );
    }

    DropdownMenuItem<String> _buildDropdownItem(
        BaseEnum filter) {
        return DropdownMenuItem<String>(
            value: filter.label,
            child: Row(
                children: [
                    hasMarker
                        ? Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: filter.color,
                                border: Border.all(color: filter.borderColor),
                            ),
                        )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 8),
                    Text(filter.label),
                ],
            ),
        );
    }
}