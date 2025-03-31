int extractNumber(String text) {
  String numberString = text.split(RegExp(r'\D+')).first;
  return int.tryParse(numberString) ?? 0;
}
