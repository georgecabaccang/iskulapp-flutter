import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/models/assessment.dart';

class AssessmentSetupPage extends StatelessWidget {
  final AssessmentType assessmentTypeOnCreate;
  final Assessment? assessment;

  const AssessmentSetupPage({
    required this.assessmentTypeOnCreate,
    this.assessment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final authUser = getAuthUser(authState);

    return BlocProvider<AssessmentCubit>(
      create: (_) {
        final assessmentService = AssessmentService();
        return AssessmentCubit(
          assessmentService: assessmentService,
          assessmentTypeOnCreate: assessmentTypeOnCreate,
          authUser: authUser,
          assessment: assessment,
        );
      },
      child: AssessmentSetupView(),
    );
  }
}

class AssessmentSetupView extends StatelessWidget {
  const AssessmentSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AssessmentCubit>().state;
    return DefaultLayout(
      title:
          '${state.actionType.displayName} ${state.assessment.assessmentType.displayName}',
      content: [
        AssessmentSetupForm(),
      ],
    );
  }
}
