# Repository Guidelines

## Project Structure & Module Organization

This repository is a Flutter app with Firebase backend pieces. Main Dart code lives in `lib/`: screens are in `lib/screens/`, reusable UI in `lib/widgets/`, services in `lib/services/`, utilities in `lib/utils/`, and generated localization output in `lib/gen_l10n/`. Source localization files are in `l10n/*.arb`; update these rather than editing generated files directly. Static media and SVGs are under `assets/images/`, `assets/images/flags/`, `assets/monster/`, `assets/music/`, and `assets/messages/`. Platform projects are in `android/` and `ios/`. Firebase functions live in `functions/index.js`, with Firebase rules in `database.rules.json` and `storage.rules`.

## Build, Test, and Development Commands

- `flutter pub get`: install Flutter dependencies from `pubspec.yaml`.
- `flutter run`: run the app on the selected emulator, simulator, or device.
- `dart format lib test`: format Dart sources; omit `test` if that directory does not exist.
- `flutter analyze`: run static analysis using `flutter_lints`.
- `flutter test`: run Flutter widget/unit tests when a `test/` directory is present.
- `flutter gen-l10n`: regenerate `lib/gen_l10n/` after editing `l10n/*.arb`.
- `cd functions && npm install`: install Cloud Functions dependencies for Node 20.

## Coding Style & Naming Conventions

Follow standard Flutter/Dart style with 2-space indentation, trailing commas for readable multi-line widget trees, and `dart format` before review. Use `PascalCase` for classes and widgets, `camelCase` for variables, methods, and providers, and `snake_case.dart` for file names. Keep screens focused on presentation and put Firebase, notification, audio, and manifest logic in services.

## Testing Guidelines

Add Flutter tests under `test/` using `_test.dart` file names, such as `home_page_test.dart`. Prefer small widget tests for screens and unit tests for services or utilities with isolated dependencies. The current repo also contains `ios/RunnerTests/RunnerTests.swift`; keep platform-specific tests in the platform project. Run `flutter analyze` and relevant tests before opening a PR.

## Commit & Pull Request Guidelines

Recent history uses short, lower-case summaries such as `refactor`, `notifications`, and feature notes. Keep commit subjects concise and imperative when possible, for example `add localized care corner copy`. Pull requests should include a brief description, testing performed, linked issue or task when available, and screenshots or screen recordings for visible UI changes. Mention localization, Firebase rules, or platform configuration changes explicitly.

## Security & Configuration Tips

Do not commit secrets, service account keys, or local Firebase credentials. Treat generated files and lockfiles carefully: regenerate them with the project tools, and avoid hand-editing generated localization output unless diagnosing a generator issue.
