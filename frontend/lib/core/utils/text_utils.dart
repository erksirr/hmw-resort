extension TextLanguageX on String {
  bool get isEnglish {
    return RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(this);
  }
}