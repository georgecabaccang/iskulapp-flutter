import 'package:flutter/material.dart';
import 'student_item.dart';

class StudentList extends StatelessWidget {
  // List of students with their details and checked state
  final List<Student> students = [
    Student(
        name: 'Fred Mad',
        imageUrl: 'https://via.placeholder.com/150',
        score: '100',
        isChecked: true),
    Student(name: 'Ambot', score: '80+', isChecked: false),
    Student(name: 'Aimbot', score: '90', isChecked: true),
    Student(name: 'AMNMMM', score: '78', isChecked: true),
    Student(name: 'A', score: '1', isChecked: true),
  ];

  // Toggle the check state of a student
  void _toggleCheck(BuildContext context, int index) {
    students[index].isChecked = !students[index].isChecked;
    (context as Element).markNeedsBuild(); // Triggers rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title and dropdown section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Algebra 1',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _DropdownMenu(), // Adding the dropdown menu widget
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'These are the list of students and their automatic computed scores, some scores are not computed. With pending.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ),
        // Scrollable list of students
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return StudentItem(
                student: student,
                index: index,
                onToggleCheck: () => _toggleCheck(context, index),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DropdownMenu extends StatefulWidget {
  @override
  __DropdownMenuState createState() => __DropdownMenuState();
}

class __DropdownMenuState extends State<_DropdownMenu> {
  String selectedOption = 'Authorize Students'; // Default selected option

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: null, // Set value to null to hide the selected option
        icon: Transform.translate(
          offset: const Offset(-20, 0), // Move the icon 20 pixels to the left
          child: Icon(
            Icons.arrow_drop_down,
            size: 30, // Enlarge the icon
          ),
        ),
        onChanged: (String? newValue) {
          // Update state or perform action when an option is selected
          setState(() {
            selectedOption = newValue!;
          });
        },
        items: <String>[
          'Authorize Students',
          'Fail Students',
          'Exempt Students'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
