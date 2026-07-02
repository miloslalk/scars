/// Sanitizes a string for use as a Firebase RTDB key.
///
/// Replaces characters outside `[A-Za-z0-9_-]` with `_`. Returns `'user'`
/// for empty input so callers never end up writing to an empty key.
String safeKey(String value) {
  if (value.isEmpty) return 'user';
  final buffer = StringBuffer();
  for (final codeUnit in value.codeUnits) {
    final isValid =
        (codeUnit >= 48 && codeUnit <= 57) ||
        (codeUnit >= 65 && codeUnit <= 90) ||
        (codeUnit >= 97 && codeUnit <= 122) ||
        codeUnit == 45 ||
        codeUnit == 95;
    buffer.write(isValid ? String.fromCharCode(codeUnit) : '_');
  }
  return buffer.toString();
}
