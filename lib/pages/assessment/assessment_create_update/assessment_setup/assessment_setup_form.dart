import 'package:flutter/material.dart';
import 'package:school_erp/enums/assignment_type.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/models/teacher.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/assessment_takers_page.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class AssessmentSetupForm extends StatefulWidget {
  final Assessment? assessment;
  const AssessmentSetupForm({this.assessment, super.key});

  @override
  _AssessmentSetupFormState createState() => _AssessmentSetupFormState();
}

class _AssessmentSetupFormState extends State<AssessmentSetupForm> {
  AssignmentType selectedType = AssignmentType.inApp;
  SubjectYear? selectedSubject;
  String? title;
  String? instructions;

  List<SubjectYear> _subjectYears = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {});
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _subjectYears = await Teacher.activeSubjects();
      if (!mounted) return;

      if (widget.assessment != null) {
        var subjectYear = await widget.assessment!.subjectYear();

        print('contains');
        print('this is selected ${subjectYear.id}');
        for (final subjectYear in _subjectYears) {
          print(subjectYear.id);
        }

        setState(() {
          selectedSubject = subjectYear;
          print(_subjectYears.contains(selectedSubject));
          _titleController.text = widget.assessment!.title;
          _instructionsController.text = widget.assessment!.instructions ?? '';
        });
      } else {
        setState(() {
          selectedSubject = _subjectYears.firstOrNull;
        });
      }
    } catch (e) {
      _handleError('Error loading data: ${e.toString()}');
    }
  }

  void _handleError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        createSlideRoute(
          AssessmentTakersPage(
              assessment: widget.assessment, title: 'Assignment Takers'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _instructionsController.dispose();
    super.dispose();
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
                _buildTitleField(),
                const SizedBox(height: 25),
                _buildSubjectField(),
                const SizedBox(height: 25),
                _buildInstructionsField(),
                const SizedBox(height: 25),
                _buildAssignmentTypeField(),
                const SizedBox(height: 25),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
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
      onSaved: (value) {
        setState(() {
          title = value;
        });
      },
    );
  }

  Widget _buildSubjectField() {
    return DropdownButtonFormField<SubjectYear?>(
      value: _subjectYears.firstWhere(
        (subjectYear) => subjectYear.id == selectedSubject!.id,
        orElse: () => _subjectYears.first,
      ),
      items: _subjectYears.map((SubjectYear? subjectYear) {
        return DropdownMenuItem<SubjectYear?>(
          value: subjectYear,
          child: Text(subjectYear?.subjectName?.title() ?? ''),
        );
      }).toList(),
      onChanged: (SubjectYear? newValue) {
        setState(() {
          selectedSubject = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Subject',
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
      validator: (value) {
        if (value == null) {
          return 'Please select a subject';
        }
        return null;
      },
    );
  }

  Widget _buildAssignmentTypeField() {
    return DropdownButtonFormField<AssignmentType>(
      value: AssignmentType.inApp,
      items: AssignmentType.values.map((AssignmentType assignmentType) {
        return DropdownMenuItem<AssignmentType>(
          value: assignmentType,
          child: Text(assignmentType.displayName),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedType = newValue!;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Select Type',
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
      validator: (value) {
        if (value == null) {
          return 'Please select a type';
        }
        return null;
      },
    );
  }

  Widget _buildInstructionsField() {
    return TextFormField(
      controller: _instructionsController,
      maxLength: 30,
      decoration: const InputDecoration(
        labelText: 'Instructions',
      ),
      onSaved: (value) {
        instructions = value;
      },
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: _validateAndSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        selectedType == AssignmentType.inApp ? "Next" : "Send",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
