import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_setup_page/question_setup_page.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/fade_page_transition.dart';
import './add_assignment_dropdown.dart';
import 'package:school_erp/theme/colors.dart';

class AddAssignmentForm extends StatefulWidget {
  const AddAssignmentForm({super.key});

  @override
  State<AddAssignmentForm> createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedType;
  String? aiGenerated;
  List<String> classList = [];
  List<String> subjectList = [];
  List<String> typeList = [
    "Online",
    "In App",
    "Take Home",
  ];
  List<String> aiOptions = ["Yes", "No"];
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadClasses();
    _loadSubjects();
  }

  Future<void> _loadClasses() async {
    String jsonString =
        await rootBundle.loadString('assets/addAssignmentData/classes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      classList = jsonResponse.cast<String>();
      selectedClass = classList.isNotEmpty ? classList[0] : null;
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

  //TODO: convert to form / formField
  void _validateAndSubmit() {
    String? errorMessage;

    // Validate class
    if (selectedClass == null) {
      errorMessage = "Please select a class.";
    }
    // Validate subject
    else if (selectedSubject == null) {
      errorMessage = "Please select a subject.";
    }
    // Validate title
    else if (titleController.text.isEmpty) {
      errorMessage = "Please enter a title.";
    }
    // Validate type-specific fields
    else if (selectedType == "Online" && urlController.text.isEmpty) {
      errorMessage = "Please enter a URL.";
    } else if (selectedType == "Take Home" &&
        instructionsController.text.isEmpty) {
      errorMessage = "Please enter instructions.";
    }

    // If validation failed, show error message
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      Navigator.push(
        context,
        FadePageRoute(
          page: const QuestionSetupPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Class",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            AddAssignmentDropdown(
              value: selectedClass,
              items: classList,
              hint: "Choose a class",
              onChanged: (newValue) {
                setState(() {
                  selectedClass = newValue;
                });
              },
            ),
            const SizedBox(height: 25),
            const Text(
              "Select Subject",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            AddAssignmentDropdown(
              value: selectedSubject,
              items: subjectList,
              hint: "Choose a subject",
              onChanged: (newValue) {
                setState(() {
                  selectedSubject = newValue;
                });
              },
            ),
            const SizedBox(height: 25),
            const Text(
              "Title",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: titleController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Type here",
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Select Type",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            AddAssignmentDropdown(
              value: selectedType,
              items: typeList,
              hint: "Choose a type",
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue;
                  aiGenerated = null;
                });
              },
            ),
            const SizedBox(height: 25),
            if (selectedType == "Online") ...[
              const Text(
                "URL",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter the URL",
                ),
              ),
            ] else if (selectedType == "In App") ...[
              const Text(
                "AI Generated",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              AddAssignmentDropdown(
                value: aiGenerated,
                items: aiOptions,
                hint: "Choose an option",
                onChanged: (newValue) {
                  setState(() {
                    aiGenerated = newValue;
                  });
                },
              ),
            ] else if (selectedType == "Take Home") ...[
              const Text(
                "Instructions",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              TextField(
                controller: instructionsController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter instructions",
                ),
              ),
            ],
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ElevatedButton(
              onPressed: _validateAndSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                selectedType == "In App" ? "Create Assignment" : "SEND",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    instructionsController.dispose();
    super.dispose();
  }
}
