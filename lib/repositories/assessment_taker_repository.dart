import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/models/tables/assessment_takers_table.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';

class AssessmentTakerRepository extends BaseCrudRepository<AssessmentTaker> {
  AssessmentTakerRepository({super.database})
      : super(table: assessmentTakersTable, fromRow: AssessmentTaker.fromRow);
}
