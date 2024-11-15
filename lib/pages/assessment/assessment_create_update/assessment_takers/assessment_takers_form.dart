import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_question_setup/assessment_question_setup_page.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/widgets/assessment_section_row.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/theme/colors.dart';

class AssessmentTakersForm extends StatefulWidget {
  const AssessmentTakersForm({super.key});

  _AssessmentTakersFormState createState() => _AssessmentTakersFormState();
}

class _AssessmentTakersFormState extends State<AssessmentTakersForm> {
  List<Section> activeSections = [];

  @override
  void initState() {
    super.initState();
    _loadSectionSelection();
  }

  void _loadSectionSelection() async {
    final sections = await teacherRepository.activeSections();
    setState(() {
      activeSections = sections;
    });
  }

  void _onNextPressed(BuildContext context, AssessmentState state) async {
    if (_validateTakers(state)) {
      Navigator.of(context).push(
        createSlideRoute(
          BlocProvider<AssessmentCubit>.value(
            value: BlocProvider.of<AssessmentCubit>(context),
            child: const AssessmentQuestionSetupPage(),
          ),
        ),
      );
    }
  }

  bool _validateTakers(AssessmentState state) {
    for (final taker in state.assessmentTakers) {
      if (taker.sectionId == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a section for all assessment takers'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.separated(
                      itemCount: state.assessmentTakers.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 25),
                      itemBuilder: (context, idx) {
                        final taker = state.assessmentTakers[idx];
                        return AssessmentSectionRow(
                          index: idx,
                          key: ValueKey(taker.id),
                          sections: activeSections,
                          assessmentTaker: taker,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _onNextPressed(context, state),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: Size(double.infinity,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
