import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/firebase_options.dart';
import 'package:when_scars_become_art/services/notification_service.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'screens/landing_page.dart';

/// Wraps [GlobalMaterialLocalizations.delegate] to fall back to English
/// for locales it doesn't support (e.g. "rom" — Romani).
class _FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // If the standard delegate supports this locale, use it; otherwise English.
    if (GlobalMaterialLocalizations.delegate.isSupported(locale)) {
      return GlobalMaterialLocalizations.delegate.load(locale);
    }
    return GlobalMaterialLocalizations.delegate.load(const Locale('en'));
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<MaterialLocalizations> old,
  ) => false;
}

/// Same fallback strategy for Cupertino localizations.
class _FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    if (GlobalCupertinoLocalizations.delegate.isSupported(locale)) {
      return GlobalCupertinoLocalizations.delegate.load(locale);
    }
    return GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) => false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  fvp.registerWith(
    options: {
      'platforms': ['android'],
    },
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.initialize();

  runApp(const MyApp());
}

const supportedLocales = <Locale>[
  Locale('en'),
  Locale('sr'),
  Locale('mk'),
  Locale('de'),
  Locale('el'),
  Locale('ro'),
  Locale('ar'),
  Locale('rom'),
  Locale('tr'),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<Locale?> _localeNotifier = ValueNotifier<Locale?>(null);
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );

  static const _primary = Color(0xFF6B539D);
  static const _primarySoft = Color(0xFF745CA3);
  static const _accent = Color(0xFFBB9FC8);
  static const _lightBackground = Color(0xFFF7F5FA);
  static const _lightSurface = Color(0xFFEDEDEC);
  static const _darkBackground = Color(0xFF1A1624);
  static const _darkSurface = Color(0xFF262133);
  static const _lightSystemOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static const _darkSystemOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static final _nunitoText = Typography.englishLike2021
      .apply(fontFamily: 'Nunito')
      .copyWith(
        displayLarge: Typography.englishLike2021.displayLarge?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        displayMedium: Typography.englishLike2021.displayMedium?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        displaySmall: Typography.englishLike2021.displaySmall?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        headlineLarge: Typography.englishLike2021.headlineLarge?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        headlineMedium: Typography.englishLike2021.headlineMedium?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        headlineSmall: Typography.englishLike2021.headlineSmall?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        titleLarge: Typography.englishLike2021.titleLarge?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w900,
        ),
        titleMedium: Typography.englishLike2021.titleMedium?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: Typography.englishLike2021.titleSmall?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: Typography.englishLike2021.bodyLarge?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: Typography.englishLike2021.bodyMedium?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        bodySmall: Typography.englishLike2021.bodySmall?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: Typography.englishLike2021.labelLarge?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: Typography.englishLike2021.labelMedium?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
        labelSmall: Typography.englishLike2021.labelSmall?.copyWith(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
        ),
      );

  ThemeData _buildLightTheme() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: _primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: _primary,
          onPrimary: Colors.white,
          secondary: _accent,
          onSecondary: Colors.white,
          error: const Color(0xFFD14D4D),
          onError: Colors.white,
          surface: _lightSurface,
          onSurface: const Color(0xFF1C1A22),
        );

    return ThemeData(
      fontFamily: 'Nunito',
      textTheme: _nunitoText.apply(
        displayColor: colorScheme.onSurface,
        bodyColor: colorScheme.onSurface,
      ),
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: Color(0xFF1C1A22),
        elevation: 0,
        systemOverlayStyle: _lightSystemOverlay,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primary,
          side: const BorderSide(color: _primarySoft),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDD7E4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDD7E4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: _accent,
          brightness: Brightness.dark,
        ).copyWith(
          primary: _accent,
          onPrimary: const Color(0xFF1A1624),
          secondary: _primarySoft,
          onSecondary: Colors.white,
          error: const Color(0xFFE07070),
          onError: const Color(0xFF1A1624),
          surface: _darkSurface,
          onSurface: const Color(0xFFF2EEF8),
        );

    return ThemeData(
      fontFamily: 'Nunito',
      textTheme: _nunitoText.apply(
        displayColor: colorScheme.onSurface,
        bodyColor: colorScheme.onSurface,
      ),
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: Color(0xFFF2EEF8),
        elevation: 0,
        systemOverlayStyle: _darkSystemOverlay,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          foregroundColor: const Color(0xFF1A1624),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _accent,
          side: const BorderSide(color: _primarySoft),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3A3350)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3A3350)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _accent),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2E2940),
        surfaceTintColor: const Color(0xFF2E2940),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  void dispose() {
    _localeNotifier.dispose();
    _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<Locale?>(
          valueListenable: _localeNotifier,
          builder: (context, locale, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                _FallbackMaterialLocalizationsDelegate(),
                GlobalWidgetsLocalizations.delegate,
                _FallbackCupertinoLocalizationsDelegate(),
              ],
              supportedLocales: supportedLocales,
              locale: locale,
              theme: _buildLightTheme(),
              darkTheme: _buildDarkTheme(),
              themeMode: themeMode,
              home: LandingPage(
                localeNotifier: _localeNotifier,
                supportedLocales: supportedLocales,
                themeModeNotifier: _themeModeNotifier,
              ),
            );
          },
        );
      },
    );
  }
}
