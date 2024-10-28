import 'package:flutter/material.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/question_builder_page.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/form_fields/number_input.dart';
import 'package:school_erp/pages/common_widgets/form_fields/datetime_picker.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/pages/common_widgets/form_fields/labeled_dropdown.dart';

class QuestionSetupPage extends StatelessWidget {
  final AssessmentCreateDTOBuilder assessmentCreateDTOBuilder;

  const QuestionSetupPage(this.assessmentCreateDTOBuilder, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Assignment Setup',
        content: [FormContent(assessmentCreateDTOBuilder)]);
  }
}

class FormContent extends StatefulWidget {
  final AssessmentCreateDTOBuilder assessmentCreateDTOBuilder;

  const FormContent(this.assessmentCreateDTOBuilder, {super.key});

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _formKey = GlobalKey<FormState>();

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
              initialValue: DateTime.now(),
              onSaved: (newValue) {
                widget.assessmentCreateDTOBuilder.startTime = newValue!;
              },
            ),
            const SizedBox(height: 16),
            DateTimePickerFormField(
              label: 'Select question close time:',
              initialValue: DateTime.now(),
              onSaved: (newValue) {
                widget.assessmentCreateDTOBuilder.deadLine = newValue!;
              },
            ),
            const SizedBox(height: 16),
            NumberInputFormField(
              label: 'No. of   Questions',
              initialValue: 20,
              onSaved: (value) {
                widget.assessmentCreateDTOBuilder.totalQuestions = value!;
              },
            ),
            const SizedBox(height: 16),
            LabeledDropdownFormField<bool>(
              label: "Select Randomness",
              dropdownItems: const {"True": true, "False": false},
              initialValue: false,
              onSaved: (value) {
                widget.assessmentCreateDTOBuilder.randomizeSequence = value!;
              },
            ),
            const SizedBox(height: 32),
            DefaultButton(
              onPressed: () =>
                  _onNextPressed(context, widget.assessmentCreateDTOBuilder),
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed(
      BuildContext context, AssessmentCreateDTOBuilder formData) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final assessmentCreateDTO = widget.assessmentCreateDTOBuilder.build();

      await AssessmentService.create(db: db, data: assessmentCreateDTO);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        EnterExitRoute(
          exitPage: widget,
          enterPage: const QuestionBuilderPage(),
        ),
      );
    }
  }
}
