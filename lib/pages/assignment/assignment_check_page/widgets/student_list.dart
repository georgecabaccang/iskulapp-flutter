import 'package:flutter/material.dart';
import 'student_item.dart';
import 'package:school_erp/pages/assignment/assignment_answers/assignment_answers_page.dart'; // Import AssignmentAnswersPage

class StudentList extends StatelessWidget {
  final List<Student> students = [
    Student(
      name: 'Fred Mad',
      imageUrl: 'https://via.placeholder.com/150',
      score: '100',
      isChecked: true,
    ),
    Student(name: 'Ambot', score: '80+', isChecked: false),
    Student(name: 'Aimbot', score: '90', isChecked: true),
    Student(name: 'AMNMMM', score: '78', isChecked: true),
    Student(name: 'A', score: '1', isChecked: true),
  ];

  StudentList({super.key});

  void _navigateToAssignmentAnswersPage(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignmentAnswersPage(student: student),
      ),
    );
  }

  void _toggleCheck(Student student) {
    // Toggle the isChecked state of the student
    student.isChecked = !student.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              _DropdownMenu(),
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
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return GestureDetector(
                onTap: () => _navigateToAssignmentAnswersPage(context, student),
                child: StudentItem(
                  student: student,
                  index: index,
                  onToggleCheck: () =>
                      _toggleCheck(student), // Pass the toggle function
                ),
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
  String selectedOption = 'Authorize Students';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: null,
        icon: Transform.translate(
          offset: const Offset(-20, 0),
          child: const Icon(
            Icons.arrow_drop_down,
            size: 30,
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
          });
        },
        items: <String>[
          'Authorize Students',
          'Fail Students',
          'Exempt Students',
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
