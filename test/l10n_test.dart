import 'package:flutter_test/flutter_test.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';

void main() {
  group('localizations', () {
    test('every supported locale resolves and has core strings', () {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = lookupAppLocalizations(locale);
        expect(
          l10n.appTitle.trim(),
          isNotEmpty,
          reason: 'appTitle missing for $locale',
        );
        expect(
          l10n.loginButton.trim(),
          isNotEmpty,
          reason: 'loginButton missing for $locale',
        );
      }
    });

    test('all nine app locales are supported', () {
      final codes = AppLocalizations.supportedLocales
          .map((locale) => locale.languageCode)
          .toSet();
      expect(
        codes,
        containsAll({'en', 'sr', 'mk', 'de', 'el', 'ro', 'rom', 'ar', 'tr'}),
      );
    });
  });
}
