import 'package:flutter/material.dart';
import 'package:school_erp/pages/calendar/calendar_attendance_page.dart';
import 'package:school_erp/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5278C1),
      body: Stack(
        children: [
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
                child: gridSection(),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                profileInfo(),
                importantSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileInfo() {
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
                  const Text(
                    "Hi Akshay",
                    style: TextStyle(
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

  Widget gridSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Container(
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
            final List<Map<String, dynamic>> items = [
              {
                'title': 'Play Quiz',
                'icon': Icons.quiz,
              },
              {
                'title': 'Assignment',
                'icon': Icons.assignment,
              },
              {
                'title': 'School Holiday',
                'icon': Icons.calendar_today,
              },
              {
                'title': 'Time Table',
                'icon': Icons.schedule,
              },
              {
                'title': 'Result',
                'icon': Icons.grade,
              },
              {
                'title': 'Date Sheet',
                'icon': Icons.date_range,
              },
              {
                'title': 'Doubts',
                'icon': Icons.help_outline,
              },
              {
                'title': 'School Gallery',
                'icon': Icons.photo_library,
              },
              {
                'title': 'Leave Application',
                'icon': Icons.request_page,
              },
              {
                'title': 'Change Password',
                'icon': Icons.lock,
              },
              {
                'title': 'Events',
                'icon': Icons.event,
              },
              {
                'title': 'Logout',
                'icon': Icons.logout,
              },
            ];

            return GestureDetector(
              onTap: () {
                final item = items[index];
                print('Tapped on ${item['title']}');
                // Add navigation or functionality for each item here
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FC),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: const Color(0xFF5278C1),
                      child: Icon(
                        items[index]['icon'],
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      items[index]['title'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
