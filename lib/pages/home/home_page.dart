import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/calendar/modified_attendance.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/events/events_page.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
<<<<<<< HEAD
=======
import 'package:school_erp/pages/timetable/timetable_page.dart';
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
import 'package:table_calendar/table_calendar.dart';
import 'widgets/navigation_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/constants/text_constants.dart';
import 'package:school_erp/pages/leave_application/leave_application_page.dart';
import 'package:school_erp/pages/change_password/change_password_page.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.user, {super.key});

  final AuthenticatedUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _animate = false;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _animate = true;
      });
    });
  }

  void _goToCalendarAttendancePage() async {
    setState(() {
      _isTransitioning = true;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CalendarAttendancePage(
                focusDate: DateTime.now()), // Pass the focusDate here
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No additional animation needed here, handled in CalendarAttendancePage
        },
      ),
    ).then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation(); // Re-start the animation when coming back
      });
    });
  }

  void _goToAssignmentPage() {
    setState(() {
      _isTransitioning = true;
    });

    _navigateToAssignmentPage().then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation(); // Re-start the animation when coming back
      });
    });
  }

  Future<void> _navigateToAssignmentPage() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AssignmentListPage(),
      ),
    );
  }

  void _goToEventsPage() {
    setState(() {
      _isTransitioning = true;
    });

    _navigateToEventsPage().then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation();
      });
    });
  }

  Future<void> _navigateToEventsPage() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const EventsPage(),
      ),
    );
  }

<<<<<<< HEAD
  void _goToLeaveApplicationPage() {
=======

  
  void _goToTimeTablePage() {
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
    setState(() {
      _isTransitioning = true;
    });

<<<<<<< HEAD
    _navigateToLeaveApplicationPage().then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation(); // Re-start the animation when coming back
=======
    _navigateToTimeTablePage().then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation(); 
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
      });
    });
  }

<<<<<<< HEAD
  Future<void> _navigateToLeaveApplicationPage() async {
=======
  Future<void> _navigateToTimeTablePage() async {
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
    await Future.delayed(const Duration(milliseconds: 200));
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
<<<<<<< HEAD
            const LeaveApplicationPage(),
=======
            const TimeTablePage(),
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
      ),
    );
  }

<<<<<<< HEAD
  void _goToChangePasswordPage() {
    setState(() {
      _isTransitioning = true;
    });

    _navigateToChangePasswordPage().then((_) {
      setState(() {
        _isTransitioning = false;
        _animate = false;
        _startAnimation(); // Re-start the animation when coming back
      });
    });
  }

  Future<void> _navigateToChangePasswordPage() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ChangePasswordPage(),
      ),
    );
  }
=======
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Main content
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                top: _animate ? 380.0 : 800.0, // Adjust starting position
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height - 380,
                  child: AnimatedOpacity(
                    opacity: _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
                    duration: const Duration(milliseconds: 500),
                    child: gridSection(context),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    profileInfo(widget.user),
                    importantSection(),
                  ],
                ),
              ),
              if (state is AuthLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget profileInfo(AuthenticatedUser user) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 50.0),
