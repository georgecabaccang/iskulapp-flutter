import 'package:flutter/material.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/schemas.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_calendar.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/attendance_filters.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/widgets/helpers/attendance_calendar_utils.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/repositories/attendance_repository.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';
import 'package:school_erp/theme/colors.dart';

// For testing only. 
// Remove and replace with proper thing after.
enum Roles {student, teacher, parent}

class AttendanceCalendarPage extends StatefulWidget{

    const AttendanceCalendarPage({super.key});

    @override
    createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
    late DateTime _firstDay;
    late DateTime _lastDay;
    late DateTime _focusedDay;

    SectionRepository sectionRepository = SectionRepository();
    StudentRepository studentRepository = StudentRepository();
    AttendanceRepository attendanceRepository = AttendanceRepository();

    List<Section> sectionsOfTeacher = [];
    List<Student> students = [];
    List<Attendance> attendanceStudent = [];

    Section? currentSection;
    List<Attendance> attendanceOfDateRange = [];

    // Converted List<Attendance> to map for ease of access of data.
    Map<DateTime, Attendance> attendanceDetails = {};

    FilterByType? filterBy;
    List<FilterByType> filters = FilterByType.values;

    final Map<String, bool> _loadingStates = {
        "isSectionsLoading": false,
        "isStudentsLoading": false,
    };

    @override
    void initState() {
        super.initState();
        _firstDay = DateTime.utc(2000, 1, 1); 
        _lastDay = DateTime.now(); 
        _focusedDay = DateTime.now(); 

        _getSectionsOfTeacher();

    }

    void _getSectionsOfTeacher() async {
        try {
            setState(() => _loadingStates["isSectionsLoading"] = true);

            String teacherId = getTeacherId(context);
            AuthenticatedUser authUser = getAuthUser(context);

            List<Section> responseSections = await sectionRepository.getTeacherSectionsAll(teacherId: teacherId, academicYearId: authUser.academicYearId);

            if (responseSections.isEmpty) throw Exception("Teacher has no sections handled.");

            setState(() => sectionsOfTeacher = responseSections);
        } 
        // Handle better in the future.
        catch (error) {
            print(error);
        } finally {
            setState(() => _loadingStates["isSectionsLoading"] = false);
        }
    }

    void _onChangeFocusedDate(DateTime selectedDay, DateTime focusedDay) {
        setState(() {
                _focusedDay = focusedDay;
            }
        );
    }

    void _onChangeSection(Section newSection) async {
        try {
            setState(() => _loadingStates["isStudentsLoading"] = true);

            List<Student> studentsOfSection = await studentRepository.getStudentsBySection(newSection.id);
            List<Attendance> attendanceOfStudents = await  attendanceRepository.getStudentsAttendanceBySection(sectionId: newSection.id);

            if (studentsOfSection.isEmpty) throw Exception("No students in ths section.");
            if (attendanceOfStudents.isEmpty) attendanceOfStudents = [];

            studentsOfSection.sort((a, b) => a.lastName!.toLowerCase().compareTo(b.lastName!.toLowerCase()));

            setState(() {
                    filterBy = null;
                    currentSection = newSection;
                    attendanceStudent = attendanceOfStudents;
                    students = studentsOfSection;
                    attendanceDetails = {};
                });
        }
        // Handle better in the future. 
        catch (error) {
            print(error);
        } finally {
            setState(() => _loadingStates["isStudentsLoading"] = false);
        }
    }

    void _onChangePerson(Student? person) {
        if (person == null) {
            return setState(() => attendanceDetails = {});
        }
        List<Attendance> studentAttendanceRecord = attendanceStudent.where((attendance) => attendance.studentId == person.id).toList();
        return setState(() => attendanceDetails = AttendanceCalendarUtils.convertAttendanceDetails(studentAttendanceRecord));
    }

    void _onChangeFilterBy(FilterByType? filter) {
        setState(() {
                filterBy = filter;
                attendanceDetails = {}; 
            });
    }

    void _onChangeFilterRange(DateTimeRange dateTimeRange) {
        setState(() =>
            attendanceOfDateRange = attendanceStudent.where((attendance) {
                    return attendance.attendanceDate.isAfter(dateTimeRange.start) && attendance.attendanceDate.isBefore(dateTimeRange.end);
                }).toList()
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Attendance", 
            content: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            AttendanceCalendarUtils.buildStatus(context, AttendanceStatus.present.displayName, AppColors.presentColor, false),
                            AttendanceCalendarUtils.buildStatus(context, AttendanceStatus.late.displayName, AppColors.lateColor, false),
                            AttendanceCalendarUtils.buildStatus(context, AttendanceStatus.absent.displayName, AppColors.absentColor, false),
                            AttendanceCalendarUtils.buildStatus(context, AttendanceStatus.leave.displayName, AppColors.leaveColor, false),
                        ],
                    ),
                ),

                if (filterBy == FilterByType.student && currentSection != null) 
                AttendanceCalendar(
                    details: attendanceDetails,
                    firstDay: _firstDay, 
                    lastDay: _lastDay,  
                    focusedDay: _focusedDay,
                    onChangeFocusedDate: _onChangeFocusedDate,
                ), 
                AttendanceFilters(
                    // This role is only for testing/development purposes
                    role: Roles.teacher, 
                    changePersonFilter: _onChangePerson,
                    changeSectionFilter: _onChangeSection,
                    changeFilterBy: _onChangeFilterBy,
                    changeDateRange: _onChangeFilterRange,
                    attendance: attendanceStudent,
                    attendanceOfRange: attendanceOfDateRange,
                    students: students,
                    filters: filters,
                    sections: sectionsOfTeacher,
                    isLoading: _loadingStates
                ),
            ]
        );
    }
}

