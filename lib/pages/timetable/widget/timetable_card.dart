import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:school_erp/theme/colors.dart';

class TimetableCard extends StatelessWidget {
  final String day;
  final List<Map<String, dynamic>> subjects;

  const TimetableCard({
    Key? key,
    required this.day,
    required this.subjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity, // Take the full width available
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      // Add padding inside the container for better spacing
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                        children: [
                          Text(
                            subject['subject'] ?? '',
                            style: headingStyle().copyWith(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${subject['time'] ?? ''}',
                            style: bodyStyle().copyWith(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8), // Add space between the time and the divider
                          const Divider(
                            thickness: 1.0, // Thickness of the line
                            color: Colors.grey, // Color of the line
                          ),
                          const SizedBox(height: 8), // Add space after the divider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${subject['teacher'] ?? ''}',
                                style: bodyStyle().copyWith(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                '${subject['period'] ?? ''}',
                                style: bodyStyle().copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
