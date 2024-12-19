import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<MockStudent> changeStudentFilter;
    final void Function() changeSectionFilter;

    final List<MockStudent> students;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changeStudentFilter, 
        required this.changeSectionFilter, 
        required this.students
    });

    @override
    createState() => _AttendanceFiltersState();
}

class _AttendanceFiltersState extends State<AttendanceFilters> {
    List<MockSection> sections = [];
    late List<MockStudent> studentsOfSection = [];
    bool _isLoading = true;

    MockStudent? _studentSelected;

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

    void _handleChangeSection(DisplayValues? newSection) {
        if (widget.role != Roles.teacher) return;

        if (newSection is MockSection) {
            setState(() {
                    _studentSelected = null;
                    widget.changeSectionFilter();

                    MockSection currentSection = sections.firstWhere((section) => section.id == newSection.id);
                    studentsOfSection = widget.students.where((student) => student.sectionId == currentSection.id).toList();
                }
            );
        }
    }

    void _handleChangeStudent(DisplayValues? student) {
        if (student is MockStudent) {
            setState(() => _studentSelected = student);
            if (_studentSelected != null) widget.changeStudentFilter(_studentSelected!);
        }
    }

    void _handleChangeRole(DisplayValues? student) {
        if (student is MockStudent) {
            setState(() => _studentSelected = student);
            if (_studentSelected != null) widget.changeStudentFilter(_studentSelected!);
        }
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
                onChangedFn: _handleChangeSection,
            ),
            FormDropDownList(
                selectedValue: _studentSelected,
                options: studentsOfSection,
                label: "Name", 
                hint: "Select a name...", 
                errorMessage: "Please select a name.", 
                onChangedFn: _handleChangeStudent,
            ),

        ];

        return DropDownForm(dropDowns: dropDowns);

    }


}