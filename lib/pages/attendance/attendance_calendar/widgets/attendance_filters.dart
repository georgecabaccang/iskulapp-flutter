import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_list.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/dropdowns/form_drop_down_list.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/calendar_range_picker/custom_range_picker.dart';
import 'package:school_erp/pages/common_widgets/forms/drop_down_form/drop_down_form.dart';

class AttendanceFilters extends StatefulWidget{
    final Roles role;
    final ValueChanged<Student?> changeStudentFilter;
    final void Function(Section) changeSectionFilter;
    final void Function(FilterByType) changeFilterBy;
    final void Function(DateTimeRange) changeDateRange;

    final List<Section> sections;
    final List<Student> students;
    final List<FilterByType> filters;
    final List<Attendance> attendance;
    final List<Attendance> attendanceOfRange;
    final Map<String, bool> isLoading;

    const AttendanceFilters({
        super.key, 
        required this.role, 
        required this.changeStudentFilter, 
        required this.changeSectionFilter, 
        required this.changeFilterBy, 
        required this.changeDateRange, 
        required this.sections,
        required this.students,
        required this.filters, 
        required this.attendance, 
        required this.attendanceOfRange,
        required this.isLoading
    });

    @override
    createState() => _AttendanceFiltersState();
}

class _AttendanceFiltersState extends State<AttendanceFilters> {
    List<Section> sections = [];

    Student? _studentSelected;
    FilterByType? _filterSelected;
    Section? _currentSection;

    String? dateRangeDisplay;
    int dateDifference = 0;

    @override
    void initState() {
        super.initState();
    }

    void _handleChangeSection(Section? newSection) {
        if (widget.role != Roles.teacher) return;
        if (_currentSection == newSection) return;

        setState(() {
                _currentSection = newSection;

                // Reset all values here to avoid exceptions.
                _studentSelected = null;
                _filterSelected = null;
                dateRangeDisplay = null;
                dateDifference = 0;
                widget.changeSectionFilter(newSection!);
            }
        );

    }

    void _handleChangeStudent(Student? person) {
        // widget.changeStudentFilter() here is responsible for changing the display
        // on the calendar depending on the data.
        setState(() => _studentSelected = person);
        widget.changeStudentFilter(_studentSelected);
    }

    void _handleChangeFilterBy(FilterByType? filter) {
        setState(() {
                // Reset _studentSelected and _teacherSelected here to avoid exceptions.
                _filterSelected = filter;
                _studentSelected = null;
            });

        // This is to hide main calendar if FilterByType.date is selected.
        widget.changeFilterBy(_filterSelected!);
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

        // This can be optimized futher, but will have to
        // separate these dropdowns in to its own statefulwidgets,
        // but for now, this is fine. Just something to think about.
        final List<FormDropDownList> dropDowns = [
            FormDropDownList<Section>(
                selectedValue: _currentSection,
                options: widget.sections, 
                label: "Section", 
                hint: "Select a section...", 
                errorMessage: "Please select a section.", 
                onChangedFn: _handleChangeSection,
                isLoading: widget.isLoading["isSectionsLoading"]!
                ,
            ),
            if (_currentSection != null)
            FormDropDownList<FilterByType>(
                selectedValue: _filterSelected,
                options: widget.filters, 
                label: "Filter by", 
                hint: "Select a filter...", 
                errorMessage: "Please select a filter.", 
                onChangedFn: _handleChangeFilterBy,
                isLoading: widget.isLoading["isStudentsLoading"]!
            ),
            // Hide if filter chosen is by date
            if (_filterSelected == FilterByType.student) 
            FormDropDownList<Student>(
                selectedValue: _studentSelected,
                options: widget.students,
                label: "Name", 
                hint: "Select a name...", 
                errorMessage: "Please select a name.", 
                onChangedFn: _handleChangeStudent,
                isLoading: widget.isLoading["isStudentsLoading"]!
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
                            attendance: widget.attendanceOfRange, 
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