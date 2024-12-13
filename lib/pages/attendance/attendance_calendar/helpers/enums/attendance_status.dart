enum AttendanceStatus {
    present('present', "Present"),
    late("late", "Late"),
    absent("absent", "Absent"),
    authorizedAbsence("authorizedAbsence", "Leave");

    final String value;
    final String displayName;

    const AttendanceStatus(this.value, this.displayName);

    static AttendanceStatus? fromString(String value) {
        try {
            return values.firstWhere(
                (a) => a.value.toLowerCase() == value.toLowerCase()
            );
        } catch (error) {
            return null;
        }
    }

    static AttendanceStatus? fromDisplayName(String value) {
        try {
            return values.firstWhere(
                (a) => a.displayName.toLowerCase() == value.toLowerCase()
            );
        } catch (error) {
            return null;
        }
    }
}