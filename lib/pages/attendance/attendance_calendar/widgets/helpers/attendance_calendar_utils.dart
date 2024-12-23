import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_roles.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';

class AttendanceCalendarUtils {

    // This function is configured like this to keep it pure.
    static List<DisplayValues> peopleOptions(
        MockRole? currentRole,
        List<MockStudent> studentsOfSection,
        List<MockTeacher> teachersOfSection,
    ) {
        if (currentRole == null) return [];
        if (currentRole.role == "teacher") return teachersOfSection;
        return studentsOfSection;
    }
}