<<<<<<< HEAD
            child: Container(
              color: Colors.transparent,
              width: 250.0,
              height: 200.0,
              alignment: Alignment.topLeft,
=======
            child: _buildUserInfo(user),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 30.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    EnterExitRoute(exitPage: context.widget, enterPage: const ProfilePage())
                  );
                },
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(AuthenticatedUser user) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.homePageMessage(user.firstName, user.lastName),
            style: headingStyle().copyWith(fontSize: 50.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8.0),
          Opacity(
            opacity: 0.7, // Set your desired opacity level here (0.0 to 1.0)
            child: Text(
              "Class XI-B | Roll no: 04",
              style: bodyStyle().copyWith(
                fontSize: 24.0,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "2024-2025",
              style: bodyStyle().copyWith(fontSize: 18.0, color: const Color(0xFF6184C7) ),
            ),
          ),
        ],
      ),
    );
  }
  Widget importantSection() {
    final List<Map<String, dynamic>> importantItems = [
      {
        'title': 'PE',
        'value': 'TOP 2',
        'icon': Icons.school,
        'color': AppColors.warningColor,
        'onTap': () => print('Tapped top 2'),
      },
      {
        'title': 'Merit POints',
        'value': '999999',
        'icon': Icons.monetization_on,
        'color': AppColors.purple,
        'onTap': () => print('Tapped on second box'),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),  // To keep it non-scrollable
        shrinkWrap: true,  // Ensures the grid view only takes the necessary space
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: importantItems.length,
        itemBuilder: (context, index) {
          final item = importantItems[index];
          return _buildImportantCard(
            title: item['title'],
            value: item['value'],
            icon: item['icon'],
            color: item['color'],
            onTap: item['onTap'],
          );
        },
      ),
    );
  }

  Widget _buildImportantCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.primaryColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextConstants.homePageMessage(
                        user.firstName, user.lastName),
                    style: headingStyle().copyWith(fontSize: 38.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Class XI-B | Roll no: 04",
                    style: bodyStyle()
                        .copyWith(fontSize: 24.0, color: AppColors.whiteColor),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      " 2024-2025 ",
                      style: bodyStyle().copyWith(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 50.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isTransitioning = true;
                });
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ProfilePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child; // No additional animation needed here
                      },
                    ),
                  ).then((_) {
                    setState(() {
                      _isTransitioning = false;
                      _animate = false;
                      _startAnimation(); // Re-start the animation when coming back
                    });
                  });
                });
              },
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget importantSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _goToCalendarAttendancePage,
            child: Container(
              width: 182.0,
              height: 221.0,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: AppColors.warningColor,
                    child: Icon(
                      Icons.school,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '75.00%',
                          style: headingStyle()
                              .copyWith(fontSize: 36.0, color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Attendance',
                          style: bodyStyle().copyWith(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print('Tapped on second box');
            },
            child: Container(
              width: 182.0,
              height: 221.0,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: AppColors.purple,
                    child: Icon(
                      Icons.monetization_on,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₱50,000',
                          style: headingStyle()
                              .copyWith(fontSize: 36.0, color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Fees Due',
                          style: bodyStyle().copyWith(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridSection(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Play Quiz', 'icon': Icons.quiz, 'callback': () => ()},
      {
        'title': 'Assignment',
        'icon': Icons.assignment,
        'callback': () => _goToAssignmentPage()
      },
      {
        'title': 'School Holiday',
        'icon': Icons.calendar_today,
        'callback': () => ()
      },
<<<<<<< HEAD
=======
      {'title': 'Time Table', 'icon': Icons.schedule, 'callback':() => _goToTimeTablePage()},
      {'title': 'Assignment', 'icon': Icons.assignment, 'callback': () {
        Navigator.push(
            context,
            EnterExitRoute(exitPage: context.widget, enterPage: const AssignmentListPage())
        );
      }},
      {'title': 'Attendance', 'icon': Icons.calendar_today, 'callback': () {
        Navigator.push(
          context,
          EnterExitRoute(exitPage: context.widget, enterPage: CalendarAttendancePage(focusDate: DateTime.now())
          ),
        );
      }},
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
      {'title': 'Time Table', 'icon': Icons.schedule, 'callback': () => ()},
      {'title': 'Result', 'icon': Icons.grade, 'callback': () => ()},
      {'title': 'Date Sheet', 'icon': Icons.date_range, 'callback': () => ()},
      {'title': 'Doubts', 'icon': Icons.help_outline, 'callback': () => ()},
<<<<<<< HEAD
      {
        'title': 'School Gallery',
        'icon': Icons.photo_library,
        'callback': () => ()
      },
      {
        'title': 'Leave Application',
        'icon': Icons.request_page,
        'callback': () => _goToLeaveApplicationPage()
      },
      {
        'title': 'Change Password',
        'icon': Icons.lock,
        'callback': () => _goToChangePasswordPage()
      },
      {
        'title': 'Events',
        'icon': Icons.event,
        'callback': () => _goToEventsPage()
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'callback': () => context.read<AuthBloc>().add(LogoutRequested())
      },
=======
      {'title': 'School Gallery', 'icon': Icons.photo_album, 'callback': () => ()},
      {'title': 'Leave Application', 'icon': Icons.request_page, 'callback': () => ()},
      {'title': 'Change Password', 'icon': Icons.lock, 'callback': () => ()},
      {'title': 'Events', 'icon': Icons.event, 'callback': () {

        Navigator.push(
          context,
          EnterExitRoute(exitPage: context.widget, enterPage: const EventsPage())
        );
      }},
      {'title': 'Logout', 'icon': Icons.logout, 'callback': () => context.read<AuthBloc>().add(LogoutRequested())},
>>>>>>> bd7d424d71ffd939df95007127239f50533bdd3e
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 163 / 132,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final item = items[index];
          return NavigationCard(
            item['title'],
            item['icon'],
            item['callback'],
          );
        },
      ),
    );
  }
}
