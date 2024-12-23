import 'package:flutter/material.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_roles.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attedance_calendar_services.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<DisplayValues?> changePersonFilter;
    final void Function() changeSectionFilter;

    final List<MockStudent> students;
    final List<MockTeacher> teachers;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changePersonFilter, 
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
    bool _isLoading = true;

    MockStudent? _studentSelected;
    MockTeacher? _teacherSelected;
    MockRole? _roleSelected;

    final AttedanceCalendarServices _attendanceService = AttedanceCalendarServices();

    @override
    void initState() {
        super.initState();

        if (widget.role == Roles.teacher) {_loadSectionsAndRoles();}
    }

    Future<void> _loadSectionsAndRoles() async {
        try {
            setState(() => _isLoading = true);

            final data = await _attendanceService.loadSectionsAndRoles();

            setState(() {
                    sections = data['sections'] ?? [];
                    roles = data['roles'] ?? [];
                });
        } 
        // Properly handle errors in the future.
        catch (error) {
            if (!mounted) return;
            print(error);
        } finally {
            setState(() => _isLoading = false);
        }
    }

    void _handleChangeSection(DisplayValues? newSection) {
        if (widget.role != Roles.teacher) return;

        if (newSection is MockSection) {
            setState(() {
                    // Reset all values here to avoid exceptions.
                    _studentSelected = null;
                    _teacherSelected = null;
                    _roleSelected = null;
                    widget.changeSectionFilter();

                    // Get students and teachers per section on change of section
                    MockSection currentSection = sections.firstWhere((section) => section.id == newSection.id);
                    studentsOfSection = widget.students.where((student) => student.sectionId == currentSection.id).toList();
                    teachersOfSection = widget.teachers.where((teacher) => teacher.sectionId == currentSection.id).toList();
                }
            );
        }
    }

    void _handleChangePerson(DisplayValues? person) {
        // These setStates here are needed here to rebuild the 'Name' dropdown list
        // and display update data based on selected person.

        // widget.changePersonFilter() here is responsible for changing the display
        // on the calendar depending on the data.

        if (person is MockStudent) {
            setState(() => _studentSelected = person);
            widget.changePersonFilter(_studentSelected);
        }

        if (person is MockTeacher) {
            setState(() => _teacherSelected = person);
            widget.changePersonFilter(_teacherSelected);
        }
    }

    void _handleChangeFilterBy(DisplayValues? role) {
        if (role is MockRole) {
            setState(() {
                    // Reset _studentSelected and _teacherSelected here to avoid exceptions.
                    _roleSelected = role;
                    _studentSelected = null;
                    _teacherSelected = null;
                });

            // This is to remove decorations and details of attendance status on the calendar.
            widget.changePersonFilter(null);
        }
    }

    @override
    Widget build(Object context) {
        if (widget.role != Roles.teacher) return SizedBox.shrink();

        if (_isLoading) return Center(child: CircularProgressIndicator());

        // This can be optimized futher, but will have to
        // separate these dropdowns in to its own statefulwidgets,
        // but for now, this is fine. Just something to think about.
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
                selectedValue: _roleSelected?.role == "teacher" ? _teacherSelected : _studentSelected,
                options: AttendanceCalendarUtils.peopleOptions(_roleSelected, studentsOfSection, teachersOfSection),
                label: "Name", 
                hint: "Select a name...", 
                errorMessage: "Please select a name.", 
                onChangedFn: _handleChangePerson,
            ),

        ];

        return DropDownForm(dropDowns: dropDowns);
    }
}