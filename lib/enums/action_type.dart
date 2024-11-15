enum ActionType {
  create('create', 'Create'),
  update('update', 'Update'),
  delete('delete', 'Delete');

  final String value;
  final String displayName;

  const ActionType(this.value, this.displayName);

  static ActionType fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => throw ArgumentError('Invalid ActionType value: $value'),
    );
  }

  static ActionType fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () =>
          throw ArgumentError('Invalid ActionType display name: $displayName'),
    );
  }
}
