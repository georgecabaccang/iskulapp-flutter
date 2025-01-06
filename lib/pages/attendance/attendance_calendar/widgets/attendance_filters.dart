import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_roles.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/attendance_details.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_list.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_services.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/calendar_range_picker/custom_range_picker.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<EntityDisplayData?> changePersonFilter;
    final void Function(MockSection) changeSectionFilter;
    final void Function(FilterByType) changeFilterBy;
    final void Function(DateTimeRange) changeDateRange;

    final List<MockStudent> students;
    final List<EntityDisplayData> filters;
    final List<AttendanceDetails> attendance;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changePersonFilter, 
        required this.changeSectionFilter, 
        required this.changeFilterBy, 
        required this.changeDateRange, 
        required this.students,
        required this.filters, 
        required this.attendance
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
    FilterByType? _filterSelected;
    MockSection? _currentSection;

    String? dateRangeDisplay;
    int dateDifference = 0;

    final AttendanceCalendarServices _attendanceService = AttendanceCalendarServices();

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

    void _handleChangeSection(EntityDisplayData? newSection) {
        if (widget.role != Roles.teacher) return;
        if (_currentSection == newSection) return;

        if (newSection is MockSection) {
            setState(() {
                    _currentSection = newSection;

                    // Reset all values here to avoid exceptions.
                    _studentSelected = null;
                    _filterSelected = null;
                    dateRangeDisplay = null;
                    dateDifference = 0;
                    widget.changeSectionFilter(newSection);
                }
            );
        }
    }

    void _handleChangePerson(EntityDisplayData? person) {
        // These setStates here are needed here to rebuild the 'Name' dropdown list
        // and display update data based on selected person.

        // widget.changePersonFilter() here is responsible for changing the display
        // on the calendar depending on the data.

        if (person is MockStudent) {
            setState(() => _studentSelected = person);
            widget.changePersonFilter(_studentSelected);
        }
    }

    void _handleChangeFilterBy(EntityDisplayData? filter) {
        if (filter is FilterByType) {
            setState(() {
                    // Reset _studentSelected and _teacherSelected here to avoid exceptions.
                    _filterSelected = filter;
                    _studentSelected = null;
                });

            // This is to hide main calendar if FilterByType.date is selected.
            widget.changeFilterBy(_filterSelected!);
        }
    }

    void _handleDateRange() async {
        DateTimeRange? dateRange = await CustomRangePicker.showPicker(context);
        if (dateRange != null) {
            String startDate = AttendanceCalendarUtils.dateToStringConverter(dateRange.start);
            String endDate = AttendanceCalendarUtils.dateToStringConverter(dateRange.end);

            widget.changeDateRange(dateRange);
            dateDifference = dateRange.end.difference(dateRange.start).inDays;

            setState(() {
                    dateRangeDisplay = '$startDate - $endDate';
                });
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
                selectedValue: _currentSection,
                options: sections, 
                label: "Section", 
                hint: "Select a section...", 
                errorMessage: "Please select a section.", 
                onChangedFn: _handleChangeSection,
            ),
            FormDropDownList(
                selectedValue: _filterSelected,
                options: widget.filters, 
                label: "Filter by", 
                hint: "Select a filter...", 
                errorMessage: "Please select a filter.", 
                onChangedFn: _handleChangeFilterBy,
            ),
            // Hide if filter chosen is by date
            if (_filterSelected == FilterByType.student) 
            FormDropDownList(
                selectedValue: _studentSelected,
                options: widget.students,
                label: "Name", 
                hint: "Select a name...", 
                errorMessage: "Please select a name.", 
                onChangedFn: _handleChangePerson,
            ),
        ];

        return Expanded(
            child: Column(
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [DropDownForm(dropDowns: dropDowns)]
                    ),
                    if (dateDifference != 0 && _filterSelected == FilterByType.date) 
                    Expanded(
                        child: AttendanceList(
                            students: widget.students,
                            attendance: widget.attendance, 
                            range: dateDifference
                        ),
                    ),
                    if (dateRangeDisplay != null && _filterSelected == FilterByType.date)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(dateRangeDisplay!)] 
                    ),
                    if (_filterSelected == FilterByType.date)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [FormButton(
                                buttonLabel: "Choose range",
                                buttonType: ButtonType.button,
                                buttonFn: () => _handleDateRange(),
                            )]
                    ),
                ],
            ),
        );
    }
}