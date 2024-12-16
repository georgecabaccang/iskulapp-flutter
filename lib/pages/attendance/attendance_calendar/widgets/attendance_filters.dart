import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';

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
    List<String> sections = [];
    late List<String> names = [];

    String? _sectionSelected;
    String? _nameSelected;

    @override
    void initState() {
        super.initState();
        sections =  ["Atis", "Banana", "Guava"];
        _sectionSelected = "Atis";
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
                        case "Atis": 
                            names = ["Test", "Ing", "Lang", "For", "Atis"];
                            break;
                        case "Banana":
                            names = ["Banana", "Naman", "Ini"];
                            break;
                        case "Guava":
                            names = ["Para", "Sa", "Guava"];
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
                options: sections, 
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