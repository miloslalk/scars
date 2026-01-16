# Copilot Instructions for when_scars_become_art

## Project Overview
A Flutter mobile application focused on authentication and user login. The project uses mock data for credential validation and supports multiple login methods (Google, Apple, Facebook, and username/password).

## Architecture

### Project Structure
- **lib/main.dart**: Entry point; defines `MyApp` with MaterialApp and MaterialTheme
- **lib/screens/landing_page.dart**: Primary UI with stateful widget managing login forms
- **assets/mock_data/credentials.json**: Mock credential data loaded at runtime for testing
- **Android & iOS**: Platform-specific build configurations in `android/` and `ios/` folders

### Key Data Flow
1. App starts → `main()` runs `MyApp`
2. `MyApp` loads `LandingPage` as home screen
3. `LandingPage` initializes with `_loadCredentials()` from `assets/mock_data/credentials.json`
4. Credentials structure: `{ "credentials": [{ "username": "...", "password": "..." }] }`
5. Login validation compares input against loaded credentials

## Development Workflows

### Building & Running
```bash
# Get dependencies
flutter pub get

# Run app on connected device/emulator
flutter run

# Run with specific target
flutter run -t lib/main.dart

# Build release APK (Android)
flutter build apk

# Build iOS app
flutter build ios
```

### Code Quality
- Uses `flutter_lints` (included in analysis_options.yaml)
- Run analysis: `flutter analyze`
- Auto-format code: `dart format lib/`

### Testing
- Create tests in `test/` directory (directory doesn't exist yet)
- Run: `flutter test`

## Project Conventions

### State Management
- Uses built-in Flutter `StatefulWidget` and `setState()`
- No external state management libraries (Provider, Riverpod, etc.)
- Keep state localized to widgets that need it

### Asset Loading
- All assets declared in `pubspec.yaml` under `flutter.assets`
- Load JSON files with `rootBundle.loadString()` then `json.decode()`
- Mock credentials pattern: nested structure with `credentials` array

### UI Patterns
- Use `Container` with width constraints: `MediaQuery.of(context).size.width * 0.8`
- Standard Flutter Material widgets: `Scaffold`, `AppBar`, `ElevatedButton`, `TextField`
- Show feedback via `ScaffoldMessenger` and `SnackBar`
- Dispose `TextEditingController` in cleanup

## Critical Integration Points

### Dependencies (minimal setup)
```yaml
flutter:
  sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

### Login Feature Components
- **Forms**: Two `TextEditingController` instances (`_usernameController`, `_passwordController`)
- **Social buttons**: Placeholders for Google, Apple, Facebook (no implementation yet)
- **Credentials source**: `assets/mock_data/credentials.json` (currently empty)

### Platform-Specific Notes
- Android: Gradle-based build system in `android/` (Gradle 8.x pattern)
- iOS: Xcode workspace in `ios/` with Swift bridging headers
- Both platforms auto-configured via Flutter toolchain

## Before Making Changes

1. **Credentials format**: Ensure `credentials.json` maintains `{ "credentials": [{ "username": "...", "password": "..." }] }` structure
2. **Widget rebuilds**: Use `setState()` only for single-widget updates; consider Provider for larger refactors
3. **Asset declarations**: Always add new asset paths to `pubspec.yaml` before using
4. **Controller cleanup**: Always dispose of `TextEditingController` and other listeners in `dispose()`
5. **Material design**: Follow Flutter Material Design defaults (already applied via `ThemeData`)
