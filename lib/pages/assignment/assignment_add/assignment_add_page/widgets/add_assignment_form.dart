import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_setup_page/question_setup_page.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/fade_page_transition.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_add_page/assignment_add_page.dart';

enum AssignmentType {
  online,
  inApp,
  takeHome,
}

class AddAssignmentForm extends StatefulWidget {
  const AddAssignmentForm({super.key});

  @override
  State<AddAssignmentForm> createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  String? selectedClassTitle;
  String? selectedSubject;
  String? aiGenerated;
  List<String> classList = [];
  List<String> subjectList = [];
  AssignmentType? selectedType;
  String? selectedAIOption;
  List<String> aiOptions = ["Yes", "No"];

  @override
  void initState() {
    super.initState();
    _loadClassesTitle();
    _loadSubjects();
    selectedType = AssignmentType.online;
  }

  Future<void> _loadClassesTitle() async {
    String jsonString =
        await rootBundle.loadString('assets/addAssignmentData/classes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      classList = jsonResponse.cast<String>();
      selectedClassTitle = classList.isNotEmpty ? classList[0] : null;
    });
  }

  Future<void> _loadSubjects() async {
    String jsonString =
        await rootBundle.loadString('assets/addAssignmentData/subjects.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      subjectList = jsonResponse.cast<String>();
      selectedSubject = subjectList.isNotEmpty ? subjectList[0] : null;
    });
  }

  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
    Navigator.push(
                context,
                EnterExitRoute(exitPage: context.widget, enterPage: const QuestionSetupPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }

  String assignmentTypeToString(AssignmentType type) {
    switch (type) {
      case AssignmentType.online:
        return "Online";
      case AssignmentType.inApp:
        return "In App";
      case AssignmentType.takeHome:
        return "Take Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedClassTitle,
                  items: classList.map((String classTitle) {
                    return DropdownMenuItem<String>(
                      value: classTitle,
                      child: Text(classTitle),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedClassTitle = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Class',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a Class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<String>(
                  value: selectedSubject,
                  items: subjectList.map((String subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(subject),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Subject',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: 'What should you call this assignment',
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField<AssignmentType>(
                  value: selectedType,
                  items: AssignmentType.values.map((AssignmentType type) {
                    return DropdownMenuItem<AssignmentType>(
                      value: type,
                      child: Text(assignmentTypeToString(type)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildAssignmentTypeForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    selectedType == AssignmentType.inApp
                        ? "Create Assignment"
                        : "SEND",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildAssignmentTypeForm() {
    switch (selectedType) {
      case AssignmentType.online:
        return Column(
          children: [
            const SizedBox(height: 5),
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Enter valid URL',
                labelText: 'URL',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a URL';
                }
                final RegExp urlPattern = RegExp(
                  r'^(https?:\/\/)?' // Optional http or https
                  r'((([a-z0-9\-]+\.)+[a-z]{2,})|localhost|' // Domain name or localhost
                  r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))' // IP address
                  r'(:\d+)?(\/\S*)?$', // Optional port and path
                  caseSensitive: false,
                );
                if (!urlPattern.hasMatch(value)) {
                  return 'Enter a valid URL';
                }
                return null;
              },
            ),
          ],
        );

      case AssignmentType.inApp:
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            DropdownButtonFormField<String>(
              value: selectedAIOption,
              items: aiOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedAIOption = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Is it AI generated',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
          ],
        );

      case AssignmentType.takeHome:
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextFormField(
              maxLength: 30,
              decoration: const InputDecoration(
                hintText: 'How can this assignment be done',
                labelText: 'Instructions',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Instructions';
                }
                return null;
              },
            ),
          ],
        );

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid assignment type selected'),
          ),
        );
        return const SizedBox.shrink(); 
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
