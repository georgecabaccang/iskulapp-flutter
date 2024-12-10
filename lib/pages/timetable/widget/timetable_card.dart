import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';
import 'package:school_erp/pages/common_widgets/dividers/general_divider.dart';
import 'package:school_erp/theme/text_styles.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:school_erp/theme/colors.dart';

class TimetableCard extends StatelessWidget {
    final String day;
    final List<Map<String, dynamic>> subjects;

    const TimetableCard({
        super.key,
        required this.day,
        required this.subjects,
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                            final subject = subjects[index];
                            return CustomItemCard(itemContents: [
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
                                    // Can only handle 
                                    GeneralDivider(symmetricDividerSpaceHeight: 1),
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
                                ],);
                        },
                    ),
                ),
            ],
        );
    }
}