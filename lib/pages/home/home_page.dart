import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/calendar/modified_attendance.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
import 'widgets/navigation_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5278C1),
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
                    color: Colors.white,
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
            child: Container(
              color: Colors.transparent,
              width: 250.0,
              height: 200.0,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi ${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                      fontSize: 38.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Class XI-B | Roll no: 04",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      " 2024-2025 ",
                      style: TextStyle(
                        color: Color(0xFF5278C1),
                        fontSize: 18.0,
                      ),
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
              )),
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
                  color: const Color(0xFF5278C1),
                  width: 2.0,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Color.fromARGB(255, 233, 174, 36),
                    child: Icon(
                      Icons.school,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '75.00%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
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
                  color: const Color(0xFF5278C1),
                  width: 2.0,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Color.fromRGBO(220, 80, 242, 1),
                    child: Icon(
                      Icons.monetization_on,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₱50,000',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Fees Due',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
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
        'callback': () => ()
      },
      {'title': 'Change Password', 'icon': Icons.lock, 'callback': () => ()},
      {'title': 'Events', 'icon': Icons.event, 'callback': () => ()},
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'callback': () => context.read<AuthBloc>().add(LogoutRequested())
      },
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
