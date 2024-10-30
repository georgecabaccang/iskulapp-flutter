import 'dart:ui';

import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';

import '../test_db.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  setUp(() async {
    await openTestDatabase();
  });

  group('AssessmentService', () {
    final AssessmentCreateDTO assessmentCreateDTO = AssessmentCreateDTO(
      assessmentType: AssessmentType.assignment,
      preparedById: '1',
      title: 'Test Title',
      totalQuestions: 20,
      randomizeSequence: false,
      startTime: DateTime.now(),
      deadLine: DateTime.now(),
      durationMinutes: 20,
    );
    final AssessmentTakerCreateDTOBuilder assessmentTakerCreateDTOBuilder =
        AssessmentTakerCreateDTOBuilder();
    assessmentTakerCreateDTOBuilder.sectionId = '1';
    assessmentTakerCreateDTOBuilder.subjectYearId = '1';

    test(
        'assessment service creates record for assessments and assessment_takers table',
        () async {
      final assessmentService = AssessmentService(database: testDB);
      final (success, (resultAssessment, resultTaker)) =
          await assessmentService.create(
              assessmentDTO: assessmentCreateDTO,
              assessmentTakerDTOBuilder: assessmentTakerCreateDTOBuilder);
      expect(success, isTrue);

      // Check if the assessment record is created
      expect(resultAssessment.first['id'], isNotNull);
      expect(resultAssessment.first['prepared_by'],
          equals(assessmentCreateDTO.preparedById));
      expect(resultAssessment.first['assessment_type'],
          equals(assessmentCreateDTO.assessmentType.value));
      expect(
          resultAssessment.first['title'], equals(assessmentCreateDTO.title));
      expect(resultAssessment.first['total_questions'],
          equals(assessmentCreateDTO.totalQuestions));
      expect(resultAssessment.first['start_time'],
          equals(assessmentCreateDTO.startTime.toIso8601String()));
      expect(resultAssessment.first['dead_line'],
          equals(assessmentCreateDTO.deadLine.toIso8601String()));
      expect(resultAssessment.first['duration_mins'],
          equals(assessmentCreateDTO.durationMinutes));
      expect(resultAssessment.first['status'],
          equals(assessmentCreateDTO.status.value));

      // Check if the assessment_takers record is created
      expect(resultTaker.first['id'], isNotNull);
      expect(resultTaker.first['assessment_id'],
          equals(resultAssessment.first['id']));
      expect(resultTaker.first['subject_year_id'],
          equals(assessmentTakerCreateDTOBuilder.subjectYearId));
      expect(resultTaker.first['section_id'],
          equals(assessmentTakerCreateDTOBuilder.sectionId));
    });
  });
}
