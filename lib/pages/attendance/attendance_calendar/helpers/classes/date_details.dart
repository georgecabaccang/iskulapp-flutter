class DateDetails {
    final DateTime? date;
    final String attendanceStatus;
    final String? lateTime;

    DateDetails({
        required this.date, 
        required this.attendanceStatus, 
        required this.lateTime
    });

    factory DateDetails.fromJson(Map<String, dynamic> json) {
        return DateDetails(
            date: DateTime.parse(json['date']),
            attendanceStatus: json['attendanceStatus'] ?? '',
            lateTime: json['lateTime'] ?? '',
        );
    }
}