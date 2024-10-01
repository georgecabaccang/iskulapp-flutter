class FormData {
  DateTime selectedDate;
  DateTime selectedCloseDate;
  int totalQuestionCount;
  bool isRandom;

  FormData({
    DateTime? selectedDate,
    DateTime? selectedCloseDate,
    this.totalQuestionCount = 20,
    this.isRandom = true,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        selectedCloseDate =
            selectedCloseDate ?? DateTime.now().add(const Duration(hours: 2));
}
