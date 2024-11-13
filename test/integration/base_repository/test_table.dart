import 'package:powersync/powersync.dart';

const testModelsTable = Table('test_models', [
  Column.text('author_id'),
  Column.text('title'),
  Column.integer('pages'),
  Column.text('created_at'),
  Column.text('updated_at'),
]);

Schema testSchema = const Schema(
  [
    testModelsTable,
  ],
);
