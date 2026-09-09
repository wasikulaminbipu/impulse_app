/// Extension on non-nullable [String] to provide bilingual resolution between English and Bengali.
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

/// Extension on nullable [String] providing safe bilingual resolution.
extension BilingualStringNullable on String? {
  /// Resolves the nullable string based on the language code.
  /// If language is 'bn', returns [bnText] if non-empty, otherwise falls back to this string or empty.
  String resolve(String? bnText, String lang) {
    if (lang == 'bn') {
      return (bnText != null && bnText.isNotEmpty) ? bnText : (this ?? '');
    }
    return this ?? '';
  }
}

/// Convenience extension on [String] representing language codes.
extension LangHelper on String {
  /// Returns `true` if this language code represents Bengali (`'bn'`).
  bool get isBn => this == 'bn';
}
