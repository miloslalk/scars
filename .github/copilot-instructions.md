# Copilot Instructions for When Scars Become Art

## Project Overview

This repository contains a Flutter mobile app for mental health and emotional well-being, with Firebase used for authentication, realtime data, storage, and scheduled notifications. The app includes registration and login, drawing and journaling flows, guided exercises, daily messages, body awareness, and a Care Corner resource hub.

## Core Stack

- Flutter / Dart for the mobile app
- Firebase Auth for sign-in and account management
- Firebase Realtime Database for app data
- Firebase Storage for user-uploaded content
- Firebase Cloud Functions in `functions/` for notification scheduling

## Repository Layout

- `lib/main.dart` — app entry point, Firebase init, theme and locale wiring
- `lib/screens/` — screens and feature pages
- `lib/screens/home/` — `part` files used by `home_page.dart`
- `lib/widgets/` — shared UI components
- `lib/services/` — Firebase, notifications, audio, and manifest logic
- `lib/utils/` — shared helper utilities
- `lib/gen_l10n/` — generated localization output
- `l10n/*.arb` — source localization files
- `assets/` — images, fonts, audio, flags, messages, and other bundled assets
- `functions/index.js` — Firebase Cloud Functions entry point
- `database.rules.json` / `storage.rules` — Firebase security rules

## Development Commands

```bash
flutter pub get
flutter run
flutter analyze
flutter test
dart format lib test
flutter gen-l10n
cd functions && npm install
```

## Working Conventions

- Follow standard Flutter/Dart style with 2-space indentation and trailing commas in multi-line widget trees.
- Use `PascalCase` for classes, `camelCase` for members, and `snake_case.dart` for file names.
- Keep UI logic in screens/widgets and put Firebase, notification, audio, and manifest behavior in services.
- Do not edit `lib/gen_l10n/` by hand; update `l10n/*.arb` and regenerate.
- Dispose controllers and listeners in `dispose()`.
- Prefer small, focused changes that preserve the existing Material 3 visual language.

## Product Rules

- Email/password registration is required, with email verification and username uniqueness checks.
- Login supports email or username resolution through Realtime Database.
- Firebase Auth is the source of truth for passwords and account changes.
- Balloon messages should not reappear after a user pops them.
- Drawing saves upload to Storage and write metadata to Realtime Database.
- Sensitive account changes require re-authentication for password users.
- New feature copy should stay English-only until translations are explicitly requested.

Consult `NOTES.md` before changing user-facing behavior, because product rules and feature decisions are tracked there.

## Before Submitting Changes

- Run `flutter analyze`.
- Run relevant tests if present.
- Regenerate localization output after changing ARB files.
- Call out Firebase rules, localization changes, and platform configuration updates in review notes.
