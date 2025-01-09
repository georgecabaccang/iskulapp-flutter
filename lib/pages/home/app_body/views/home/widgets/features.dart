import 'package:flutter/material.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/attendance_create_update_page.dart';
import 'package:school_erp/pages/attendance/attendance_calendar/attendance_calendar_page.dart';
import 'package:school_erp/pages/calendar/calendar_attendance_page.dart';
import 'package:school_erp/pages/default_page.dart';
import 'package:school_erp/pages/events/events_page.dart';
import 'package:school_erp/pages/learn/learn.dart';
import 'package:school_erp/pages/leave_application/leave_application_page.dart';
import 'package:school_erp/pages/school_gallery/school_gallery_page.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/timetable/timetable_page.dart';

class Features extends StatelessWidget {
  final AuthenticatedUser user;

  const Features({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    List<FeatureSection> features = [
      const FeatureSection(title: 'Core', features: <FeatureButton>[
        FeatureButton(
          title: 'Quiz',
          icon: Icons.edit_note_outlined,
          target: DefaultPage(title: "Quiz", fontColor: AppColors.primaryColor),
        ),
        FeatureButton(
          title: 'Homework',
          icon: Icons.assignment,
          target: DefaultPage(
              title: "Assignment", fontColor: AppColors.primaryColor),
          //target: AssignmentListPage(),
        ),
        FeatureButton(
          title: 'Learn',
          icon: Icons.local_library_outlined,
          target:
              DefaultPage(title: "Learn", fontColor: AppColors.primaryColor),
          //target: LearnPage(),
        ),
        FeatureButton(
          title: 'Attendance',
          icon: Icons.emoji_people_outlined,
          // target: AttendanceCreateUpdatePage(),
          target: AttendanceCalendarPage(),
        ),
        FeatureButton(
          title: 'Billing',
          icon: Icons.payment_outlined,
          target:
              DefaultPage(title: "Billing", fontColor: AppColors.primaryColor),
        ),
      ]),
      FeatureSection(title: 'Time Calendar', features: <FeatureButton>[
        FeatureButton(
          title: 'Calendar',
          icon: Icons.calendar_month,
          target: DefaultPage(
              title: "Attendance", fontColor: AppColors.primaryColor),
          //target: CalendarAttendancePage(),
        ),
        const FeatureButton(
          title: 'Subject\nSchedule',
          icon: Icons.event_note,
          target: DefaultPage(
              title: "Time Table", fontColor: AppColors.primaryColor),
          //target: TimeTablePage(),
        ),
        const FeatureButton(
          title: 'Apply Absents',
          icon: Icons.edit_calendar,
          target: DefaultPage(
              title: "Leave Application", fontColor: AppColors.primaryColor),
          //target: LeaveApplicationPage(),
        ),
      ]),
      const FeatureSection(title: 'Activities', features: <FeatureButton>[
        FeatureButton(
          title: 'Events',
          icon: Icons.celebration,
          target: DefaultPage(
            title: "Events",
            fontColor: AppColors.primaryColor,
          ),
          //target: EventsPage(),
        ),
        FeatureButton(
          title: 'School Gallery',
          icon: Icons.collections,
          target: DefaultPage(
              title: "School Gallery", fontColor: AppColors.primaryColor),
        ),
        //target: SchoolGalleryPage(),
      ]),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
            children: features.map((feature) {
          return _featuresContainer(context, feature);
        }).toList());
      },
    );
  }

  Widget _featuresContainer(BuildContext context, FeatureSection feature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: (24)),
          child: Text(
            feature.title,
            style: headingStyle().copyWith(
              fontSize: 20,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: (14)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: feature.features.map((feature) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      createSlideRoute(feature.target),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(
                          feature.icon,
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        width: 78,
                        height: 50,
                        child: Text(
                          feature.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                              color: AppColors.whiteColor, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureSection {
  final String title;
  final List<FeatureButton> features;

  const FeatureSection({required this.title, required this.features});
}

class FeatureButton {
  final String title;
  final IconData icon;
  final Widget target;

  const FeatureButton(
      {required this.title, required this.icon, required this.target});
}
