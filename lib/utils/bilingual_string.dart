extension BilingualString on String {
  /// Resolves the string based on the language code.
  /// If language is 'bn', returns [bnText] (falling back to this string if null).
  /// Otherwise, returns this string (or empty if null).
  String resolve(String? bnText, String lang) {
    if (lang == 'bn') {
      return (bnText != null && bnText.isNotEmpty) ? bnText : this;
    }
    return this;
  }
}

extension BilingualStringNullable on String? {
  String resolve(String? bnText, String lang) {
    if (lang == 'bn') {
      return (bnText != null && bnText.isNotEmpty) ? bnText : (this ?? '');
    }
    return this ?? '';
  }
}

extension LangHelper on String {
  bool get isBn => this == 'bn';
}
