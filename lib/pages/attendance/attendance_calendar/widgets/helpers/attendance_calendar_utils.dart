import 'package:intl/intl.dart';
import 'package:school_erp/enums/filter_by_type.dart';
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/mocks/mock_student.dart';
import 'package:school_erp/mocks/mock_teacher.dart';

class AttendanceCalendarUtils {

    // This function is configured like this to keep it pure.
    static List<DisplayValues> peopleOptions(
        FilterByType? filter,
        List<MockStudent> studentsOfSection,
        List<MockTeacher> teachersOfSection,
    ) {
        if (filter == null) return [];
        if (filter.value == "teacher") return teachersOfSection;
        return studentsOfSection;
    }

    static String dateToStringConverter(DateTime date) {
        String formattedDate = DateFormat('dd MMM, yyyy').format(date);
        return formattedDate;
    }
}