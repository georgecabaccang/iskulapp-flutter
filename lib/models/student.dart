import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class Student implements EntityDisplayData{
    final String id;
    final String userId;
    final String studentNo;

    // from relation
    final String? firstName;
    final String? middleName;
    final String? lastName;

    Student({
        required this.id,
        required this.userId,
        required this.studentNo,
        this.firstName,
        this.middleName,
        this.lastName,
    });

    factory Student.fromRow(sqlite.Row row) => Student(
        id: row['id'],
        userId: row['user_id'],
        studentNo: row['student_no'],
        firstName: row['first_name'],
        middleName: row['middle_name'],
        lastName: row['last_name'],
    );

    @override
    String get displayName => "${lastName?.toUpperCase()}, ${firstName?.capitalize()} ${middleName != null ? '${middleName![0].toUpperCase() }.' : ''}";

    @override
    String get value => userId;
}
