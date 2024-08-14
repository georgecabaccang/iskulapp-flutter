import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5278C1),

      // Set the background color here
      body: Stack(
        children: [
          // White box positioned behind the main content
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                    top: 380.0), // Margin to adjust the position
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0), // Top-left corner radius
                    topRight: Radius.circular(30.0), // Top-right corner radius
                  ), // Adjust border radius
                ),
              ),
            ),
          ),
          Column(
            children: [
              profileInfo(), // Call the method that returns the profile info widget
              importantSection(), // Add the row section here
              Expanded(child: gridSection()), // Add the grid section here
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
                  Text(
                    "Hi Akshay",
                    style: TextStyle(
                      fontSize: 38.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Class XI-B | Roll no: 04",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
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
              child: Icon(
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
            onTap: () {
              // Handle tap action here
              print('Tapped on first box');
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
              child: Column(
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
                    padding: const EdgeInsets.only(
                        left: 16.0), // Add left margin here
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color(0xFF5278C1), // Outline color
                  width: 2.0, // Outline width
                ),
              ),
              child: Center(
                child: Text(
                  'Box 2',
                  style: TextStyle(
                    color: Color(0xFF5278C1),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridSection() {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 163 / 132, // Width / Height of the boxes
      ),
      itemCount: 14, // 7 rows x 2 columns
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Handle tap action here
            print('Tapped on item $index');
            // Navigator.pushNamed(context, '/nextPage'); // Example navigation
          },
          child: Container(
            width: 163.0, // Set the width
            height: 132.0, // Set the height
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 246, 252),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                'Item ${index + 1}',
                style: TextStyle(
                  color: Color(0xFF5278C1),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
