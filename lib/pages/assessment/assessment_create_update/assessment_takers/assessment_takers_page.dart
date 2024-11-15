import 'package:flutter/material.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/assessment_takers_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssessmentTakersPage extends StatelessWidget {
  const AssessmentTakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AssessmentCubit>().state;

    return DefaultLayout(
      title:
          '${state.actionType.displayName} ${state.assessment.assessmentType.displayName} Takers',
      content: [
        AssessmentTakersForm(),
      ],
    );
  }
}
