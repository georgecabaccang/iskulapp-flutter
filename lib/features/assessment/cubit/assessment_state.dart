import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_erp/enums/action_type.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/assessment_taker.dart';

part 'assessment_state.freezed.dart';

enum AssessmentStateStatus { initial, staging, success, failure }

@freezed
class AssessmentState with _$AssessmentState {
  const factory AssessmentState({
    required Assessment assessment,
    required ActionType actionType,
    @Default([]) List<AssessmentTaker> assessmentTakers,
    @Default([]) List<AssessmentTaker> assessmentTakersForRemoval,
    @Default(AssessmentStateStatus.initial) AssessmentStateStatus status,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AssessmentState;

  factory AssessmentState.initial({
    required AuthenticatedUser authUser,
    required AssessmentType assessmentTypeOnCreate,
    Assessment? existingAssessment,
  }) {
    return AssessmentState(
      assessment: existingAssessment ??
          Assessment.initialize(
            preparedById: getTeacherId(authUser),
            assessmentType: assessmentTypeOnCreate,
          ),
      actionType:
          existingAssessment != null ? ActionType.update : ActionType.create,
    );
  }
}
