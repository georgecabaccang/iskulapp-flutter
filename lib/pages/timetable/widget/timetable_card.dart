import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';
import 'package:school_erp/pages/common_widgets/dividers/general_divider.dart';
import 'package:school_erp/pages/timetable/helpers/timetable.dart';
import 'package:school_erp/theme/text_styles.dart';


class TimetableCard extends StatelessWidget {
    final ClassDetails classDetails;

    const TimetableCard({
        super.key,
        required this.classDetails,
    });

    @override
    Widget build(BuildContext context) {
        return  CustomItemCard(itemContents: [
                Text(
                    classDetails.subject,
                    style: headingStyle().copyWith(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                    ),
                ),
                SizedBox(height: 10),
                Text(
                    classDetails.time,
                    style: bodyStyle().copyWith(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                    ),
                ),
                // Check spacing implmentations sa widget mismo
                GeneralDivider(symmetricDividerSpaceHeight: 1),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                            classDetails.teacher,
                            style: bodyStyle().copyWith(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                            ),
                        ),
                        Text(
                            classDetails.period,
                            style: bodyStyle().copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}