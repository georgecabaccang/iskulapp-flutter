import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/enums/action_type.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/repositories/repositories.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final AssessmentService _assessmentService;

  AssessmentCubit({
    required AssessmentService assessmentService,
    required AssessmentType assessmentTypeOnCreate,
    required String teacherId,
    Assessment? assessment,
  })  : _assessmentService = assessmentService,
        super(AssessmentState.initial(
          teacherId: teacherId,
          assessmentTypeOnCreate: assessmentTypeOnCreate,
          existingAssessment: assessment,
        )) {
    _loadAssessmentTakers();
  }

  void updateAssessment(Assessment assessment) {
    emit(
      state.copyWith(
        assessment: assessment,
        status: AssessmentStateStatus.staging,
      ),
    );
  }

  void addAssessmentTaker() {
    var assessmentTaker = AssessmentTaker.initialize();
    emit(
      state.copyWith(
        assessmentTakers: [...state.assessmentTakers, assessmentTaker],
        status: AssessmentStateStatus.staging,
      ),
    );
  }

  void updateAssessmentTaker(int index, AssessmentTaker assessmentTaker) {
    final updatedTakers = List<AssessmentTaker>.from(state.assessmentTakers);
    updatedTakers[index] = assessmentTaker;

    emit(
      state.copyWith(
          assessmentTakers: updatedTakers,
          status: AssessmentStateStatus.staging),
    );
  }

  void updateAssessmentTakersForRemoval(int index) {
    if (index < 0 || index >= state.assessmentTakers.length) {
      return;
    }

    final assessmentTakerToRemove = state.assessmentTakers[index];

    final updatedTakersForRemoval =
        List<AssessmentTaker>.from(state.assessmentTakersForRemoval)
          ..add(assessmentTakerToRemove);

    final updatedTakers = List<AssessmentTaker>.from(state.assessmentTakers)
      ..removeAt(index);

    emit(
      state.copyWith(
        assessmentTakers: updatedTakers,
        assessmentTakersForRemoval: updatedTakersForRemoval,
        status: AssessmentStateStatus.staging,
      ),
    );
  }

  void save() async {
    if (state.status == AssessmentStateStatus.staging) {
      if (state.assessment.id == null &&
          state.actionType == ActionType.update) {
        throw StateError('Assessment ID is required for update operation');
      }

      if (state.assessmentTakers.isEmpty) {
        throw StateError('At least one assessment taker is required');
      }

      // Validate each assessment taker
      for (var taker in state.assessmentTakers) {
        if (taker.sectionId == null) {
          throw StateError('Section ID is required for all assessment takers');
        }
      }
      try {
        switch (state.actionType) {
          case ActionType.create:
            await _assessmentService.create(
              assessment: state.assessment,
              assessmentTakers: state.assessmentTakers,
            );
            emit(state.copyWith(
              status: AssessmentStateStatus.success,
            ));
            break;

          case ActionType.update:
            await _assessmentService.update(
              assessment: state.assessment,
              assessmentTakers: state.assessmentTakers,
              assessmentTakersForRemoval: state.assessmentTakersForRemoval,
            );
            emit(state.copyWith(
              status: AssessmentStateStatus.success,
            ));
            break;

          default:
            emit(state.copyWith(
              status: AssessmentStateStatus.failure,
              isLoading: false,
              errorMessage: 'Invalid action type',
            ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: AssessmentStateStatus.failure,
          isLoading: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<void> _loadAssessmentTakers() async {
    try {
      /// load assessment takers when updating
      if (state.actionType == ActionType.update &&
          state.assessment.id != null) {
        final assessmentTakers = await assessmentTakerRepository
            .getByAssessment(state.assessment.id!);
        emit(state.copyWith(
          assessmentTakers: assessmentTakers,
          isLoading: false,
        ));
      } else {
        // a default assessment taker for create mode
        var defaultTaker = AssessmentTaker.initialize();
        emit(state.copyWith(
          assessmentTakers: [defaultTaker],
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AssessmentStateStatus.failure,
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
