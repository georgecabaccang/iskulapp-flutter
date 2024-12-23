import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_roles.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<MockStudent?> changeStudentFilter;
    final void Function() changeSectionFilter;

    final List<MockStudent> students;
    final List<MockTeacher> teachers;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changeStudentFilter, 
        required this.changeSectionFilter, 
        required this.students,
        required this.teachers
    });

    @override
    createState() => _AttendanceFiltersState();
}

class _AttendanceFiltersState extends State<AttendanceFilters> {
    List<MockSection> sections = [];
    List<MockRole> roles = [];
    late List<MockTeacher> teachersOfSection = [];
    late List<MockStudent> studentsOfSection = [];
    // Remove this "ignore" later when _isLoading is used.
    // This is just to supress the warning for now.
    // ignore: unused_field
    bool _isLoading = true;

    MockStudent? _studentSelected;
    MockRole? _roleSelected;

    @override
    void initState() {
        super.initState();

        if (widget.role == Roles.teacher) {_loadSectionsAndRoles();}
    }

    Future<void> _loadSectionsAndRoles() async{
        try {
            if (!mounted) return;

            setState(() => _isLoading = true);

            final String responseSections = await rootBundle.loadString('assets/mocks/attendance_mocks/sections.json');
            final String responseRoles = await rootBundle.loadString('assets/mocks/attendance_mocks/roles.json');

            if (responseSections.isNotEmpty) {
                setState(() {
                        sections = MockSections.fromJson(json.decode(responseSections)).mockSections;
                    }
                );
            }

            if (responseRoles.isNotEmpty) {
                setState(() {
                        roles = MockRoles.fromJson(json.decode(responseRoles)).mockRoles;
                    }
                );
            }
        } 
        // Handler errors better when real data is being retrieved
        catch (error) {
            if (!mounted) return;
            print(error);
        }
        finally {
            setState(() => _isLoading = false);
        }
    }

    void _handleChangeSection(DisplayValues? newSection) {
        if (widget.role != Roles.teacher) return;

        if (newSection is MockSection) {
            setState(() {
                    _studentSelected = null;
                    _roleSelected = null;
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

    void _handleChangeFilterBy(DisplayValues? role) {
        if (role is MockRole) {
            setState(() {
                    _roleSelected = role;
                    _studentSelected = null;
                });
            if (_roleSelected != null) widget.changeStudentFilter(_studentSelected);
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
                selectedValue: _roleSelected,
                options: roles, 
                label: "Filter by", 
                hint: "Select a role...", 
                errorMessage: "Please select a role.", 
                onChangedFn: _handleChangeFilterBy,
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