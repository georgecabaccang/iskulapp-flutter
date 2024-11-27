import 'package:flutter/material.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/events/wdigets/events_detail_page.dart';
import 'package:school_erp/pages/events/helpers/mock_events.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class EventContent extends StatelessWidget {
  final Event eventContent;

  const EventContent({super.key, required this.eventContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              createSlideRoute(
                EventDetailsPage(event: eventContent),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 1,
            color: AppColors.whiteColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Column(
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
                                '${eventContent.date}, ${eventContent.time}',
                                style: bodyStyle()
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            eventContent.description,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: bodyStyle().copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
