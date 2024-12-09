import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';
import 'package:school_erp/pages/events/wdigets/events_detail_page.dart';
import 'package:school_erp/pages/events/helpers/mock_events.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class EventContent extends StatelessWidget {
    final Event eventContent;

    const EventContent({super.key, required this.eventContent});

    String formatDate(DateTime date) => DateFormat('dd, MMM yyyy').format(date);

    @override
    Widget build(BuildContext context) {
        return CustomItemCard(
            slideRoute: EventDetailsPage(event: eventContent), 
            itemContents: [
                Text(
                    eventContent.title,
                    style: headingStyle()
                        .copyWith(color: Colors.black, fontSize: 18),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                        Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8.0),
                            ),
                        ),
                        const SizedBox(height: 10, width: 10),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Row(
                                        children: [
                                            const Icon(
                                                Icons.access_time,
                                                color: AppColors.primaryColor,
                                                size: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                                '${formatDate(eventContent.date)} - ${eventContent.time}',
                                                style: bodyStyle()
                                                    .copyWith(color: AppColors.primaryColor),
                                            ),
                                        ],
                                    ),
                                    Row(
                                        children: [ 
                                            Expanded(
                                                child: Text(
                                                    eventContent.description,
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: bodyStyle().copyWith(color: Colors.grey),
                                                ),)
                                        ],
                                    )
                                ],
                            ),
                        )
                    ],
                ),
            ],
        );
    }
}