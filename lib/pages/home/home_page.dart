import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/calendar/modified_attendance.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/events/events_page.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
import 'widgets/navigation_card.dart';
import 'package:school_erp/pages/timetable/timetable_page.dart';
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
              _buildMainContent(),
              _buildTopSection(),
              if (state is AuthLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.only(top: 350),
      padding: const EdgeInsets.only(top: 90),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: gridSection(context),
    );
  }

  Widget _buildTopSection() {
    return Column(
      children: [
        profileInfo(widget.user),
        importantSection(),
      ],
    );
  }

  Widget profileInfo(AuthenticatedUser user) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 50.0),
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
                        EnterExitRoute(
                            exitPage: context.widget,
                            enterPage: const ProfilePage()));
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
              )),
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
            style: headingStyle()
                .copyWith(fontSize: 50.0, fontWeight: FontWeight.w500),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "2024-2025",
              style: bodyStyle()
                  .copyWith(fontSize: 18.0, color: const Color(0xFF6184C7)),
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
        physics:
            const NeverScrollableScrollPhysics(), // To keep it non-scrollable
        shrinkWrap:
            true, // Ensures the grid view only takes the necessary space
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: color,
                    child: Icon(icon, size: 60.0, color: Colors.white),
                  ),
                  Text(
                    value,
                    style: headingStyle().copyWith(
                      fontSize: 46.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    style: bodyStyle().copyWith(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridSection(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Play Quiz', 'icon': Icons.quiz, 'callback': () => ()},
      {
        'title': 'Assignment',
        'icon': Icons.assignment,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const AssignmentListPage()));
        }
      },
      {
        'title': 'Attendance',
        'icon': Icons.calendar_today,
        'callback': () {
          Navigator.push(
            context,
            EnterExitRoute(
                exitPage: context.widget,
                enterPage: CalendarAttendancePage(focusDate: DateTime.now())),
          );
        }
      },
      {'title': 'Time Table', 'icon': Icons.schedule, 'callback': () => ()},
      {'title': 'Result', 'icon': Icons.grade, 'callback': () => ()},
      {'title': 'Date Sheet', 'icon': Icons.date_range, 'callback': () => ()},
      {'title': 'Doubts', 'icon': Icons.help_outline, 'callback': () => ()},
      {
        'title': 'School Gallery',
        'icon': Icons.photo_library,
        'callback': () => ()
      },
      {
        'title': 'Leave Application',
        'icon': Icons.request_page,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const LeaveApplicationPage()));
        }
      },
      {
        'title': 'Change Password',
        'icon': Icons.lock,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget,
                  enterPage: const ChangePasswordPage()));
        }
      },
      {
        'title': 'Events',
        'icon': Icons.event,
        'callback': () {
          Navigator.push(
              context,
              EnterExitRoute(
                  exitPage: context.widget, enterPage: const EventsPage()));
        }
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'callback': () => context.read<AuthBloc>().add(LogoutRequested())
      },
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return NavigationCard(
          title: items[index]['title'],
          icon: items[index]['icon'],
          callback: items[index]['callback'],
        );
      },
    );
  }
}
