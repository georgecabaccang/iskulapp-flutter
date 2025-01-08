import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/interfaces/display_values.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';


class Section implements EntityDisplayData{
    final String id;
    final String academicYearId;
    final String gradeLevelId;
    final String? advisorId;
    final String name;

    Section({
        required this.id,
        required this.academicYearId,
        required this.gradeLevelId,
        this.advisorId,
        required this.name,
    });

    factory Section.fromRow(sqlite.Row row) {
        return Section(
            id: row['id'],
            academicYearId: row['academic_year_id'],
            gradeLevelId: row['grade_level_id'],
            advisorId: row['advisor_id'],
            name: row['name'],
        );
    }

    @override
    String get displayName => name.capitalize();

    @override
    String get value => name;
}
