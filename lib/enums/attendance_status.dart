enum AttendanceStatus {
  present("present", "Present"),
  late("late", "Late"),
  absent("absent", "Absent"),
  authorizedAbsence("authorized_absence", "Leave");

  final String value;
  final String displayName;

  const AttendanceStatus(this.value, this.displayName);

  static AttendanceStatus fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () =>
          throw ArgumentError('Invalid AttendanceStatus value: $value'),
    );
  }

  static AttendanceStatus fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () => throw ArgumentError(
          'Invalid AttendanceStatus display name: $displayName'),
    );
  }
}
