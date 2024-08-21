import 'package:flutter/material.dart';
import 'package:school_erp/pages/calendar_attendance_page.dart';

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
            CalendarAttendancePage(),
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
      backgroundColor: Color(0xFF5278C1),
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
            ),
          ),
          Column(
            children: [
              AnimatedOpacity(
                opacity: _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 500),
                child: profileInfo(),
              ),
              AnimatedOpacity(
                opacity: _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 500),
                child: importantSection(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      top: _animate ? 0.0 : 200.0, // Adjust starting position
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity:
                            _isTransitioning ? 0.0 : (_animate ? 1.0 : 0.0),
                        duration: const Duration(milliseconds: 500),
                        child: gridSection(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  SizedBox(height: 8.0),
                  const Text(
                    "Class XI-B | Roll no: 04",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      " 2024-2025 ",
                      style: TextStyle(
                        color: Color(0xFF5278C1),
                        fontSize: 18.0,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 50.0),
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
                  color: Color(0xFF5278C1), // Outline color
                  width: 2.0, // Outline width
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
                    padding:
                        EdgeInsets.only(left: 16.0), // Add left margin here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '75.00%', // Example attendance percentage
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
              // Handle tap action here
              print('Tapped on second box');
              // Navigator.pushNamed(context, '/nextPage'); // Example navigation
            },
            child: Container(
              width: 182.0,
              height: 221.0,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color(0xFF5278C1), // Outline color
                  width: 2.0, // Outline width
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
                    padding:
                        EdgeInsets.only(left: 16.0), // Add left margin here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₱50,000', // Example fees due
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
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      top: _animate ? 0.0 : 200.0, // Initial position, adjust as needed
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedOpacity(
        opacity: _animate ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1200),
        child: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 163 / 132, // Width / Height of the boxes
          ),
          itemCount: 12, // 7 rows x 2 columns
          itemBuilder: (context, index) {
            // List of items with their corresponding text and icons
            final List<Map<String, dynamic>> items = [
              {
                'title': 'Play Quiz',
                'icon': Icons.quiz,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Assignment',
                'icon': Icons.assignment,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'School Holiday',
                'icon': Icons.beach_access,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Time Table',
                'icon': Icons.schedule,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Result',
                'icon': Icons.insert_chart,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Date Sheet',
                'icon': Icons.date_range,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Doubts',
                'icon': Icons.help,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'School Gallery',
                'icon': Icons.photo_album,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Leave Application',
                'icon': Icons.note_add,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Change Password',
                'icon': Icons.lock,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Events',
                'icon': Icons.event,
                'color': Color(0xFF5278C1)
              },
              {
                'title': 'Logout',
                'icon': Icons.logout,
                'color': Color(0xFF5278C1)
              },
            ];

            // Access the current item and cast the values to their correct types
            final item = items[index];
            final String title = item['title'] as String;
            final IconData icon = item['icon'] as IconData;
            final Color color = item['color'] as Color;

            return GestureDetector(
              onTap: () {
                // Handle tap action here
                print('Tapped on $title');
                // Navigator.pushNamed(context, '/${title}Page'); // Example navigation
              },
              child: Container(
                width: 163.0, // Set the width
                height: 132.0, // Set the height
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 246, 252),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0), // Add padding around the Column
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: color,
                        child: Icon(
                          icon,
                          size: 38.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
