enum AttendanceStatus {
    present('present', "Present"),
    late("late", "Late"),
    absent("absent", "Absent"),
    authorizedAbsence("authorizedAbsence", "Leave");

    final String value;
    final String displayName;

    const AttendanceStatus(this.value, this.displayName);
}