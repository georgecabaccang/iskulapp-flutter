import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay parseTimeOfDay(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

String toDateString(DateTime dt) {
  return DateFormat('yyyy-MM-dd').format(dt);
}
