import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment_taker/assessment_taker_create_dto.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_add_page/widgets/add_assignment_form.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/question_builder_page.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/form_fields/number_input.dart';
import 'package:school_erp/pages/common_widgets/form_fields/datetime_picker.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/pages/common_widgets/form_fields/labeled_dropdown.dart';

class QuestionSetupPage extends StatelessWidget {
  final GlobalKey<AddAssignmentFormState> addAssignmentKey;
  const QuestionSetupPage({required this.addAssignmentKey, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Assignment Setup', content: [FormContent(addAssignmentKey)]);
  }
}

class FormContent extends StatefulWidget {
  final GlobalKey<AddAssignmentFormState> addAssignmentKey;
  const FormContent(this.addAssignmentKey, {super.key});

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _formKey = GlobalKey<FormState>();
  DateTime startTime = DateTime.now().add(Duration(days: 1));
  DateTime deadLine = DateTime.now().add(Duration(days: 3));
  int totalQuestions = 20;
  bool randomizeSequence = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateTimePickerFormField(
              label: 'Select quiz time',
              initialValue: startTime,
              onSaved: (newValue) {
                startTime = newValue!;
              },
            ),
            const SizedBox(height: 16),
            DateTimePickerFormField(
              label: 'Select question close time:',
              initialValue: deadLine,
              onSaved: (newValue) {
                deadLine = newValue!;
              },
            ),
            const SizedBox(height: 16),
            NumberInputFormField(
              label: 'No. of   Questions',
              initialValue: 20,
              onSaved: (value) {
                totalQuestions = value!;
              },
            ),
            const SizedBox(height: 16),
            LabeledDropdownFormField<bool>(
              label: "Select Randomness",
              dropdownItems: const {"True": true, "False": false},
              initialValue: false,
              onSaved: (value) {
                randomizeSequence = value!;
              },
            ),
            const SizedBox(height: 32),
            DefaultButton(
              onPressed: () => _onNextPressed(context),
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final assessmentService = AssessmentService(db);
      assessmentService.create(
        assessmentCreateDTO: _createAssessmentCreateDTO(),
        assessmentTakerCreateDTO: _createAssessmentTakerCreateDTO(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        createSlideRoute(
          const QuestionBuilderPage(),
        ),
      );
    }
  }

  AssessmentCreateDTO _createAssessmentCreateDTO() {
    final authState = context.read<AuthBloc>().state;
    final teacherId = getTeacherId(authState);

    final assessmentCreateDTO = AssessmentCreateDTO(
      assessmentType: AssessmentType.assignment,
      preparedById: teacherId,
      title: widget.addAssignmentKey.currentState!.title!,
      totalQuestions: totalQuestions,
      randomizeSequence: randomizeSequence,
      startTime: startTime,
      deadLine: deadLine,
    );
    return assessmentCreateDTO;
  }

  AssessmentTakerCreateDTO _createAssessmentTakerCreateDTO() {
    final assessmentTakerCreateDTO = AssessmentTakerCreateDTO(
      subjectYearId: widget.addAssignmentKey.currentState!.selectedSubject!.id,
      sectionId: widget.addAssignmentKey.currentState!.selectedSection!.id,
    );
    return assessmentTakerCreateDTO;
  }
}
