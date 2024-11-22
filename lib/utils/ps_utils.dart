/// there is no boolean type in powersync schema, thus need to convert bool to int
int boolAsInt(bool? value) {
  if (value == null) {
    return 0;
  }
  return value ? 1 : 0;
}
