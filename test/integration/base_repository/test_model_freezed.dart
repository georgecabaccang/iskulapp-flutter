import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/models/base_model/base_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_model_freezed.freezed.dart';

// equivalent implementation of TestModelFreezed but using freezed
@freezed
class TestModelFreezed extends BaseModel with _$TestModelFreezed {
  const TestModelFreezed._(); // Private constructor needed to extend BaseModel

  const factory TestModelFreezed({
    @Default(null) String? id,
    @Default('') String authorId,
    @Default('') String title,
    @Default(0) int pages,
  }) = _TestModelFreezed;

  factory TestModelFreezed.fromRow(sqlite.Row row) => TestModelFreezed(
        id: row['id'] as String?,
        authorId: row['author_id'] as String,
        title: row['title'] as String,
        pages: row['pages'] as int,
      );

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'author_id': authorId,
        'title': title,
        'pages': pages,
      };
}
