import 'package:flutter_test/flutter_test.dart';
import 'package:school_erp/dtos/assessment_dto.dart';
import 'package:school_erp/dtos/assessment_taker_dto.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/assessment/assessment_service.dart';
import '../test_db.dart';

//TODO: create fixtures, some assert statements are hard coded with values, not ideal
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await openTestDatabase();
  var assessmentService = AssessmentService(testDB);

  setUp(() async {
    // clear db before running each test
    await testDB.execute('DELETE FROM assessments');
    await testDB.execute('DELETE FROM assessment_takers');
  });

  group('AssessmentService - create', () {
    late AssessmentCreateDTO validAssessmentDTO;
    late List<AssessmentTakerCreateDTO> validAssessmentTakerDTOs;

    setUp(() {
      validAssessmentDTO = AssessmentCreateDTO(
        assessmentType: AssessmentType.assignment,
        preparedById: '1',
        title: 'Test Title',
        totalQuestions: 20,
        randomizeSequence: false,
        durationMinutes: null,
      );

      final now = DateTime.now();
      validAssessmentTakerDTOs = [
        AssessmentTakerCreateDTO(
          sectionId: '1',
          subjectYearId: '1',
          startTime: now,
          deadLine: now.add(const Duration(days: 7)),
        ),
        AssessmentTakerCreateDTO(
          sectionId: '2',
          subjectYearId: '1',
          startTime: now,
          deadLine: now.add(const Duration(days: 7)),
        ),
      ];
    });

    test('successfully creates assessment with multiple takers', () async {
      final result = await assessmentService.create(
        assessmentDTO: validAssessmentDTO,
        assessmentTakerDTOs: validAssessmentTakerDTOs,
      );

      // Verify assessment
      expect(result.assessment.first['id'], isNotNull);
      expect(result.assessment.first['prepared_by'],
          validAssessmentDTO.preparedById);
      expect(result.assessment.first['assessment_type'],
          validAssessmentDTO.assessmentType.value);
      expect(result.assessment.first['title'], validAssessmentDTO.title);
      expect(result.assessment.first['total_questions'],
          validAssessmentDTO.totalQuestions);
      expect(result.assessment.first['randomize_sequence'],
          validAssessmentDTO.randomizeSequence);
      expect(result.assessment.first['duration_mins'],
          validAssessmentDTO.durationMinutes);

      // Verify takers
      expect(result.assessmentTakers.length,
          equals(validAssessmentTakerDTOs.length));
      for (var i = 0; i < result.assessmentTakers.length; i++) {
        final assessmentTaker = result.assessmentTakers[i];
        final expectedTaker = validAssessmentTakerDTOs[i];
        expect(assessmentTaker.first['id'], isNotNull);
        expect(assessmentTaker.first['assessment_id'],
            result.assessment.first['id']);
        expect(assessmentTaker.first['subject_year_id'],
            expectedTaker.subjectYearId);
        expect(assessmentTaker.first['section_id'], expectedTaker.sectionId);
        expect(assessmentTaker.first['start_time'],
            expectedTaker.startTime.toIso8601String());
        expect(assessmentTaker.first['dead_line'],
            expectedTaker.deadLine.toIso8601String());
      }

      // Verify data persistence
      final savedAssessment = await testDB.execute(
        'SELECT * FROM assessments WHERE id = ?',
        [result.assessment.first['id']],
      );
      expect(savedAssessment.rows.length, equals(1));
    });

    test('creates assessment with no takers', () async {
      final result = await assessmentService.create(
        assessmentDTO: validAssessmentDTO,
        assessmentTakerDTOs: [],
      );

      expect(result.assessment.first['id'], isNotNull);
      expect(result.assessmentTakers, isEmpty);

      // Verify no takers were created
      final savedTakers = await testDB.execute(
        'SELECT * FROM assessment_takers WHERE assessment_id = ?',
        [result.assessment.first['id']],
      );
      expect(savedTakers.rows.isEmpty, isTrue);
    });
  });

  group('AssessmentService - update', () {
    late String existingAssessmentId;
    late List<String> existingTakerIds;
    late AssessmentUpdateDTO updateDTO;
    late List<AssessmentTakerUpdateDTO> updateTakerDTOs;

    setUp(() async {
      // Create initial assessment and takers for update tests
      final assessmentDTO = AssessmentCreateDTO(
        assessmentType: AssessmentType.assignment,
        preparedById: '1',
        title: 'Original Title',
        totalQuestions: 10,
        randomizeSequence: false,
        durationMinutes: 30,
      );

      final assessmentTakerDTOs = [
        AssessmentTakerCreateDTO(
          sectionId: '1',
          subjectYearId: '1',
          startTime: DateTime.now(),
          deadLine: DateTime.now().add(const Duration(days: 7)),
        ),
        AssessmentTakerCreateDTO(
          sectionId: '2',
          subjectYearId: '1',
          startTime: DateTime.now(),
          deadLine: DateTime.now().add(const Duration(days: 7)),
        ),
      ];

      final result = await assessmentService.create(
        assessmentDTO: assessmentDTO,
        assessmentTakerDTOs: assessmentTakerDTOs,
      );

      existingAssessmentId = result.assessment.first['id'];
      existingTakerIds =
          result.assessmentTakers.map((t) => t.first['id'] as String).toList();

      updateDTO = AssessmentUpdateDTO(
        existingAssessmentId,
        title: 'Updated Title',
        totalQuestions: 15,
        randomizeSequence: true,
        durationMinutes: 45,
      );

      final updateTakerDTO1 = AssessmentTakerUpdateDTO(
        existingTakerIds.first,
        sectionId: '3',
        deadLine: DateTime.now().add(const Duration(days: 14)),
      );

      updateTakerDTOs = [
        updateTakerDTO1,
      ];
    });

    test(
        'successfully updates assessment, updates some takers and removes others',
        () async {
      final result = await assessmentService.update(
        assessmentDTO: updateDTO,
        assessmentTakerDTOs: updateTakerDTOs,
        removeAssessmentTakerIds: [existingTakerIds.last],
      );

      // Verify assessment updates
      expect(result.assessment, isNotNull);
      expect(result.assessment!.first['title'], equals(updateDTO.title));
      expect(result.assessment!.first['total_questions'],
          equals(updateDTO.totalQuestions));
      expect(result.assessment?.first['randomize_sequence'],
          equals(updateDTO.randomizeSequence!));
      expect(result.assessment!.first['duration_mins'],
          equals(updateDTO.durationMinutes));

      // Verify taker updates
      expect(result.assessmentTakers.length, equals(1));
      expect(result.assessmentTakers.first.first['section_id'], equals('3'));
      expect(result.assessmentTakers.first.first['id'],
          equals(existingTakerIds.first));

      // Verify taker removal
      expect(result.removedAssessmentTakers, isNotNull);
      expect(result.removedAssessmentTakers!.rows.length, equals(1));
      expect(result.removedAssessmentTakers!.first['id'],
          equals(existingTakerIds.last));
    });

    test('successfully removes all assessment takers', () async {
      final result = await assessmentService.update(
        removeAssessmentTakerIds: existingTakerIds,
      );

      expect(result.removedAssessmentTakers, isNotNull);
      expect(result.removedAssessmentTakers!.rows.length, equals(2));

      // Verify all takers were removed
      final remainingTakers = await testDB.execute(
        'SELECT * FROM assessment_takers WHERE assessment_id = ?',
        [existingAssessmentId],
      );
      expect(remainingTakers.rows.isEmpty, isTrue);
    });

    test('handles partial updates correctly', () async {
      final result = await assessmentService.update(
        assessmentDTO: AssessmentUpdateDTO(
          existingAssessmentId,
          title: 'Only Title Updated',
        ),
      );

      expect(result.assessment!.first['title'], equals('Only Title Updated'));
      // Other fields should remain unchanged
      expect(result.assessment!.first['total_questions'], equals(10));
      expect(result.assessment!.first['randomize_sequence'], equals(0));
      expect(result.assessment!.first['duration_mins'], equals(30));

      // No takers should have been modified
      expect(result.assessmentTakers, isEmpty);
    });

    test('throws error when trying to update and remove same taker', () async {
      expect(
        () => assessmentService.update(
          assessmentTakerDTOs: [
            AssessmentTakerUpdateDTO(
              existingTakerIds.first,
              sectionId: '3',
            ),
          ],
          removeAssessmentTakerIds: [existingTakerIds.first],
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('handles creation of new takers during update', () async {
      final now = DateTime.now();
      final result = await assessmentService.update(
        assessmentTakerDTOs: [
          AssessmentTakerUpdateDTO(
            null, // New taker
            sectionId: '3',
            subjectYearId: '1',
            startTime: now,
            deadLine: now.add(const Duration(days: 7)),
          ),
        ],
      );

      expect(result.assessmentTakers.length, equals(1));
      expect(result.assessmentTakers.first.first['section_id'], equals('3'));
    });
  });
}
