import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/constants/assessments/form_labels.dart' as form;
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;
import 'package:school_erp/constants/common/validation.dart'
    as common_validation;
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/question_builder_page.dart';
import 'package:school_erp/pages/common_widgets/form_fields/labeled_dropdown.dart';
import 'package:school_erp/pages/common_widgets/form_fields/number_input.dart';
import 'package:school_erp/theme/colors.dart';

class AssessmentQuestionSetupForm extends StatefulWidget {
  const AssessmentQuestionSetupForm({super.key});

  _AssessmentQuestionSetupFormState createState() =>
      _AssessmentQuestionSetupFormState();
}

class _AssessmentQuestionSetupFormState
    extends State<AssessmentQuestionSetupForm> {
  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit(context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final assessmentCubit = BlocProvider.of<AssessmentCubit>(context);
      assessmentCubit.save();

      Navigator.of(context).push(
        createSlideRoute(
          QuestionBuilderPage(),
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
                    const SizedBox(height: 25),
                    LabeledDropdownFormField<bool>(
                      label: form.aiGeneratedLabel,
                      dropdownItems: const {"True": true, "False": false},
                      initialValue: false,
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 25),
                    NumberInputFormField(
                        label: form.noOfQuestionsLabel,
                        initialValue: state.assessment.totalQuestions,
                        helperText: form.noOfQuestionsLabel,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return validation.emptyQuestionCount;
                          }
                          final number = int.tryParse(value);
                          if (number == null) {
                            return validation.emptyQuestionCount;
                          }
                          if (number <= 0) {
                            return common_validation.positiveInt;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<AssessmentCubit>().updateAssessment(
                                state.assessment
                                    .copyWith(totalQuestions: value!),
                              );
                        },
                        onSaved: (value) {
                          return 5;
                        }),
                    const SizedBox(height: 25),
                    LabeledDropdownFormField<bool>(
                      label: form.randomnessLabel,
                      dropdownItems: const {"True": true, "False": false},
                      initialValue: state.assessment.randomizeSequence,
                      onSaved: (value) {
                        context.read<AssessmentCubit>().updateAssessment(
                              state.assessment
                                  .copyWith(randomizeSequence: value!),
                            );
                      },
                    ),
                    const SizedBox(height: 240),
                    _buildNextButton(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
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
