import 'package:flutter/material.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<String> changeFilter;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changeFilter
    });

    @override
    createState() => _AttendanceFiltersState();
}

class _AttendanceFiltersState extends State<AttendanceFilters> {
    List<MockSection> sections = [];
    late List<String> names = [];
    bool _isLoading = true;

    String? _sectionSelected;
    String? _nameSelected;

    @override
    void initState() {
        super.initState();

        _loadSections();
    }

    Future<void> _loadSections() async{
        try {
            if (!mounted) return;

            setState(() => _isLoading = true);

            final String response = await rootBundle.loadString('assets/mocks/attendance_mocks/sections.json');
            if (response.isNotEmpty) {
                setState(() {
                        sections = MockSections.fromJson(json.decode(response)).mockSections;
                    }
                );
            }

            setState(() => _isLoading = false);

        } 
        // Handler errors better when real data is being retrieved
        catch (error) {
            if (!mounted) return;
            setState(() => _isLoading = false);
        }
    }

    void _handleChangeSection(String? section) {
        if (widget.role != Roles.teacher) return;

        setState(() {
                _sectionSelected = section;
                _nameSelected = null;

                // Use proper request for list of names here 
                // For now, testing lang muna.
                if (_sectionSelected != null) {
                    switch (_sectionSelected) {
                        case "Apple": 
                            names = ["Test", "Ing", "Lang", "For", "Apple"];
                            break;
                        case "Banana":
                            names = ["Banana", "Naman", "Ini"];
                            break;
                        case "Cherry":
                            names = ["Para", "Sa", "Cherry"];
                            break;
                    }

                }
            }
        );
    }

    void handleChangName(String? name) {
        setState(() => _nameSelected = name);
        if (_nameSelected != null) widget.changeFilter(_nameSelected!);
    }

    @override
    Widget build(Object context) {
        if (widget.role != Roles.teacher) {
            return SizedBox.shrink();
        }

        final List<FormDropDownList> dropDowns = [
            FormDropDownList(
                selectedValue: null,
                options: sections.map((section) => section.name).toList(), 
                label: "Section", 
                hint: "Select a section...", 
                errorMessage: "Please select a section.", 
                onChangedFn: (value) => _handleChangeSection(value),
            ),
            FormDropDownList(
                selectedValue: _nameSelected,
                options: names, 
                label: "Name", 
                hint: "Select a name...", 
                errorMessage: "Please select a name.", 
                onChangedFn: (value) => handleChangName(value)
            ),

        ];

        return DropDownForm(dropDowns: dropDowns);

    }


}