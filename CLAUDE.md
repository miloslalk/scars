# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**When Scars (!) Become Art** — a Flutter mobile app for mental health and emotional well-being (mood tracking, journaling, guided meditation, drawing canvas, balloon messages). Organization: Amaro Foro e.V. Package ID: `eu.whenscarsbecomeart.app`.

## Build & Run Commands

```bash
flutter pub get              # Install dependencies
flutter run                  # Run on connected device/emulator
flutter build apk            # Release APK (Android)
flutter build ios            # Release build (iOS)
flutter analyze              # Lint (uses flutter_lints)
dart format lib/             # Auto-format
flutter test                 # Run tests (test/ directory)
flutter gen-l10n             # Regenerate localization files
```

Android release signing requires `android/key.properties` (not in repo). iOS uses CocoaPods (`cd ios && pod install`).

## Localization

- Config: `l10n.yaml` → source ARB: `l10n/app_en.arb` → generated output: `lib/gen_l10n/`
- 9 locales: en, sr, mk, de, el, ro, rom, ar, tr
- Add new strings to `l10n/app_en.arb`, then run `flutter gen-l10n`
- English-only for new work until translations are requested (per NOTES.md)
- Do not hand-edit files in `lib/gen_l10n/` — they are auto-generated

## Architecture

**State management**: StatefulWidget + setState(). ValueNotifier for app-level theme/locale. No Provider/Riverpod.

**Key structure**:
- `lib/main.dart` — Entry point, Firebase init, theme/locale ValueNotifiers, MaterialApp
- `lib/screens/landing_page.dart` — Auth (email/username + password, Google sign-in, Apple sign-in on iOS)
- `lib/screens/home_page.dart` — Main 4-tab scaffold after login
- `lib/screens/home/` — Tab content (home_content, home_drawing, home_messages, home_my_space, home_misc) as `part of` home_page.dart
- `lib/services/` — NotificationService (FCM), GuidedAudioService, MonsterManifestService
- `lib/widgets/` — Shared widgets (AppTopBar, AppLogo)

**Navigation**: LandingPage → HomePage with bottom nav (Home, My Space, Messages, Care Corner). Settings via avatar dropdown menu in AppTopBar.

## Firebase

Backend is entirely Firebase — no REST API or custom backend.

- **Auth**: Email/password + Google Sign-In. Email verification required (5-day expiry).
- **Realtime Database**: User profiles at `users/{uid}`, usernames index at `usernames/{key}`, drawings metadata, journal entries, body awareness, balloon messages, device tokens, notification prefs.
- **Storage**: User drawings (`users/{uid}/drawings/`), avatars (`users/{uid}/avatars/`), Cookie Monster audio clips.
- **Cloud Functions** (`functions/`): Scheduled push notification delivery.
- **Config**: `firebase.json`, `.firebaserc` (project: scars-d81cd), `database.rules.json`, `storage.rules`.

## Product Rules

Product decisions and behaviors are documented in **NOTES.md** — consult it before making feature changes. Key rules:
- Username: min 6 chars, unique (checked real-time against RTDB)
- Password: min 8 chars, 1 uppercase, 1 number, 1 special char
- Balloon messages: once popped, never shown again to that user
- Drawing save: uploads PNG to Storage + writes metadata to RTDB
- Re-authentication required before sensitive account changes (email/password)

## Conventions

- Material Design 3 theming with light/dark support
- Dispose all controllers and listeners in `dispose()`
- Assets declared in `pubspec.yaml` under `flutter.assets`
- Firebase Storage for user-generated content; local assets as fallbacks
- `home_*.dart` files use Dart `part`/`part of` with `home_page.dart`
