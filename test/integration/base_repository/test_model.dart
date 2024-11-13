import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/models/base_model/base_model.dart';

class TestModel extends BaseModel {
  final String authorId;
  final String title;
  final int pages;

  TestModel(
      {super.id,
      required this.authorId,
      required this.title,
      required this.pages});

  factory TestModel.initialize() {
    return TestModel(
      authorId: '',
      title: '',
      pages: 0,
    );
  }

  @override
  Map<String, dynamic> get tableData {
    return {
      'author_id': authorId,
      'id': id,
      'title': title,
      'pages': pages,
    };
  }

  factory TestModel.fromRow(sqlite.Row row) {
    return TestModel(
      id: row['id'],
      authorId: row['author_id'],
      title: row['title'],
      pages: row['pages'],
    );
  }

  TestModel copyWith({String? authorId, String? title, int? pages}) {
    return TestModel(
      id: id,
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      pages: pages ?? this.pages,
    );
  }
}
