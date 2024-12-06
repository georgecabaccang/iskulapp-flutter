import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceList extends StatelessWidget {
    final List<DateTime> daysInMonth;

    const AttendanceList({
        super.key,
        required this.daysInMonth,
    });

    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: ListView.builder(
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                    DateTime date = daysInMonth[index];
                    String day = DateFormat('dd').format(date);
                    String shortMonth = DateFormat('MMM').format(date);
                    String weekday = DateFormat('EEEE').format(date);

                    bool isHoliday = (weekday == "Saturday" || weekday == "Sunday");
                    String status = isHoliday ? "Holiday" : "Present";

                    return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const SizedBox(
                                    width: 15,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        Text(
                                            day,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        Text(
                                            shortMonth,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                            ),
                                        ),
                                    ],
                                ),
                                const SizedBox(
                                    width: 15,
                                ),
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom:
                                                BorderSide(color: Colors.grey, width: 1.5))),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                                Text(
                                                    status,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                ),
                                                const SizedBox(height: 2.5),
                                                Text(
                                                    weekday,
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey,
                                                    ),
                                                ),
                                                const SizedBox(height: 5),
                                            ],
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    );
                },
            ),
        );
    }
}