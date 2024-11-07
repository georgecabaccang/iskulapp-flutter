abstract class CreateDTO {}

abstract class UpdateDTO {
  final String? id;

  const UpdateDTO(this.id);
}
