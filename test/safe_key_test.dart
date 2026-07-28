import 'package:flutter_test/flutter_test.dart';
import 'package:when_scars_become_art/utils/safe_key.dart';

void main() {
  group('safeKey', () {
    test('keeps allowed characters unchanged', () {
      expect(safeKey('User_1-x'), 'User_1-x');
    });

    test('replaces RTDB-illegal characters', () {
      expect(safeKey('a.b#c\$d[e]f/g'), 'a_b_c_d_e_f_g');
    });

    test('sanitizes email addresses', () {
      expect(safeKey('user@example.com'), 'user_example_com');
    });

    test('falls back for empty input', () {
      expect(safeKey(''), 'user');
    });

    test('is idempotent', () {
      const input = 'Some User! With ümlauts';
      expect(safeKey(safeKey(input)), safeKey(input));
    });
  });
}
