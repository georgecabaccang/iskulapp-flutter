import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/question_builder_page.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/fade_page_transition.dart';
import 'package:school_erp/pages/common_widgets/form_fields/number_input.dart';
import 'package:school_erp/pages/common_widgets/rounded_container.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/common_widgets/form_fields/datetime_picker.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/pages/common_widgets/form_fields/labeled_dropdown.dart';
import 'package:school_erp/theme/colors.dart';
import 'form_data.dart';

class QuestionSetupPage extends StatelessWidget {
  const QuestionSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Assignment",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const Material(
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RoundedContainer(
                  borderRadius: 30.0,
                  child: FormContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormContent extends StatefulWidget {
  const FormContent({super.key});

  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _formKey = GlobalKey<FormState>();
  late FormData formData;

  @override
  void initState() {
    super.initState();
    formData = FormData();
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
              initialValue: formData.selectedDate,
              onSaved: (newValue) {
                formData.selectedDate = newValue!;
              },
            ),
            const SizedBox(height: 16),
            DateTimePickerFormField(
              label: 'Select question close time:',
              initialValue: formData.selectedCloseDate,
              onSaved: (newValue) {
                formData.selectedCloseDate = newValue!;
              },
            ),
            const SizedBox(height: 16),
            NumberInputFormField(
              label: 'No. of   Questions',
              initialValue: formData.totalQuestionCount,
              onSaved: (value) {
                formData.totalQuestionCount = value!;
              },
            ),
            const SizedBox(height: 16),
            LabeledDropdownFormField<bool>(
              label: "Select Randomness",
              dropdownItems: const {"True": true, "False": false},
              initialValue: formData.isRandom,
              onChanged: (value) {
                formData.isRandom = value!;
              },
            ),
            const SizedBox(height: 32),
            DefaultButton(
              onPressed: () => _onNextPressed(context, formData),
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed(BuildContext context, FormData formData) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // place holder for do something with form data
      print(formData.selectedDate);
      print(formData.selectedCloseDate);
      print(formData.totalQuestionCount);
      print(formData.isRandom);

      Navigator.of(context).push(
        FadePageRoute(
          page: const QuestionBuilderPage(),
        ),
      );
    }
  }
}
