import 'package:flutter/material.dart';
import 'package:school_erp/pages/events/helpers/mock_events.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background widget that occupies the top half of the page.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                // image: DecorationImage(
                //   image: AssetImage('assets/event_background.jpg'), // Will add image here
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          // Content of the page
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.35, // Start content below the background
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        Text(
                          '${event.date}, ${event.time}',
                          style: bodyStyle().copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      event.title,
                      style: headingStyle()
                          .copyWith(fontSize: 24)
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Text(
                      event.description,
                      style: bodyStyle()
                          .copyWith(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                iconSize: 36,
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
