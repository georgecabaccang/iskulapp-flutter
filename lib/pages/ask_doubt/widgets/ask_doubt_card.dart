import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/theme/text_styles.dart';

// Enum for subjects
enum Subject {
  science,
  math,
  english,
  literature,
  understandingTheSelf,
}

extension SubjectExtension on Subject {
  String get displayName {
    switch (this) {
      case Subject.science:
        return "Science";
      case Subject.math:
        return "Math";
      case Subject.english:
        return "English";
      case Subject.literature:
        return "Literature";
      case Subject.understandingTheSelf:
        return "Understanding The Self";
    }
  }
}

class AskDoubtCard extends StatefulWidget {
  const AskDoubtCard({Key? key}) : super(key: key);

  @override
  _AskDoubtCardState createState() => _AskDoubtCardState();
}

class _AskDoubtCardState extends State<AskDoubtCard> {
  List<dynamic> teachers = [];
  String? selectedTeacher;
  Subject? selectedSubject;
  List<Subject> subjects = [
    Subject.science,
    Subject.math,
    Subject.english,
    Subject.literature,
    Subject.understandingTheSelf
  ];

  @override
  void initState() {
    super.initState();
    _loadTeachersData();
  }

  Future<void> _loadTeachersData() async {
    final String response = await rootBundle.loadString('assets/teachers.json');
    final data = await json.decode(response);
    setState(() {
      teachers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),

          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Select Teacher',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              border: InputBorder.none,
            ),
            value: selectedTeacher,
            onChanged: (String? newValue) {
              setState(() {
                selectedTeacher = newValue;
                // Update subject dropdown based on selected teacher
                List<String> subjectStrings = teachers
                    .firstWhere(
                        (teacher) => teacher['name'] == newValue)['subjects']
                    .cast<String>();

                // Map List<String> to List<Subject>
                subjects = subjectStrings.map((subjectString) {
                  return Subject.values.firstWhere(
                      (subject) => subject.displayName == subjectString,
                      orElse: () => Subject.science);
                }).toList();

                selectedSubject = null;
              });
            },
            items: teachers.map<DropdownMenuItem<String>>((teacher) {
              return DropdownMenuItem<String>(
                value: teacher['name'],
                child: Text(teacher['name']),
              );
            }).toList(),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),

          // Select Subject (disabled if no teacher selected)
          DropdownButtonFormField<Subject>(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Select Subject',
              labelStyle: selectedTeacher == null
                  ? bodyStyle().copyWith(
                      color: Colors.grey.withOpacity(0.5), fontSize: 18)
                  : bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              border: InputBorder.none,
            ),
            value: selectedSubject,
            onChanged: selectedTeacher == null
                ? null // Disable dropdown if no teacher is selected
                : (Subject? newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
            items: subjects.map<DropdownMenuItem<Subject>>((subject) {
              return DropdownMenuItem<Subject>(
                value: subject,
                child: Text(subject.displayName),
              );
            }).toList(),
            disabledHint: Text(
              'Select a teacher first',
              style: bodyStyle()
                  .copyWith(color: Colors.grey.withOpacity(0.5), fontSize: 16),
            ),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),

          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Doubt Description',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            maxLines: 1,
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5278C1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                print("Doubt submitted");
              },
              child: Text(
                'SEND',
                style: buttonTextStyle().copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
