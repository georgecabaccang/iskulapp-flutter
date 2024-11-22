abstract class BaseModel {
  final String? id;

  const BaseModel({this.id});

  /// Returns a map of field names to values for database storage.
  /// Keys should match database column names.
  ///
  /// Example:
  /// ```dart
  /// {
  ///   'name': name,
  ///   'age': age,
  ///   'created_at': createdAt.toIso8601String(),
  /// }
  /// ```
  Map<String, dynamic> get tableData;
}
