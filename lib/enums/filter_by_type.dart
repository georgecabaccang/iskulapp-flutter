import 'package:school_erp/interfaces/display_values.dart';

enum FilterByType implements EntityDisplayData {
    student("student", "Student"),
    date("date", "Date");

    @override
    final String value;

    @override
    final String displayName;

    const FilterByType(this.value, this.displayName);

    static FilterByType? fromString(String value) {
        try {
            return values.firstWhere(
                (f) => f.value.toLowerCase() == value.toLowerCase()
            );
        } catch (error) {
            return null;
        }
    }

    static FilterByType? fromDisplayName(String value) {
        try {
            return values.firstWhere(
                (f) => f.displayName.toLowerCase() == value.toLowerCase()
            );
        } catch (error) {
            return null;
        }
    }

}