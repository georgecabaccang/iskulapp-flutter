import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/enums/assignment_type.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/assessment_takers_page.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class AssessmentSetupForm extends StatefulWidget {
  const AssessmentSetupForm({super.key});

  @override
  _AssessmentSetupFormState createState() => _AssessmentSetupFormState();
}

class _AssessmentSetupFormState extends State<AssessmentSetupForm> {
  final _formKey = GlobalKey<FormState>();
  List<SubjectYear> activeSubjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjectSelection();
  }

  void _loadSubjectSelection() async {
    final subjects = await teacherRepository.activeSubjects();
    setState(() {
      activeSubjects = subjects;
    });
  }

  void _validateAndSubmit(context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //TODO: temporary implementation, must figure out / have an option to create the route below the widget tree (not sure as to why it cant atm)
      Navigator.of(context).push(
        createSlideRoute(
          BlocProvider<AssessmentCubit>.value(
            value: BlocProvider.of<AssessmentCubit>(context),
            child: const AssessmentTakersPage(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
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
                    _buildTitleField(context, state),
                    const SizedBox(height: 25),
                    _buildSubjectField(context, state),
                    const SizedBox(height: 25),
                    _buildInstructionsField(context, state),
                    const SizedBox(height: 25),
                    _buildAssignmentTypeField(context, state),
                    const SizedBox(height: 25),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    _buildNextButton(context, state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleField(BuildContext context, AssessmentState state) {
    return TextFormField(
      initialValue: state.assessment.title,
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
      onChanged: (value) {
        context.read<AssessmentCubit>().updateAssessment(
              state.assessment.copyWith(title: value),
            );
      },
    );
  }

  Widget _buildSubjectField(BuildContext context, AssessmentState state) {
    final selectedSubjectYear = state.assessment.subjectYearId == null
        ? null
        : activeSubjects.firstWhere(
            (subjectYear) => subjectYear.id == state.assessment.subjectYearId,
          );

    return DropdownButtonFormField<SubjectYear?>(
      value: selectedSubjectYear,
      items: activeSubjects.map((SubjectYear? subjectYear) {
        return DropdownMenuItem<SubjectYear?>(
          value: subjectYear,
          child: Text(subjectYear?.subjectName?.title() ?? ''),
        );
      }).toList(),
      onChanged: (SubjectYear? newValue) {
        context.read<AssessmentCubit>().updateAssessment(
              state.assessment.copyWith(
                subjectYearId: newValue?.id ?? '',
              ),
            );
      },
      decoration: const InputDecoration(
        labelText: 'Subject',
        border: UnderlineInputBorder(
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

  Widget _buildAssignmentTypeField(
      BuildContext context, AssessmentState state) {
    return DropdownButtonFormField<AssignmentType>(
      value: AssignmentType.inApp,
      items: AssignmentType.values.map((AssignmentType assignmentType) {
        return DropdownMenuItem<AssignmentType>(
          value: assignmentType,
          child: Text(assignmentType.displayName),
        );
      }).toList(),
      onChanged: (newValue) {},
      decoration: const InputDecoration(
        labelText: 'Select Type',
        border: UnderlineInputBorder(
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

  Widget _buildInstructionsField(BuildContext context, AssessmentState state) {
    return TextFormField(
      initialValue: state.assessment.instructions,
      maxLength: 30,
      decoration: const InputDecoration(
        labelText: 'Instructions',
      ),
      onSaved: (value) {
        context
            .read<AssessmentCubit>()
            .updateAssessment(state.assessment.copyWith(instructions: value!));
      },
    );
  }

  Widget _buildNextButton(BuildContext context, AssessmentState state) {
    return ElevatedButton(
      onPressed: () => _validateAndSubmit(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        "Next",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
