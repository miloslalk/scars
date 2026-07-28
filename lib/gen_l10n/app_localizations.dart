import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_rom.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('mk'),
    Locale('ro'),
    Locale('rom'),
    Locale('sr'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'When Scars (!) Become Art'**
  String get appTitle;

  /// No description provided for @loginWith.
  ///
  /// In en, this message translates to:
  /// **'Log in with:'**
  String get loginWith;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get loginWithGoogle;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Log in with Apple'**
  String get loginWithApple;

  /// No description provided for @loginWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Log in with Facebook'**
  String get loginWithFacebook;

  /// No description provided for @orLoginWithUsernameAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Or log in with username and password'**
  String get orLoginWithUsernameAndPassword;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @loadingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Loading credentials...'**
  String get loadingCredentials;

  /// No description provided for @unableToLoadCredentials.
  ///
  /// In en, this message translates to:
  /// **'Unable to load credentials'**
  String get unableToLoadCredentials;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @homeLabel.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeLabel;

  /// No description provided for @profileLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLabel;

  /// No description provided for @galleryLabel.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryLabel;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @helpLabel.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpLabel;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Page'**
  String get profilePageTitle;

  /// No description provided for @profilePageBody.
  ///
  /// In en, this message translates to:
  /// **'View and edit your profile information here.'**
  String get profilePageBody;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryTitle;

  /// No description provided for @galleryBody.
  ///
  /// In en, this message translates to:
  /// **'Browse your photo gallery here.'**
  String get galleryBody;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsBody.
  ///
  /// In en, this message translates to:
  /// **'Manage your app settings here.'**
  String get settingsBody;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpTitle;

  /// No description provided for @helpBody.
  ///
  /// In en, this message translates to:
  /// **'Get help and support here.'**
  String get helpBody;

  /// No description provided for @settingsPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferencesTitle;

  /// No description provided for @settingsPreferencesBody.
  ///
  /// In en, this message translates to:
  /// **'Personalize your app experience.'**
  String get settingsPreferencesBody;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Choose how we notify you.'**
  String get settingsNotificationsBody;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the language for the app.'**
  String get settingsLanguageBody;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'🇬🇧 English'**
  String get languageEnglish;

  /// No description provided for @languageSerbianLatin.
  ///
  /// In en, this message translates to:
  /// **'🇷🇸 Serbian (Latin)'**
  String get languageSerbianLatin;

  /// No description provided for @languageMacedonian.
  ///
  /// In en, this message translates to:
  /// **'🇲🇰 Macedonian'**
  String get languageMacedonian;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'🇩🇪 German'**
  String get languageGerman;

  /// No description provided for @languageGreek.
  ///
  /// In en, this message translates to:
  /// **'🇬🇷 Greek'**
  String get languageGreek;

  /// No description provided for @languageRomanian.
  ///
  /// In en, this message translates to:
  /// **'🇷🇴 Romanian'**
  String get languageRomanian;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'🇸🇦 Arabic'**
  String get languageArabic;

  /// No description provided for @languageRomani.
  ///
  /// In en, this message translates to:
  /// **'🟦🟩🟨🔴 Romani'**
  String get languageRomani;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'🇹🇷 Turkish'**
  String get languageTurkish;

  /// No description provided for @registrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get registrationTitle;

  /// No description provided for @registrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started.'**
  String get registrationSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerLink.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerLink;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration completed.'**
  String get registerSuccess;

  /// No description provided for @mySpaceLabel.
  ///
  /// In en, this message translates to:
  /// **'My Space'**
  String get mySpaceLabel;

  /// No description provided for @messagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesLabel;

  /// No description provided for @logoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutLabel;

  /// No description provided for @userMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'User menu'**
  String get userMenuTooltip;

  /// No description provided for @userMenuAccountFallback.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get userMenuAccountFallback;

  /// No description provided for @guidedMeditationTitle.
  ///
  /// In en, this message translates to:
  /// **'Guided Meditation'**
  String get guidedMeditationTitle;

  /// No description provided for @guidedMeditationDescription.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to breathe and listen.'**
  String get guidedMeditationDescription;

  /// No description provided for @guidedMeditationMetadataLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load remote track metadata. Playing fallback track.'**
  String get guidedMeditationMetadataLoadFailed;

  /// No description provided for @guidedMeditationSourceFirebase.
  ///
  /// In en, this message translates to:
  /// **'Source: Firebase'**
  String get guidedMeditationSourceFirebase;

  /// No description provided for @guidedMeditationSourceFallback.
  ///
  /// In en, this message translates to:
  /// **'Source: built-in fallback'**
  String get guidedMeditationSourceFallback;

  /// No description provided for @skipLabel.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipLabel;

  /// No description provided for @pauseLabel.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseLabel;

  /// No description provided for @playLabel.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playLabel;

  /// No description provided for @homeHowFeelingToday.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get homeHowFeelingToday;

  /// No description provided for @startLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startLabel;

  /// No description provided for @savingLabel.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get savingLabel;

  /// No description provided for @canvasNotReady.
  ///
  /// In en, this message translates to:
  /// **'Canvas is not ready yet.'**
  String get canvasNotReady;

  /// No description provided for @saveFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String saveFailedWithError(Object error);

  /// No description provided for @bodyTransitionPrompt.
  ///
  /// In en, this message translates to:
  /// **'Would you like to have a body scan?'**
  String get bodyTransitionPrompt;

  /// No description provided for @yesLabel.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesLabel;

  /// No description provided for @noLabel.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noLabel;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// No description provided for @homeCheckAgainAnytime.
  ///
  /// In en, this message translates to:
  /// **'You can check in again anytime today.'**
  String get homeCheckAgainAnytime;

  /// No description provided for @moodCheckLabel.
  ///
  /// In en, this message translates to:
  /// **'Mood check'**
  String get moodCheckLabel;

  /// No description provided for @bodyCheckLabel.
  ///
  /// In en, this message translates to:
  /// **'Body check'**
  String get bodyCheckLabel;

  /// No description provided for @meditationLabel.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get meditationLabel;

  /// No description provided for @moodCheckFullscreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Mood check (fullscreen)'**
  String get moodCheckFullscreenTitle;

  /// No description provided for @exitFullscreenLabel.
  ///
  /// In en, this message translates to:
  /// **'Exit fullscreen'**
  String get exitFullscreenLabel;

  /// No description provided for @fullscreenLabel.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get fullscreenLabel;

  /// No description provided for @skipToQuoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Skip to quote'**
  String get skipToQuoteLabel;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}, How are you feeling today?'**
  String homeGreeting(Object name);

  /// No description provided for @todaysAffirmationLabel.
  ///
  /// In en, this message translates to:
  /// **'Today\'s affirmation'**
  String get todaysAffirmationLabel;

  /// No description provided for @thereFallback.
  ///
  /// In en, this message translates to:
  /// **'there'**
  String get thereFallback;

  /// No description provided for @dailyAffirmation1.
  ///
  /// In en, this message translates to:
  /// **'The real miracle is believing in yourself.'**
  String get dailyAffirmation1;

  /// No description provided for @dailyAffirmation2.
  ///
  /// In en, this message translates to:
  /// **'Diversity makes the world beautiful.'**
  String get dailyAffirmation2;

  /// No description provided for @dailyAffirmation3.
  ///
  /// In en, this message translates to:
  /// **'After the rain comes the rainbow.'**
  String get dailyAffirmation3;

  /// No description provided for @dailyAffirmation4.
  ///
  /// In en, this message translates to:
  /// **'Allow yourself to be authentic, even in places where everyone is expected to be the same.'**
  String get dailyAffirmation4;

  /// No description provided for @dailyAffirmation5.
  ///
  /// In en, this message translates to:
  /// **'Your worth is not what you have, but who you are.'**
  String get dailyAffirmation5;

  /// No description provided for @dailyAffirmation6.
  ///
  /// In en, this message translates to:
  /// **'It\'s ok not to be ok.'**
  String get dailyAffirmation6;

  /// No description provided for @dailyAffirmation7.
  ///
  /// In en, this message translates to:
  /// **'There is a seat waiting for you at tables you haven\'t even seen.'**
  String get dailyAffirmation7;

  /// No description provided for @dailyAffirmation8.
  ///
  /// In en, this message translates to:
  /// **'You can do anything but you don\'t have to.'**
  String get dailyAffirmation8;

  /// No description provided for @dailyAffirmation9.
  ///
  /// In en, this message translates to:
  /// **'If saying goodbye hurts, it means you spent your time well.'**
  String get dailyAffirmation9;

  /// No description provided for @dailyAffirmation10.
  ///
  /// In en, this message translates to:
  /// **'Remember who cares about you.'**
  String get dailyAffirmation10;

  /// No description provided for @dailyAffirmation11.
  ///
  /// In en, this message translates to:
  /// **'What if it turns out better than you imagined?'**
  String get dailyAffirmation11;

  /// No description provided for @dailyAffirmation12.
  ///
  /// In en, this message translates to:
  /// **'You are enough'**
  String get dailyAffirmation12;

  /// No description provided for @dailyAffirmation13.
  ///
  /// In en, this message translates to:
  /// **'I make my own path'**
  String get dailyAffirmation13;

  /// No description provided for @dailyAffirmation14.
  ///
  /// In en, this message translates to:
  /// **'Today is a new day. Shine!'**
  String get dailyAffirmation14;

  /// No description provided for @dailyAffirmation15.
  ///
  /// In en, this message translates to:
  /// **'Never lose hope. Storms make people stronger and never last forever.'**
  String get dailyAffirmation15;

  /// No description provided for @dailyAffirmation16.
  ///
  /// In en, this message translates to:
  /// **'Cry. Forgive. Learn. Move on. Let your tears water the seeds of your future happiness.'**
  String get dailyAffirmation16;

  /// No description provided for @dailyAffirmation17.
  ///
  /// In en, this message translates to:
  /// **'It might not be easy but it\'ll be worth it.'**
  String get dailyAffirmation17;

  /// No description provided for @dailyAffirmation18.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to focus on the good things.'**
  String get dailyAffirmation18;

  /// No description provided for @dailyAffirmation19.
  ///
  /// In en, this message translates to:
  /// **'It\'s not selfish, it\'s self care.'**
  String get dailyAffirmation19;

  /// No description provided for @dailyAffirmation20.
  ///
  /// In en, this message translates to:
  /// **'You are the best, keep going.'**
  String get dailyAffirmation20;

  /// No description provided for @dailyAffirmation21.
  ///
  /// In en, this message translates to:
  /// **'Believe in yourself. You can make miracles happen'**
  String get dailyAffirmation21;

  /// No description provided for @dailyAffirmation22.
  ///
  /// In en, this message translates to:
  /// **'With the flow of life, this too shall pass.'**
  String get dailyAffirmation22;

  /// No description provided for @dailyAffirmation23.
  ///
  /// In en, this message translates to:
  /// **'Every challenge I face is an opportunity to grow stronger.'**
  String get dailyAffirmation23;

  /// No description provided for @dailyAffirmation24.
  ///
  /// In en, this message translates to:
  /// **'I embrace the questions in my heart and welcome the answers in their own time.'**
  String get dailyAffirmation24;

  /// No description provided for @dailyAffirmation25.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to be perfect.'**
  String get dailyAffirmation25;

  /// No description provided for @dailyAffirmation26.
  ///
  /// In en, this message translates to:
  /// **'Perfection is a utopia. It only serves as a compass.'**
  String get dailyAffirmation26;

  /// No description provided for @dailyAffirmation27.
  ///
  /// In en, this message translates to:
  /// **'I stand and fight to find my dreams.'**
  String get dailyAffirmation27;

  /// No description provided for @dailyAffirmation28.
  ///
  /// In en, this message translates to:
  /// **'Don\'t let the other decide your future.'**
  String get dailyAffirmation28;

  /// No description provided for @dailyAffirmation29.
  ///
  /// In en, this message translates to:
  /// **'I am grounded, resilient and open to grow even in uncertain times.'**
  String get dailyAffirmation29;

  /// No description provided for @dailyAffirmation30.
  ///
  /// In en, this message translates to:
  /// **'If life gives you moments, make them good memories.'**
  String get dailyAffirmation30;

  /// No description provided for @dailyAffirmation31.
  ///
  /// In en, this message translates to:
  /// **'Old ways won\'t open new doors.'**
  String get dailyAffirmation31;

  /// No description provided for @dailyAffirmation32.
  ///
  /// In en, this message translates to:
  /// **'Mistakes are proof that you are trying.'**
  String get dailyAffirmation32;

  /// No description provided for @dailyAffirmation33.
  ///
  /// In en, this message translates to:
  /// **'Just take that step and try, it\'s enough.'**
  String get dailyAffirmation33;

  /// No description provided for @dailyAffirmation34.
  ///
  /// In en, this message translates to:
  /// **'Just look at what we can do when we come together.'**
  String get dailyAffirmation34;

  /// No description provided for @dailyAffirmation35.
  ///
  /// In en, this message translates to:
  /// **'When you don\'t know where you are going, all roads will get you there.'**
  String get dailyAffirmation35;

  /// No description provided for @dailyAffirmation36.
  ///
  /// In en, this message translates to:
  /// **'Life is one day and that is today.'**
  String get dailyAffirmation36;

  /// No description provided for @dailyAffirmation37.
  ///
  /// In en, this message translates to:
  /// **'We are all made of stardust.'**
  String get dailyAffirmation37;

  /// No description provided for @dailyAffirmation38.
  ///
  /// In en, this message translates to:
  /// **'Dream with passion, live with responsibility.'**
  String get dailyAffirmation38;

  /// No description provided for @dailyAffirmation39.
  ///
  /// In en, this message translates to:
  /// **'It\'s all going to be okay. Say it one more time.'**
  String get dailyAffirmation39;

  /// No description provided for @dailyAffirmation40.
  ///
  /// In en, this message translates to:
  /// **'Be weird, be unique, be yourself.'**
  String get dailyAffirmation40;

  /// No description provided for @dailyAffirmation41.
  ///
  /// In en, this message translates to:
  /// **'Strong minds grow in safe spaces.'**
  String get dailyAffirmation41;

  /// No description provided for @dailyAffirmation42.
  ///
  /// In en, this message translates to:
  /// **'Every beginning is only a sequel, after all, and the book of events is always open halfway through.'**
  String get dailyAffirmation42;

  /// No description provided for @dailyAffirmation43.
  ///
  /// In en, this message translates to:
  /// **'Everything has a beginning and an ending, and the end can be beautiful, no matter how dark it seems now.'**
  String get dailyAffirmation43;

  /// No description provided for @dailyAffirmation44.
  ///
  /// In en, this message translates to:
  /// **'The only approval I will ever need is mine.'**
  String get dailyAffirmation44;

  /// No description provided for @dailyAffirmation45.
  ///
  /// In en, this message translates to:
  /// **'We shouldn\'t be looking for heroes, we should be looking for good ideas.'**
  String get dailyAffirmation45;

  /// No description provided for @dailyAffirmation46.
  ///
  /// In en, this message translates to:
  /// **'The smallest good deed is far better than the biggest good intention.'**
  String get dailyAffirmation46;

  /// No description provided for @dailyAffirmation47.
  ///
  /// In en, this message translates to:
  /// **'Where you come from is not something to shrink — it\'s something to stand inside of.'**
  String get dailyAffirmation47;

  /// No description provided for @dailyAffirmation48.
  ///
  /// In en, this message translates to:
  /// **'Your name, your language, your family\'s story, these are yours to carry with pride.'**
  String get dailyAffirmation48;

  /// No description provided for @dailyAffirmation49.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need permission to take up space in this world.'**
  String get dailyAffirmation49;

  /// No description provided for @dailyAffirmation50.
  ///
  /// In en, this message translates to:
  /// **'You are not \"too much\" of anything. You are exactly the right amount of you.'**
  String get dailyAffirmation50;

  /// No description provided for @dailyAffirmation51.
  ///
  /// In en, this message translates to:
  /// **'Your roots don\'t hold you back, they\'re what let you grow tall.'**
  String get dailyAffirmation51;

  /// No description provided for @dailyAffirmation52.
  ///
  /// In en, this message translates to:
  /// **'There\'s no single way to belong somewhere. You get to write your own way.'**
  String get dailyAffirmation52;

  /// No description provided for @dailyAffirmation53.
  ///
  /// In en, this message translates to:
  /// **'Your story matters, even the parts nobody\'s asked about yet.'**
  String get dailyAffirmation53;

  /// No description provided for @dailyAffirmation54.
  ///
  /// In en, this message translates to:
  /// **'You carry more than one home inside you, and that\'s not a burden, it\'s a richness.'**
  String get dailyAffirmation54;

  /// No description provided for @dailyAffirmation55.
  ///
  /// In en, this message translates to:
  /// **'Being proud of who you are doesn\'t need anyone else\'s approval first.'**
  String get dailyAffirmation55;

  /// No description provided for @dailyAffirmation56.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to earn your place here. You already have one.'**
  String get dailyAffirmation56;

  /// No description provided for @dailyAffirmation57.
  ///
  /// In en, this message translates to:
  /// **'Somewhere, a door is open for you, even on days it doesn\'t feel like it.'**
  String get dailyAffirmation57;

  /// No description provided for @dailyAffirmation58.
  ///
  /// In en, this message translates to:
  /// **'You are allowed to build a home in more than one place.'**
  String get dailyAffirmation58;

  /// No description provided for @dailyAffirmation59.
  ///
  /// In en, this message translates to:
  /// **'The people who matter will make room for you, not ask you to shrink.'**
  String get dailyAffirmation59;

  /// No description provided for @dailyAffirmation60.
  ///
  /// In en, this message translates to:
  /// **'You are not a guest in your own life.'**
  String get dailyAffirmation60;

  /// No description provided for @dailyAffirmation61.
  ///
  /// In en, this message translates to:
  /// **'Wherever you stand today, you have every right to be standing there.'**
  String get dailyAffirmation61;

  /// No description provided for @dailyAffirmation62.
  ///
  /// In en, this message translates to:
  /// **'Community isn\'t something you wait for, sometimes you\'re the one who starts it.'**
  String get dailyAffirmation62;

  /// No description provided for @dailyAffirmation63.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to choose between where you\'re from and where you are.'**
  String get dailyAffirmation63;

  /// No description provided for @dailyAffirmation64.
  ///
  /// In en, this message translates to:
  /// **'Today doesn\'t have to look like tomorrow.'**
  String get dailyAffirmation64;

  /// No description provided for @dailyAffirmation65.
  ///
  /// In en, this message translates to:
  /// **'Somewhere ahead, there\'s a version of your life you haven\'t imagined yet, and it\'s a good one.'**
  String get dailyAffirmation65;

  /// No description provided for @dailyAffirmation66.
  ///
  /// In en, this message translates to:
  /// **'Hard chapters end. Yours will too.'**
  String get dailyAffirmation66;

  /// No description provided for @dailyAffirmation67.
  ///
  /// In en, this message translates to:
  /// **'You\'re allowed to want more for yourself, and to go get it.'**
  String get dailyAffirmation67;

  /// No description provided for @dailyAffirmation68.
  ///
  /// In en, this message translates to:
  /// **'The future isn\'t fixed. You still get a say in it.'**
  String get dailyAffirmation68;

  /// No description provided for @dailyAffirmation69.
  ///
  /// In en, this message translates to:
  /// **'Small steps still count as moving forward.'**
  String get dailyAffirmation69;

  /// No description provided for @dailyAffirmation70.
  ///
  /// In en, this message translates to:
  /// **'You are not behind. You are exactly where your path has taken you.'**
  String get dailyAffirmation70;

  /// No description provided for @dailyAffirmation71.
  ///
  /// In en, this message translates to:
  /// **'What\'s coming for you hasn\'t happened yet, leave room for it to surprise you.'**
  String get dailyAffirmation71;

  /// No description provided for @dailyAffirmation72.
  ///
  /// In en, this message translates to:
  /// **'You get to decide what your story looks like from here.'**
  String get dailyAffirmation72;

  /// No description provided for @dailyAffirmation73.
  ///
  /// In en, this message translates to:
  /// **'You\'ve made it through every hard day so far. That\'s not luck, that\'s you.'**
  String get dailyAffirmation73;

  /// No description provided for @dailyAffirmation74.
  ///
  /// In en, this message translates to:
  /// **'Being tired doesn\'t mean you\'re failing. It means you\'ve been carrying a lot.'**
  String get dailyAffirmation74;

  /// No description provided for @dailyAffirmation75.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to be unbreakable. You just have to keep going at your own pace.'**
  String get dailyAffirmation75;

  /// No description provided for @dailyAffirmation76.
  ///
  /// In en, this message translates to:
  /// **'Strength isn\'t never struggling, it\'s showing up again anyway.'**
  String get dailyAffirmation76;

  /// No description provided for @dailyAffirmation77.
  ///
  /// In en, this message translates to:
  /// **'You\'re allowed to be proud of getting through, even if it wasn\'t pretty.'**
  String get dailyAffirmation77;

  /// No description provided for @dailyAffirmation78.
  ///
  /// In en, this message translates to:
  /// **'The hardest parts of your story don\'t get the final word.'**
  String get dailyAffirmation78;

  /// No description provided for @dailyAffirmation79.
  ///
  /// In en, this message translates to:
  /// **'You\'ve survived things people never see, and that counts for something.'**
  String get dailyAffirmation79;

  /// No description provided for @dailyAffirmation80.
  ///
  /// In en, this message translates to:
  /// **'It\'s okay if healing takes longer than you expected.'**
  String get dailyAffirmation80;

  /// No description provided for @dailyAffirmation81.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need to have it all figured out to keep moving.'**
  String get dailyAffirmation81;

  /// No description provided for @dailyAffirmation82.
  ///
  /// In en, this message translates to:
  /// **'Every day you keep showing up is a quiet kind of courage.'**
  String get dailyAffirmation82;

  /// No description provided for @dailyAffirmation83.
  ///
  /// In en, this message translates to:
  /// **'You are legally allowed to have a mediocre day. No permit needed.'**
  String get dailyAffirmation83;

  /// No description provided for @dailyAffirmation84.
  ///
  /// In en, this message translates to:
  /// **'Sometimes life is just deciding what to eat, three times a day, forever. You\'ve got this.'**
  String get dailyAffirmation84;

  /// No description provided for @dailyAffirmation85.
  ///
  /// In en, this message translates to:
  /// **'Not every day has to be a masterpiece. Some days just have to happen.'**
  String get dailyAffirmation85;

  /// No description provided for @dailyAffirmation86.
  ///
  /// In en, this message translates to:
  /// **'You\'re doing better than your group chat notifications suggest.'**
  String get dailyAffirmation86;

  /// No description provided for @dailyAffirmation87.
  ///
  /// In en, this message translates to:
  /// **'Confidence is just pretending you know where you\'re going until you actually do.'**
  String get dailyAffirmation87;

  /// No description provided for @dailyAffirmation88.
  ///
  /// In en, this message translates to:
  /// **'You\'ve survived 100% of your worst days. Solid track record.'**
  String get dailyAffirmation88;

  /// No description provided for @dailyAffirmation89.
  ///
  /// In en, this message translates to:
  /// **'Nobody has it all figured out. The ones who look like they do are just better at texting back slowly.'**
  String get dailyAffirmation89;

  /// No description provided for @dailyAffirmation90.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need a five-year plan today. A decent breakfast will do.'**
  String get dailyAffirmation90;

  /// No description provided for @dailyAffirmation91.
  ///
  /// In en, this message translates to:
  /// **'Growth looks a lot like tripping forward and calling it progress.'**
  String get dailyAffirmation91;

  /// No description provided for @dailyAffirmation92.
  ///
  /// In en, this message translates to:
  /// **'Some days the win is just: you got up. That counts.'**
  String get dailyAffirmation92;

  /// No description provided for @dailyAffirmation93.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to carry everything alone, let people help.'**
  String get dailyAffirmation93;

  /// No description provided for @dailyAffirmation94.
  ///
  /// In en, this message translates to:
  /// **'Somebody out there has your back, even on days it\'s hard to feel it.'**
  String get dailyAffirmation94;

  /// No description provided for @dailyAffirmation95.
  ///
  /// In en, this message translates to:
  /// **'Asking for help is not a weakness. It\'s how people build real friendships.'**
  String get dailyAffirmation95;

  /// No description provided for @dailyAffirmation96.
  ///
  /// In en, this message translates to:
  /// **'The people around you need you exactly as much as you need them.'**
  String get dailyAffirmation96;

  /// No description provided for @dailyAffirmation97.
  ///
  /// In en, this message translates to:
  /// **'You are part of something bigger, even on the days you feel invisible.'**
  String get dailyAffirmation97;

  /// No description provided for @dailyAffirmation98.
  ///
  /// In en, this message translates to:
  /// **'You\'re allowed to rest before you\'re completely exhausted.'**
  String get dailyAffirmation98;

  /// No description provided for @dailyAffirmation99.
  ///
  /// In en, this message translates to:
  /// **'Feeling sad today doesn\'t cancel out feeling okay tomorrow.'**
  String get dailyAffirmation99;

  /// No description provided for @dailyAffirmation100.
  ///
  /// In en, this message translates to:
  /// **'You don\'t owe anyone constant positivity.'**
  String get dailyAffirmation100;

  /// No description provided for @dailyAffirmation101.
  ///
  /// In en, this message translates to:
  /// **'It\'s fine to not have an answer right now.'**
  String get dailyAffirmation101;

  /// No description provided for @dailyAffirmation102.
  ///
  /// In en, this message translates to:
  /// **'Taking care of yourself today is not selfish, it\'s necessary.'**
  String get dailyAffirmation102;

  /// No description provided for @dailyAffirmation103.
  ///
  /// In en, this message translates to:
  /// **'Someone else\'s prejudice is not evidence about who you are.'**
  String get dailyAffirmation103;

  /// No description provided for @dailyAffirmation104.
  ///
  /// In en, this message translates to:
  /// **'You are not the story other people tell about you.'**
  String get dailyAffirmation104;

  /// No description provided for @dailyAffirmation105.
  ///
  /// In en, this message translates to:
  /// **'Believing you deserve less is never true. You deserve full respect.'**
  String get dailyAffirmation105;

  /// No description provided for @dailyAffirmation106.
  ///
  /// In en, this message translates to:
  /// **'Your worth is never up for debate, no matter who makes you feel otherwise.'**
  String get dailyAffirmation106;

  /// No description provided for @dailyAffirmation107.
  ///
  /// In en, this message translates to:
  /// **'You are not invisible. Someone here sees exactly who you are.'**
  String get dailyAffirmation107;

  /// No description provided for @dailyAffirmation108.
  ///
  /// In en, this message translates to:
  /// **'Being overlooked by some doesn\'t mean you go unseen by all.'**
  String get dailyAffirmation108;

  /// No description provided for @dailyAffirmation109.
  ///
  /// In en, this message translates to:
  /// **'You matter, even in rooms where no one says so out loud.'**
  String get dailyAffirmation109;

  /// No description provided for @dailyAffirmation110.
  ///
  /// In en, this message translates to:
  /// **'Someone noticed. You are not as unseen as it feels.'**
  String get dailyAffirmation110;

  /// No description provided for @dailyAffirmation111.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to shrink to be noticed for the right reasons.'**
  String get dailyAffirmation111;

  /// No description provided for @dailyAffirmation112.
  ///
  /// In en, this message translates to:
  /// **'Being seen starts with how you see yourself, and you\'re allowed to start there.'**
  String get dailyAffirmation112;

  /// No description provided for @dailyAffirmation113.
  ///
  /// In en, this message translates to:
  /// **'You are not \"too much\" or \"not enough\", you are simply seen.'**
  String get dailyAffirmation113;

  /// No description provided for @dailyAffirmation114.
  ///
  /// In en, this message translates to:
  /// **'There are people who value exactly what makes you, you.'**
  String get dailyAffirmation114;

  /// No description provided for @dailyAffirmation115.
  ///
  /// In en, this message translates to:
  /// **'Your presence changes a room, even when it feels like it doesn\'t.'**
  String get dailyAffirmation115;

  /// No description provided for @dailyAffirmation116.
  ///
  /// In en, this message translates to:
  /// **'You are known by more people, in more ways, than you realize.'**
  String get dailyAffirmation116;

  /// No description provided for @dailyAffirmation117.
  ///
  /// In en, this message translates to:
  /// **'You don\'t control everything that happens to you. You do control how you meet it.'**
  String get dailyAffirmation117;

  /// No description provided for @dailyAffirmation118.
  ///
  /// In en, this message translates to:
  /// **'You get to be the one who decides what happens next for you.'**
  String get dailyAffirmation118;

  /// No description provided for @dailyAffirmation119.
  ///
  /// In en, this message translates to:
  /// **'Small choices are still yours to make, even in hard circumstances.'**
  String get dailyAffirmation119;

  /// No description provided for @dailyAffirmation120.
  ///
  /// In en, this message translates to:
  /// **'You are not a passenger in your own life.'**
  String get dailyAffirmation120;

  /// No description provided for @dailyAffirmation121.
  ///
  /// In en, this message translates to:
  /// **'Asking for what you need is a form of power, not weakness.'**
  String get dailyAffirmation121;

  /// No description provided for @dailyAffirmation122.
  ///
  /// In en, this message translates to:
  /// **'You have a say in this, even when it doesn\'t feel like it.'**
  String get dailyAffirmation122;

  /// No description provided for @dailyAffirmation123.
  ///
  /// In en, this message translates to:
  /// **'Nobody gets to write your next chapter but you.'**
  String get dailyAffirmation123;

  /// No description provided for @dailyAffirmation124.
  ///
  /// In en, this message translates to:
  /// **'Even in systems that weren\'t built for you, your choices still count.'**
  String get dailyAffirmation124;

  /// No description provided for @dailyAffirmation125.
  ///
  /// In en, this message translates to:
  /// **'You are allowed to want things to be different, and to work toward that.'**
  String get dailyAffirmation125;

  /// No description provided for @dailyAffirmation126.
  ///
  /// In en, this message translates to:
  /// **'What you do with today is still yours to decide.'**
  String get dailyAffirmation126;

  /// No description provided for @dailyAffirmation127.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need to change who you are to have earned your place here.'**
  String get dailyAffirmation127;

  /// No description provided for @dailyAffirmation128.
  ///
  /// In en, this message translates to:
  /// **'There are people who will hold space for exactly who you are.'**
  String get dailyAffirmation128;

  /// No description provided for @dailyAffirmation129.
  ///
  /// In en, this message translates to:
  /// **'You belong to more than one place, and that\'s not a contradiction.'**
  String get dailyAffirmation129;

  /// No description provided for @dailyAffirmation130.
  ///
  /// In en, this message translates to:
  /// **'Real connection doesn\'t ask you to hide any part of yourself.'**
  String get dailyAffirmation130;

  /// No description provided for @dailyAffirmation131.
  ///
  /// In en, this message translates to:
  /// **'Somewhere, someone is glad you exist.'**
  String get dailyAffirmation131;

  /// No description provided for @dailyAffirmation132.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to explain yourself to belong.'**
  String get dailyAffirmation132;

  /// No description provided for @dailyAffirmation133.
  ///
  /// In en, this message translates to:
  /// **'Community isn\'t something you have to qualify for. You\'re already in it.'**
  String get dailyAffirmation133;

  /// No description provided for @dailyAffirmation134.
  ///
  /// In en, this message translates to:
  /// **'Being far from where you started doesn\'t mean you\'re without a home.'**
  String get dailyAffirmation134;

  /// No description provided for @dailyAffirmation135.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to do this alone, even when it feels that way.'**
  String get dailyAffirmation135;

  /// No description provided for @dailyAffirmation136.
  ///
  /// In en, this message translates to:
  /// **'There are people building a life alongside you, not just watching from outside.'**
  String get dailyAffirmation136;

  /// No description provided for @dailyAffirmation137.
  ///
  /// In en, this message translates to:
  /// **'Your roots carry generations of strength, you inherited that, too.'**
  String get dailyAffirmation137;

  /// No description provided for @dailyAffirmation138.
  ///
  /// In en, this message translates to:
  /// **'Your language, your traditions, your family\'s story, they are worth keeping alive.'**
  String get dailyAffirmation138;

  /// No description provided for @dailyAffirmation139.
  ///
  /// In en, this message translates to:
  /// **'What makes your community different is exactly what makes it worth being part of.'**
  String get dailyAffirmation139;

  /// No description provided for @dailyAffirmation140.
  ///
  /// In en, this message translates to:
  /// **'You don\'t owe anyone an apology for where you come from.'**
  String get dailyAffirmation140;

  /// No description provided for @dailyAffirmation141.
  ///
  /// In en, this message translates to:
  /// **'Your heritage is not something to manage. It\'s something to be proud of.'**
  String get dailyAffirmation141;

  /// No description provided for @dailyAffirmation142.
  ///
  /// In en, this message translates to:
  /// **'Your culture is not a problem to solve. It\'s part of your strength.'**
  String get dailyAffirmation142;

  /// No description provided for @dailyAffirmation143.
  ///
  /// In en, this message translates to:
  /// **'Being proud of who you are is not the same as being naive about the world.'**
  String get dailyAffirmation143;

  /// No description provided for @dailyAffirmation144.
  ///
  /// In en, this message translates to:
  /// **'Your identity is not a burden you carry. It\'s a foundation you stand on.'**
  String get dailyAffirmation144;

  /// No description provided for @dailyAffirmation145.
  ///
  /// In en, this message translates to:
  /// **'What was passed down to you deserves to be passed forward.'**
  String get dailyAffirmation145;

  /// No description provided for @dailyAffirmation146.
  ///
  /// In en, this message translates to:
  /// **'It\'s okay if today feels blank. You don\'t have to perform being fine.'**
  String get dailyAffirmation146;

  /// No description provided for @dailyAffirmation147.
  ///
  /// In en, this message translates to:
  /// **'You\'re allowed to be tired of explaining yourself.'**
  String get dailyAffirmation147;

  /// No description provided for @dailyAffirmation148.
  ///
  /// In en, this message translates to:
  /// **'Sadness doesn\'t mean you\'re weak. It means you\'re paying attention to something real.'**
  String get dailyAffirmation148;

  /// No description provided for @dailyAffirmation149.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to have hope every single day. Some days, just getting through is enough.'**
  String get dailyAffirmation149;

  /// No description provided for @dailyAffirmation150.
  ///
  /// In en, this message translates to:
  /// **'It\'s okay to be angry about things that were never fair.'**
  String get dailyAffirmation150;

  /// No description provided for @dailyAffirmation151.
  ///
  /// In en, this message translates to:
  /// **'Crying about something real is not the same as falling apart.'**
  String get dailyAffirmation151;

  /// No description provided for @dailyAffirmation152.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need to justify why something hurt. It did. That\'s enough reason.'**
  String get dailyAffirmation152;

  /// No description provided for @dailyAffirmation153.
  ///
  /// In en, this message translates to:
  /// **'Some days the bar is \"got dressed.\" Respect the bar.'**
  String get dailyAffirmation153;

  /// No description provided for @dailyAffirmation154.
  ///
  /// In en, this message translates to:
  /// **'You\'ve made it through 100% of your Mondays. Undefeated.'**
  String get dailyAffirmation154;

  /// No description provided for @dailyAffirmation155.
  ///
  /// In en, this message translates to:
  /// **'Nobody\'s life is actually like their photos. Yours doesn\'t need to be either.'**
  String get dailyAffirmation155;

  /// No description provided for @dailyAffirmation156.
  ///
  /// In en, this message translates to:
  /// **'Being an adult is 10% wisdom, 90% pretending you know how the printer works.'**
  String get dailyAffirmation156;

  /// No description provided for @dailyAffirmation157.
  ///
  /// In en, this message translates to:
  /// **'You are one snack away from feeling like a slightly better person. Go get it.'**
  String get dailyAffirmation157;

  /// No description provided for @dailyAffirmation158.
  ///
  /// In en, this message translates to:
  /// **'Confidence is just walking into a room like you paid rent there.'**
  String get dailyAffirmation158;

  /// No description provided for @dailyAffirmation159.
  ///
  /// In en, this message translates to:
  /// **'It\'s fine to nap through your feelings sometimes. Feelings are patient.'**
  String get dailyAffirmation159;

  /// No description provided for @dailyAffirmation160.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to be a \"morning person.\" You just have to survive the morning.'**
  String get dailyAffirmation160;

  /// No description provided for @dailyAffirmation161.
  ///
  /// In en, this message translates to:
  /// **'Overthinking burns calories too, probably. You\'ve earned dessert.'**
  String get dailyAffirmation161;

  /// No description provided for @dailyAffirmation162.
  ///
  /// In en, this message translates to:
  /// **'Some decisions are best made by flipping a coin and being relieved either way.'**
  String get dailyAffirmation162;

  /// No description provided for @dailyAffirmation163.
  ///
  /// In en, this message translates to:
  /// **'You are doing great, statistically speaking, compared to a raccoon in a bin.'**
  String get dailyAffirmation163;

  /// No description provided for @dailyAffirmation164.
  ///
  /// In en, this message translates to:
  /// **'Deep breaths count as a whole wellness routine. You\'re basically thriving.'**
  String get dailyAffirmation164;

  /// No description provided for @dailyAffirmation165.
  ///
  /// In en, this message translates to:
  /// **'If today were a group project, you\'d have done more than half the people.'**
  String get dailyAffirmation165;

  /// No description provided for @dailyAffirmation166.
  ///
  /// In en, this message translates to:
  /// **'Nobody\'s plants survive the first try. You\'re doing better than you think.'**
  String get dailyAffirmation166;

  /// No description provided for @dailyAffirmation167.
  ///
  /// In en, this message translates to:
  /// **'You\'ve technically survived every single \"worst day ever\" so far.'**
  String get dailyAffirmation167;

  /// No description provided for @dailyAffirmation168.
  ///
  /// In en, this message translates to:
  /// **'Being tired is just your body applauding you for existing all day.'**
  String get dailyAffirmation168;

  /// No description provided for @dailyAffirmation169.
  ///
  /// In en, this message translates to:
  /// **'Not every day needs a plot twist. Some days just need snacks and a nap.'**
  String get dailyAffirmation169;

  /// No description provided for @dailyAffirmation170.
  ///
  /// In en, this message translates to:
  /// **'You are allowed to be a work in progress and still be a whole person today.'**
  String get dailyAffirmation170;

  /// No description provided for @dailyAffirmation171.
  ///
  /// In en, this message translates to:
  /// **'Procrastinating on something scary is just your brain being a good friend.'**
  String get dailyAffirmation171;

  /// No description provided for @dailyAffirmation172.
  ///
  /// In en, this message translates to:
  /// **'Life doesn\'t come with instructions, so honestly, you\'re improvising beautifully.'**
  String get dailyAffirmation172;

  /// No description provided for @dailyAffirmation173.
  ///
  /// In en, this message translates to:
  /// **'You are the main character today, even if the plot is just laundry.'**
  String get dailyAffirmation173;

  /// No description provided for @dailyAffirmation174.
  ///
  /// In en, this message translates to:
  /// **'It\'s okay to not have your life together. Nobody\'s is, they just have better lighting.'**
  String get dailyAffirmation174;

  /// No description provided for @dailyAffirmation175.
  ///
  /// In en, this message translates to:
  /// **'You\'ve navigated today without a manual, which is basically a superpower.'**
  String get dailyAffirmation175;

  /// No description provided for @dailyAffirmation176.
  ///
  /// In en, this message translates to:
  /// **'Small wins still count, even ones like \"answered that one message.\"'**
  String get dailyAffirmation176;

  /// No description provided for @dailyAffirmation177.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to win the day. Surviving it with snacks is a legitimate strategy.'**
  String get dailyAffirmation177;

  /// No description provided for @dailyAffirmation178.
  ///
  /// In en, this message translates to:
  /// **'Some days you\'re a lion. Some days you\'re a lion who just wants a blanket. Both are valid.'**
  String get dailyAffirmation178;

  /// No description provided for @dailyAffirmation179.
  ///
  /// In en, this message translates to:
  /// **'You are allowed to laugh at the chaos. It\'s usually the sanest response.'**
  String get dailyAffirmation179;

  /// No description provided for @dailyAffirmation180.
  ///
  /// In en, this message translates to:
  /// **'Your future self will thank you for that nap you\'re about to take.'**
  String get dailyAffirmation180;

  /// No description provided for @dailyAffirmation181.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of love that doesn\'t ask you to change first.'**
  String get dailyAffirmation181;

  /// No description provided for @dailyAffirmation182.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of rest, even on days you haven\'t \"earned\" it.'**
  String get dailyAffirmation182;

  /// No description provided for @dailyAffirmation183.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of taking up space exactly as you are.'**
  String get dailyAffirmation183;

  /// No description provided for @dailyAffirmation184.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being chosen, not just tolerated.'**
  String get dailyAffirmation184;

  /// No description provided for @dailyAffirmation185.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of kindness, including your own.'**
  String get dailyAffirmation185;

  /// No description provided for @dailyAffirmation186.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of good things, even the ones you haven\'t asked for.'**
  String get dailyAffirmation186;

  /// No description provided for @dailyAffirmation187.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of people who show up for you.'**
  String get dailyAffirmation187;

  /// No description provided for @dailyAffirmation188.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of a life that feels like yours.'**
  String get dailyAffirmation188;

  /// No description provided for @dailyAffirmation189.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being believed when you speak.'**
  String get dailyAffirmation189;

  /// No description provided for @dailyAffirmation190.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of softness, even in a hard world.'**
  String get dailyAffirmation190;

  /// No description provided for @dailyAffirmation191.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of joy that has no explanation attached.'**
  String get dailyAffirmation191;

  /// No description provided for @dailyAffirmation192.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of safety, wherever you are.'**
  String get dailyAffirmation192;

  /// No description provided for @dailyAffirmation193.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being loved without earning it first.'**
  String get dailyAffirmation193;

  /// No description provided for @dailyAffirmation194.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of a seat at the table, not just a spot in the room.'**
  String get dailyAffirmation194;

  /// No description provided for @dailyAffirmation195.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of dreams that are yours, not borrowed from anyone else.'**
  String get dailyAffirmation195;

  /// No description provided for @dailyAffirmation196.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of patience, especially your own.'**
  String get dailyAffirmation196;

  /// No description provided for @dailyAffirmation197.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being understood, not just tolerated.'**
  String get dailyAffirmation197;

  /// No description provided for @dailyAffirmation198.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of good things happening to you, not just surviving.'**
  String get dailyAffirmation198;

  /// No description provided for @dailyAffirmation199.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being celebrated, not just accepted.'**
  String get dailyAffirmation199;

  /// No description provided for @dailyAffirmation200.
  ///
  /// In en, this message translates to:
  /// **'You are worthy exactly as you are today, unfinished and all.'**
  String get dailyAffirmation200;

  /// No description provided for @dailyAffirmation201.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of a future that doesn\'t repeat your hardest days.'**
  String get dailyAffirmation201;

  /// No description provided for @dailyAffirmation202.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of feeling proud of yourself, without conditions attached.'**
  String get dailyAffirmation202;

  /// No description provided for @dailyAffirmation203.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of people who don\'t make you shrink.'**
  String get dailyAffirmation203;

  /// No description provided for @dailyAffirmation204.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of your own respect, first and always.'**
  String get dailyAffirmation204;

  /// No description provided for @dailyAffirmation205.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of gentleness on the days you feel least deserving of it.'**
  String get dailyAffirmation205;

  /// No description provided for @dailyAffirmation206.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being someone\'s favorite person.'**
  String get dailyAffirmation206;

  /// No description provided for @dailyAffirmation207.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of a life with more ease in it.'**
  String get dailyAffirmation207;

  /// No description provided for @dailyAffirmation208.
  ///
  /// In en, this message translates to:
  /// **'You are worthy, not because of what you do, but because you exist.'**
  String get dailyAffirmation208;

  /// No description provided for @dailyAffirmation209.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of being wanted, not just needed.'**
  String get dailyAffirmation209;

  /// No description provided for @dailyAffirmation210.
  ///
  /// In en, this message translates to:
  /// **'You are worthy of trusting yourself again.'**
  String get dailyAffirmation210;

  /// No description provided for @pleaseLogInAgain.
  ///
  /// In en, this message translates to:
  /// **'Please log in again.'**
  String get pleaseLogInAgain;

  /// No description provided for @unableToCaptureDrawing.
  ///
  /// In en, this message translates to:
  /// **'Unable to capture drawing.'**
  String get unableToCaptureDrawing;

  /// No description provided for @unableToExportDrawing.
  ///
  /// In en, this message translates to:
  /// **'Unable to export drawing.'**
  String get unableToExportDrawing;

  /// No description provided for @drawingSaved.
  ///
  /// In en, this message translates to:
  /// **'Drawing saved.'**
  String get drawingSaved;

  /// No description provided for @failedToSaveWithCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {code}'**
  String failedToSaveWithCode(Object code);

  /// No description provided for @failedToSaveDrawing.
  ///
  /// In en, this message translates to:
  /// **'Failed to save drawing.'**
  String get failedToSaveDrawing;

  /// No description provided for @toolsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get toolsLabel;

  /// No description provided for @useThisColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Use this color'**
  String get useThisColorLabel;

  /// No description provided for @textSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSizeLabel;

  /// No description provided for @eraserSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Eraser size'**
  String get eraserSizeLabel;

  /// No description provided for @brushSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Brush size'**
  String get brushSizeLabel;

  /// No description provided for @fontLabel.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get fontLabel;

  /// No description provided for @addTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Add text'**
  String get addTextTitle;

  /// No description provided for @writeUpToTwoLinesHint.
  ///
  /// In en, this message translates to:
  /// **'Write up to 2 lines'**
  String get writeUpToTwoLinesHint;

  /// No description provided for @cancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// No description provided for @addLabel.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addLabel;

  /// No description provided for @undoLabel.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoLabel;

  /// No description provided for @clearLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearLabel;

  /// No description provided for @moreToolsLabel.
  ///
  /// In en, this message translates to:
  /// **'More tools'**
  String get moreToolsLabel;

  /// No description provided for @verificationExpiredDeleted.
  ///
  /// In en, this message translates to:
  /// **'Verification expired. Account deleted.'**
  String get verificationExpiredDeleted;

  /// No description provided for @verifyEmailUntil.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email {email} until {expiryText}.'**
  String verifyEmailUntil(Object email, Object expiryText);

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email {email}.'**
  String verifyEmail(Object email);

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed.'**
  String get googleSignInFailed;

  /// No description provided for @appleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in failed.'**
  String get appleSignInFailed;

  /// No description provided for @userFallbackName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userFallbackName;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get enterValidEmail;

  /// No description provided for @sendLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLinkLabel;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent to {email}.'**
  String passwordResetSent(Object email);

  /// No description provided for @unableToSendPasswordReset.
  ///
  /// In en, this message translates to:
  /// **'Unable to send password reset email.'**
  String get unableToSendPasswordReset;

  /// No description provided for @signingInLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingInLabel;

  /// No description provided for @forgotPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLabel;

  /// No description provided for @acceptTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and services.'**
  String get acceptTermsRequired;

  /// No description provided for @usernameAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Username already exists.'**
  String get usernameAlreadyExists;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed.'**
  String get registrationFailed;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent to {email}.'**
  String verificationEmailSent(Object email);

  /// No description provided for @registrationFailedWithCode.
  ///
  /// In en, this message translates to:
  /// **'Registration failed: {code}'**
  String registrationFailedWithCode(Object code);

  /// No description provided for @registrationTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Registration timed out. Check emulator.'**
  String get registrationTimedOut;

  /// No description provided for @registrationFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Registration failed: {error}'**
  String registrationFailedWithError(Object error);

  /// No description provided for @atLeast6Characters.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters.'**
  String get atLeast6Characters;

  /// No description provided for @passwordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get passwordTooWeak;

  /// No description provided for @passwordRuleAtLeast8.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get passwordRuleAtLeast8;

  /// No description provided for @passwordRuleUppercase.
  ///
  /// In en, this message translates to:
  /// **'At least 1 uppercase letter'**
  String get passwordRuleUppercase;

  /// No description provided for @passwordRuleNumber.
  ///
  /// In en, this message translates to:
  /// **'At least 1 number'**
  String get passwordRuleNumber;

  /// No description provided for @passwordRuleSpecial.
  ///
  /// In en, this message translates to:
  /// **'At least 1 special character'**
  String get passwordRuleSpecial;

  /// No description provided for @iAcceptPrefix.
  ///
  /// In en, this message translates to:
  /// **'I accept'**
  String get iAcceptPrefix;

  /// No description provided for @termsAndServicesLabel.
  ///
  /// In en, this message translates to:
  /// **'terms and services'**
  String get termsAndServicesLabel;

  /// No description provided for @oneBalloonPerDayMessage.
  ///
  /// In en, this message translates to:
  /// **'You can pop one balloon per day. Come back tomorrow.'**
  String get oneBalloonPerDayMessage;

  /// No description provided for @languageEnglishLabel.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishLabel;

  /// No description provided for @messageTitle.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageTitle;

  /// No description provided for @closeLabel.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeLabel;

  /// No description provided for @savedToMySpace.
  ///
  /// In en, this message translates to:
  /// **'Saved to My Space.'**
  String get savedToMySpace;

  /// No description provided for @alreadyOpenedTodayMessage.
  ///
  /// In en, this message translates to:
  /// **'You already opened today\'s message. Come back tomorrow for a new balloon.'**
  String get alreadyOpenedTodayMessage;

  /// No description provided for @mySpaceIntro.
  ///
  /// In en, this message translates to:
  /// **'Calendar, journaling, and your saved library in one place.'**
  String get mySpaceIntro;

  /// No description provided for @calendarLabel.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarLabel;

  /// No description provided for @journalLabel.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journalLabel;

  /// No description provided for @libraryLabel.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryLabel;

  /// No description provided for @mySpaceCalendarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mood, body, quote, note'**
  String get mySpaceCalendarSubtitle;

  /// No description provided for @mySpaceJournalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Entries and prompts'**
  String get mySpaceJournalSubtitle;

  /// No description provided for @mySpaceLibrarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Saved resources'**
  String get mySpaceLibrarySubtitle;

  /// No description provided for @deleteDrawingTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete drawing?'**
  String get deleteDrawingTitle;

  /// No description provided for @deleteDrawingBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteDrawingBody;

  /// No description provided for @deleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// No description provided for @failedToDeleteDrawing.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete drawing.'**
  String get failedToDeleteDrawing;

  /// No description provided for @noDrawingsForDay.
  ///
  /// In en, this message translates to:
  /// **'No drawings saved for this day.'**
  String get noDrawingsForDay;

  /// No description provided for @noBodyMapForDay.
  ///
  /// In en, this message translates to:
  /// **'No body map saved for this day.'**
  String get noBodyMapForDay;

  /// No description provided for @noFrontMapForDay.
  ///
  /// In en, this message translates to:
  /// **'No front map saved for this day.'**
  String get noFrontMapForDay;

  /// No description provided for @noBackMapForDay.
  ///
  /// In en, this message translates to:
  /// **'No back map saved for this day.'**
  String get noBackMapForDay;

  /// No description provided for @showBackLabel.
  ///
  /// In en, this message translates to:
  /// **'Show back'**
  String get showBackLabel;

  /// No description provided for @showFrontLabel.
  ///
  /// In en, this message translates to:
  /// **'Show front'**
  String get showFrontLabel;

  /// No description provided for @previewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Preview unavailable'**
  String get previewUnavailable;

  /// No description provided for @deleteDrawingTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete drawing'**
  String get deleteDrawingTooltip;

  /// No description provided for @dayOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Day overview'**
  String get dayOverviewTitle;

  /// No description provided for @selectedDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected date: {dateLabel}'**
  String selectedDateLabel(Object dateLabel);

  /// No description provided for @moodLabel.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get moodLabel;

  /// No description provided for @bodyLabel.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get bodyLabel;

  /// No description provided for @quoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Affirmation'**
  String get quoteLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @noQuoteForDay.
  ///
  /// In en, this message translates to:
  /// **'No affirmation saved for this day.'**
  String get noQuoteForDay;

  /// No description provided for @dailyMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Message'**
  String get dailyMessageLabel;

  /// No description provided for @noDailyMessageForDay.
  ///
  /// In en, this message translates to:
  /// **'No message saved for this day.'**
  String get noDailyMessageForDay;

  /// No description provided for @noNoteForDay.
  ///
  /// In en, this message translates to:
  /// **'No note saved for this day.'**
  String get noNoteForDay;

  /// No description provided for @doneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneLabel;

  /// No description provided for @failedToSaveJournalEntry.
  ///
  /// In en, this message translates to:
  /// **'Failed to save journal entry.'**
  String get failedToSaveJournalEntry;

  /// No description provided for @mySpaceJournalTitle.
  ///
  /// In en, this message translates to:
  /// **'My Space Journal'**
  String get mySpaceJournalTitle;

  /// No description provided for @noJournalEntriesYet.
  ///
  /// In en, this message translates to:
  /// **'No journal entries yet.'**
  String get noJournalEntriesYet;

  /// No description provided for @entryCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Entry cannot be empty.'**
  String get entryCannotBeEmpty;

  /// No description provided for @newEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntryTitle;

  /// No description provided for @promptsLabel.
  ///
  /// In en, this message translates to:
  /// **'Prompts'**
  String get promptsLabel;

  /// No description provided for @startWritingHint.
  ///
  /// In en, this message translates to:
  /// **'Start writing...'**
  String get startWritingHint;

  /// No description provided for @mySpaceLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'My Space Library'**
  String get mySpaceLibraryTitle;

  /// No description provided for @savedResourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Resources'**
  String get savedResourcesTitle;

  /// No description provided for @guidedBreathingVideo.
  ///
  /// In en, this message translates to:
  /// **'Guided breathing video'**
  String get guidedBreathingVideo;

  /// No description provided for @calmingAudio.
  ///
  /// In en, this message translates to:
  /// **'Calming audio'**
  String get calmingAudio;

  /// No description provided for @savedMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Messages'**
  String get savedMessagesTitle;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingLabel;

  /// No description provided for @noSavedMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No saved messages yet.'**
  String get noSavedMessagesYet;

  /// No description provided for @contactsLabel.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsLabel;

  /// No description provided for @therapistLabel.
  ///
  /// In en, this message translates to:
  /// **'Therapist'**
  String get therapistLabel;

  /// No description provided for @trustedFriendLabel.
  ///
  /// In en, this message translates to:
  /// **'Trusted friend'**
  String get trustedFriendLabel;

  /// No description provided for @promptComfortToday.
  ///
  /// In en, this message translates to:
  /// **'What is one thing that brought you comfort today?'**
  String get promptComfortToday;

  /// No description provided for @promptBodyMorning.
  ///
  /// In en, this message translates to:
  /// **'How did your body feel this morning?'**
  String get promptBodyMorning;

  /// No description provided for @promptThreeGrateful.
  ///
  /// In en, this message translates to:
  /// **'Name three things you are grateful for.'**
  String get promptThreeGrateful;

  /// No description provided for @promptEmotionColor.
  ///
  /// In en, this message translates to:
  /// **'If your emotions were a color, what would it be?'**
  String get promptEmotionColor;

  /// No description provided for @promptFutureSelf.
  ///
  /// In en, this message translates to:
  /// **'Write a short note to your future self.'**
  String get promptFutureSelf;

  /// No description provided for @deleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get deleteAccountDialogTitle;

  /// No description provided for @deleteAccountDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account and app data. This action cannot be undone.'**
  String get deleteAccountDialogBody;

  /// No description provided for @deleteAccountActionLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountActionLabel;

  /// No description provided for @confirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmLabel;

  /// No description provided for @deleteAccountRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Please log in again, then retry account deletion.'**
  String get deleteAccountRequiresRecentLogin;

  /// No description provided for @deleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account.'**
  String get deleteAccountFailed;

  /// No description provided for @deleteAccountSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account and app data.'**
  String get deleteAccountSettingsSubtitle;

  /// No description provided for @careCornerTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Care Corner'**
  String get careCornerTabLabel;

  /// No description provided for @careCornerWellbeingTitle.
  ///
  /// In en, this message translates to:
  /// **'Wellbeing'**
  String get careCornerWellbeingTitle;

  /// No description provided for @careCornerSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support & Services'**
  String get careCornerSupportTitle;

  /// No description provided for @careCornerEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get careCornerEducationTitle;

  /// No description provided for @careCornerHubSuffixWellbeing.
  ///
  /// In en, this message translates to:
  /// **'Wellbeing Hub'**
  String get careCornerHubSuffixWellbeing;

  /// No description provided for @careCornerHubSuffixSupport.
  ///
  /// In en, this message translates to:
  /// **'Support Hub'**
  String get careCornerHubSuffixSupport;

  /// No description provided for @careCornerHubSuffixEducation.
  ///
  /// In en, this message translates to:
  /// **'Education Hub'**
  String get careCornerHubSuffixEducation;

  /// No description provided for @careCornerBackToHubLabel.
  ///
  /// In en, this message translates to:
  /// **'Back to Hub'**
  String get careCornerBackToHubLabel;

  /// No description provided for @careCornerBackLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get careCornerBackLabel;

  /// No description provided for @careCornerFurtherReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Further Reading & Deep Dive'**
  String get careCornerFurtherReadingTitle;

  /// No description provided for @careCornerFreeBadge.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get careCornerFreeBadge;

  /// No description provided for @careCornerResourceNotice.
  ///
  /// In en, this message translates to:
  /// **'Resource details and local contacts are organized by country and topic.'**
  String get careCornerResourceNotice;

  /// No description provided for @careCornerLocalSupportCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Local support center'**
  String get careCornerLocalSupportCenterTitle;

  /// No description provided for @careCornerContactInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get careCornerContactInfoDescription;

  /// No description provided for @careCornerActionCall.
  ///
  /// In en, this message translates to:
  /// **'CALL'**
  String get careCornerActionCall;

  /// No description provided for @careCornerActionCallNow.
  ///
  /// In en, this message translates to:
  /// **'CALL NOW'**
  String get careCornerActionCallNow;

  /// No description provided for @careCornerActionSecureChat.
  ///
  /// In en, this message translates to:
  /// **'SECURE CHAT'**
  String get careCornerActionSecureChat;

  /// No description provided for @careCornerActionVisitWebsite.
  ///
  /// In en, this message translates to:
  /// **'VISIT WEBSITE'**
  String get careCornerActionVisitWebsite;

  /// No description provided for @careCornerActionEmail.
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get careCornerActionEmail;

  /// No description provided for @careCornerActionScheduleCall.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE CALL'**
  String get careCornerActionScheduleCall;

  /// No description provided for @careCornerActionBookAppointment.
  ///
  /// In en, this message translates to:
  /// **'BOOK APPOINTMENT'**
  String get careCornerActionBookAppointment;

  /// No description provided for @careCornerTopicBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing Exercises'**
  String get careCornerTopicBreathing;

  /// No description provided for @careCornerTopicMeditation.
  ///
  /// In en, this message translates to:
  /// **'Guided Meditation'**
  String get careCornerTopicMeditation;

  /// No description provided for @careCornerTopicMusic.
  ///
  /// In en, this message translates to:
  /// **'Music Sessions'**
  String get careCornerTopicMusic;

  /// No description provided for @careCornerTopicJournaling.
  ///
  /// In en, this message translates to:
  /// **'Journaling Prompts'**
  String get careCornerTopicJournaling;

  /// No description provided for @careCornerTopicSelfCare.
  ///
  /// In en, this message translates to:
  /// **'Self-Care Routines'**
  String get careCornerTopicSelfCare;

  /// No description provided for @careCornerTopicColorTheory.
  ///
  /// In en, this message translates to:
  /// **'Color Theory Videos'**
  String get careCornerTopicColorTheory;

  /// No description provided for @careCornerTopicViolenceProtection.
  ///
  /// In en, this message translates to:
  /// **'Violence & Protection'**
  String get careCornerTopicViolenceProtection;

  /// No description provided for @careCornerTopicLegalHelp.
  ///
  /// In en, this message translates to:
  /// **'Legal Help'**
  String get careCornerTopicLegalHelp;

  /// No description provided for @careCornerTopicHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Healthcare Access'**
  String get careCornerTopicHealthcare;

  /// No description provided for @careCornerTopicSupportGroups.
  ///
  /// In en, this message translates to:
  /// **'Support Groups'**
  String get careCornerTopicSupportGroups;

  /// No description provided for @careCornerTopicEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency Services'**
  String get careCornerTopicEmergency;

  /// No description provided for @careCornerTopicLocalNgos.
  ///
  /// In en, this message translates to:
  /// **'Local NGOs'**
  String get careCornerTopicLocalNgos;

  /// No description provided for @careCornerTopicDiscrimination.
  ///
  /// In en, this message translates to:
  /// **'Discrimination'**
  String get careCornerTopicDiscrimination;

  /// No description provided for @careCornerTopicRacism.
  ///
  /// In en, this message translates to:
  /// **'Racism'**
  String get careCornerTopicRacism;

  /// No description provided for @careCornerTopicAntigypsyism.
  ///
  /// In en, this message translates to:
  /// **'Antigypsyism'**
  String get careCornerTopicAntigypsyism;

  /// No description provided for @careCornerTopicHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate Speech Online'**
  String get careCornerTopicHateSpeech;

  /// No description provided for @careCornerTopicXenophobia.
  ///
  /// In en, this message translates to:
  /// **'Xenophobia'**
  String get careCornerTopicXenophobia;

  /// No description provided for @careCornerTopicMyRights.
  ///
  /// In en, this message translates to:
  /// **'My Rights'**
  String get careCornerTopicMyRights;

  /// No description provided for @careCornerFurtherReadingIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity & Belonging'**
  String get careCornerFurtherReadingIdentity;

  /// No description provided for @careCornerFurtherReadingDiscriminationSupport.
  ///
  /// In en, this message translates to:
  /// **'Discrimination Support'**
  String get careCornerFurtherReadingDiscriminationSupport;

  /// No description provided for @careCornerFurtherReadingSeekHelp.
  ///
  /// In en, this message translates to:
  /// **'When to Seek Help'**
  String get careCornerFurtherReadingSeekHelp;

  /// No description provided for @careCornerCountryRomania.
  ///
  /// In en, this message translates to:
  /// **'Romania'**
  String get careCornerCountryRomania;

  /// No description provided for @careCornerCountrySerbia.
  ///
  /// In en, this message translates to:
  /// **'Serbia'**
  String get careCornerCountrySerbia;

  /// No description provided for @careCornerCountryGreece.
  ///
  /// In en, this message translates to:
  /// **'Greece'**
  String get careCornerCountryGreece;

  /// No description provided for @careCornerCountryNorthMacedonia.
  ///
  /// In en, this message translates to:
  /// **'North Macedonia'**
  String get careCornerCountryNorthMacedonia;

  /// No description provided for @careCornerCountryGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get careCornerCountryGermany;

  /// No description provided for @careCornerCountryTurkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get careCornerCountryTurkey;

  /// No description provided for @careCornerCountryEuropeanUnion.
  ///
  /// In en, this message translates to:
  /// **'European Union'**
  String get careCornerCountryEuropeanUnion;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsTitle;

  /// No description provided for @termsEffectiveDate.
  ///
  /// In en, this message translates to:
  /// **'Effective date: {date}'**
  String termsEffectiveDate(Object date);

  /// No description provided for @termsIntro.
  ///
  /// In en, this message translates to:
  /// **'These Terms govern your use of {appName}. By creating an account or using the app, you agree to these Terms.'**
  String termsIntro(Object appName);

  /// No description provided for @termsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Eligibility and Accounts'**
  String get termsSection1Title;

  /// No description provided for @termsSection1Bullet1.
  ///
  /// In en, this message translates to:
  /// **'You must provide accurate registration details and keep your credentials secure.'**
  String get termsSection1Bullet1;

  /// No description provided for @termsSection1Bullet2.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for activity under your account.'**
  String get termsSection1Bullet2;

  /// No description provided for @termsSection1Bullet3.
  ///
  /// In en, this message translates to:
  /// **'You may not impersonate another person or misuse the platform.'**
  String get termsSection1Bullet3;

  /// No description provided for @termsSection1Bullet4.
  ///
  /// In en, this message translates to:
  /// **'Users under 16 may use the app only with parent or legal guardian consent, and only where permitted by applicable law.'**
  String get termsSection1Bullet4;

  /// No description provided for @termsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. What the App Provides'**
  String get termsSection2Title;

  /// No description provided for @termsSection2Bullet1.
  ///
  /// In en, this message translates to:
  /// **'Mood drawing check-ins, body awareness tools, guided reflection content, messages, and journaling/library features.'**
  String get termsSection2Bullet1;

  /// No description provided for @termsSection2Bullet2.
  ///
  /// In en, this message translates to:
  /// **'The app supports emotional wellbeing and self-reflection.'**
  String get termsSection2Bullet2;

  /// No description provided for @termsSection2Bullet3.
  ///
  /// In en, this message translates to:
  /// **'The app is not a crisis service and not a substitute for medical, psychiatric, or emergency care.'**
  String get termsSection2Bullet3;

  /// No description provided for @termsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Health and Safety Disclaimer'**
  String get termsSection3Title;

  /// No description provided for @termsSection3Bullet1.
  ///
  /// In en, this message translates to:
  /// **'No content in the app is medical advice, diagnosis, or treatment.'**
  String get termsSection3Bullet1;

  /// No description provided for @termsSection3Bullet2.
  ///
  /// In en, this message translates to:
  /// **'If you are in danger or experiencing an emergency, contact local emergency services immediately.'**
  String get termsSection3Bullet2;

  /// No description provided for @termsSection3Bullet3.
  ///
  /// In en, this message translates to:
  /// **'If an exercise causes discomfort, stop and seek professional support.'**
  String get termsSection3Bullet3;

  /// No description provided for @termsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. User Content'**
  String get termsSection4Title;

  /// No description provided for @termsSection4Bullet1.
  ///
  /// In en, this message translates to:
  /// **'You retain ownership of content you create (e.g., drawings, body maps, notes, journal entries).'**
  String get termsSection4Bullet1;

  /// No description provided for @termsSection4Bullet2.
  ///
  /// In en, this message translates to:
  /// **'You grant {companyName} a limited license to store/process your content only to operate and improve the service.'**
  String termsSection4Bullet2(Object companyName);

  /// No description provided for @termsSection4Bullet3.
  ///
  /// In en, this message translates to:
  /// **'You must not upload unlawful, abusive, or infringing material.'**
  String get termsSection4Bullet3;

  /// No description provided for @termsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Acceptable Use'**
  String get termsSection5Title;

  /// No description provided for @termsSection5Bullet1.
  ///
  /// In en, this message translates to:
  /// **'Do not attempt unauthorized access, reverse engineer, disrupt, or overload services.'**
  String get termsSection5Bullet1;

  /// No description provided for @termsSection5Bullet2.
  ///
  /// In en, this message translates to:
  /// **'Do not use the app to harass, threaten, or exploit others.'**
  String get termsSection5Bullet2;

  /// No description provided for @termsSection5Bullet3.
  ///
  /// In en, this message translates to:
  /// **'Do not bypass account, usage, or security restrictions.'**
  String get termsSection5Bullet3;

  /// No description provided for @termsSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Data and Privacy'**
  String get termsSection6Title;

  /// No description provided for @termsSection6Bullet1.
  ///
  /// In en, this message translates to:
  /// **'We process account/profile data and activity data needed for app features (e.g., daily check-ins, messages, saved entries, media playback).'**
  String get termsSection6Bullet1;

  /// No description provided for @termsSection6Bullet2.
  ///
  /// In en, this message translates to:
  /// **'Data is stored using Firebase services configured for the app.'**
  String get termsSection6Bullet2;

  /// No description provided for @termsSection6Bullet3.
  ///
  /// In en, this message translates to:
  /// **'Your privacy rights and retention/deletion details are described in our Privacy Policy.'**
  String get termsSection6Bullet3;

  /// No description provided for @termsSection6Bullet4.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy: {url}'**
  String termsSection6Bullet4(Object url);

  /// No description provided for @termsSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Third-Party Services'**
  String get termsSection7Title;

  /// No description provided for @termsSection7Bullet1.
  ///
  /// In en, this message translates to:
  /// **'Authentication, storage, and database features rely on third-party providers (e.g., Google/Firebase).'**
  String get termsSection7Bullet1;

  /// No description provided for @termsSection7Bullet2.
  ///
  /// In en, this message translates to:
  /// **'Use of those integrations may also be subject to third-party terms.'**
  String get termsSection7Bullet2;

  /// No description provided for @termsSection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Intellectual Property'**
  String get termsSection8Title;

  /// No description provided for @termsSection8Bullet1.
  ///
  /// In en, this message translates to:
  /// **'All app branding, design, and non-user content are owned by {companyName} or licensed to it.'**
  String termsSection8Bullet1(Object companyName);

  /// No description provided for @termsSection8Bullet2.
  ///
  /// In en, this message translates to:
  /// **'You may not copy, distribute, or commercialize app materials without permission.'**
  String get termsSection8Bullet2;

  /// No description provided for @termsSection9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Suspension and Termination'**
  String get termsSection9Title;

  /// No description provided for @termsSection9Bullet1.
  ///
  /// In en, this message translates to:
  /// **'We may suspend or terminate accounts for violations, abuse, security risks, or legal obligations.'**
  String get termsSection9Bullet1;

  /// No description provided for @termsSection9Bullet2.
  ///
  /// In en, this message translates to:
  /// **'You may stop using the app at any time.'**
  String get termsSection9Bullet2;

  /// No description provided for @termsSection10Title.
  ///
  /// In en, this message translates to:
  /// **'10. Warranties and Liability'**
  String get termsSection10Title;

  /// No description provided for @termsSection10Bullet1.
  ///
  /// In en, this message translates to:
  /// **'The service is provided \"as is\" and \"as available\".'**
  String get termsSection10Bullet1;

  /// No description provided for @termsSection10Bullet2.
  ///
  /// In en, this message translates to:
  /// **'To the fullest extent allowed by law, {companyName} disclaims implied warranties.'**
  String termsSection10Bullet2(Object companyName);

  /// No description provided for @termsSection10Bullet3.
  ///
  /// In en, this message translates to:
  /// **'To the fullest extent allowed by law, {companyName} is not liable for indirect, incidental, or consequential damages.'**
  String termsSection10Bullet3(Object companyName);

  /// No description provided for @termsSection11Title.
  ///
  /// In en, this message translates to:
  /// **'11. Changes to These Terms'**
  String get termsSection11Title;

  /// No description provided for @termsSection11Bullet1.
  ///
  /// In en, this message translates to:
  /// **'We may update these Terms from time to time.'**
  String get termsSection11Bullet1;

  /// No description provided for @termsSection11Bullet2.
  ///
  /// In en, this message translates to:
  /// **'If changes are material, we will provide reasonable notice in-app or by email.'**
  String get termsSection11Bullet2;

  /// No description provided for @termsSection11Bullet3.
  ///
  /// In en, this message translates to:
  /// **'Continued use after updates means you accept the updated Terms.'**
  String get termsSection11Bullet3;

  /// No description provided for @termsSection12Title.
  ///
  /// In en, this message translates to:
  /// **'12. Governing Law'**
  String get termsSection12Title;

  /// No description provided for @termsSection12Bullet1.
  ///
  /// In en, this message translates to:
  /// **'These Terms are governed by the laws of {country}, without regard to conflict-of-law rules.'**
  String termsSection12Bullet1(Object country);

  /// No description provided for @termsSection13Title.
  ///
  /// In en, this message translates to:
  /// **'13. Contact'**
  String get termsSection13Title;

  /// No description provided for @termsSection13Bullet1.
  ///
  /// In en, this message translates to:
  /// **'For support or legal requests, contact: {email}'**
  String termsSection13Bullet1(Object email);

  /// No description provided for @termsImportantNote.
  ///
  /// In en, this message translates to:
  /// **'Important: please confirm legal counsel review before release.'**
  String get termsImportantNote;

  /// No description provided for @avatarUpdated.
  ///
  /// In en, this message translates to:
  /// **'Avatar updated.'**
  String get avatarUpdated;

  /// No description provided for @avatarUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update avatar.'**
  String get avatarUpdateFailed;

  /// No description provided for @avatarRemoved.
  ///
  /// In en, this message translates to:
  /// **'Avatar removed.'**
  String get avatarRemoved;

  /// No description provided for @avatarRemoveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove avatar.'**
  String get avatarRemoveFailed;

  /// No description provided for @nameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Name updated.'**
  String get nameUpdated;

  /// No description provided for @nameUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update name.'**
  String get nameUpdateFailed;

  /// No description provided for @editNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editNameTitle;

  /// No description provided for @passwordMustBeAtLeast8.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get passwordMustBeAtLeast8;

  /// No description provided for @passwordRequirementsSummary.
  ///
  /// In en, this message translates to:
  /// **'Use 1 uppercase, 1 number, and 1 special character.'**
  String get passwordRequirementsSummary;

  /// No description provided for @emailUnchanged.
  ///
  /// In en, this message translates to:
  /// **'Email is unchanged.'**
  String get emailUnchanged;

  /// No description provided for @verificationEmailSentNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent to the new address.'**
  String get verificationEmailSentNewAddress;

  /// No description provided for @reauthenticateToUpdateEmail.
  ///
  /// In en, this message translates to:
  /// **'Re-authenticate to update email'**
  String get reauthenticateToUpdateEmail;

  /// No description provided for @reauthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Re-authentication failed.'**
  String get reauthenticationFailed;

  /// No description provided for @emailUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update email.'**
  String get emailUpdateFailed;

  /// No description provided for @editEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit email'**
  String get editEmailTitle;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get passwordUpdated;

  /// No description provided for @reauthenticateToUpdatePassword.
  ///
  /// In en, this message translates to:
  /// **'Re-authenticate to update password'**
  String get reauthenticateToUpdatePassword;

  /// No description provided for @passwordUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update password.'**
  String get passwordUpdateFailed;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePasswordTitle;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// No description provided for @passwordRequirementsSummaryShort.
  ///
  /// In en, this message translates to:
  /// **'Min 8 chars, 1 uppercase, 1 number, 1 special.'**
  String get passwordRequirementsSummaryShort;

  /// No description provided for @takePhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhotoLabel;

  /// No description provided for @chooseFromGalleryLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGalleryLabel;

  /// No description provided for @chooseAvatarLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose avatar'**
  String get chooseAvatarLabel;

  /// No description provided for @avatarPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your avatar'**
  String get avatarPickerTitle;

  /// No description provided for @removePhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhotoLabel;

  /// No description provided for @notificationsOffSummary.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off.'**
  String get notificationsOffSummary;

  /// No description provided for @notificationsDailyAndInactiveSummary.
  ///
  /// In en, this message translates to:
  /// **'Daily at {hour}:{minute} and 7-day inactivity reminders.'**
  String notificationsDailyAndInactiveSummary(Object hour, Object minute);

  /// No description provided for @notificationsDailyOnlySummary.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder at {hour}:{minute}.'**
  String notificationsDailyOnlySummary(Object hour, Object minute);

  /// No description provided for @notificationsInactiveOnlySummary.
  ///
  /// In en, this message translates to:
  /// **'Only 7-day inactivity reminders.'**
  String get notificationsInactiveOnlySummary;

  /// No description provided for @dailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminderTitle;

  /// No description provided for @dailyReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send a daily morning push.'**
  String get dailyReminderSubtitle;

  /// No description provided for @reminderTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTimeTitle;

  /// No description provided for @inactiveReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Inactive reminder'**
  String get inactiveReminderTitle;

  /// No description provided for @inactiveReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send a reminder after 7 days away.'**
  String get inactiveReminderSubtitle;

  /// No description provided for @notificationPreferencesSaved.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences saved.'**
  String get notificationPreferencesSaved;

  /// No description provided for @notificationPreferencesSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save notification preferences.'**
  String get notificationPreferencesSaveFailed;

  /// No description provided for @accountSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSectionTitle;

  /// No description provided for @profilePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilePhotoTitle;

  /// No description provided for @profilePhotoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or remove your avatar.'**
  String get profilePhotoSubtitle;

  /// No description provided for @displayNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayNameTitle;

  /// No description provided for @unknownValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownValueLabel;

  /// No description provided for @passwordUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your password.'**
  String get passwordUpdateSubtitle;

  /// No description provided for @passwordManagedByProviderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Managed by your sign-in provider.'**
  String get passwordManagedByProviderSubtitle;

  /// No description provided for @appSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get appSectionTitle;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystemLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLightLabel;

  /// No description provided for @themeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDarkLabel;

  /// No description provided for @cookieMonsterTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the Exercise'**
  String get cookieMonsterTitle;

  /// No description provided for @cookieMonsterJoinPrompt.
  ///
  /// In en, this message translates to:
  /// **'Join me, would you?'**
  String get cookieMonsterJoinPrompt;

  /// No description provided for @joinLabel.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get joinLabel;

  /// No description provided for @cookieMonsterOutsidePrompt.
  ///
  /// In en, this message translates to:
  /// **'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?'**
  String get cookieMonsterOutsidePrompt;

  /// No description provided for @reflectLabel.
  ///
  /// In en, this message translates to:
  /// **'Reflect'**
  String get reflectLabel;

  /// No description provided for @experienceFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'How was this experience for you?'**
  String get experienceFeedbackTitle;

  /// No description provided for @experienceFeedbackPositive.
  ///
  /// In en, this message translates to:
  /// **'Positive: dance'**
  String get experienceFeedbackPositive;

  /// No description provided for @experienceFeedbackNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral: meeeehhhhhh'**
  String get experienceFeedbackNeutral;

  /// No description provided for @experienceFeedbackNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative: fall down'**
  String get experienceFeedbackNegative;

  /// No description provided for @selectBodyAreaFirst.
  ///
  /// In en, this message translates to:
  /// **'Select a body area first.'**
  String get selectBodyAreaFirst;

  /// No description provided for @noClipFound.
  ///
  /// In en, this message translates to:
  /// **'No clip found for \"{activityKey}\".'**
  String noClipFound(Object activityKey);

  /// No description provided for @failedToLoadMonsterClip.
  ///
  /// In en, this message translates to:
  /// **'Failed to load monster clip: {error}'**
  String failedToLoadMonsterClip(Object error);

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorLabel;

  /// No description provided for @tapBodyToLogSensation.
  ///
  /// In en, this message translates to:
  /// **'Tap the body to log a sensation.'**
  String get tapBodyToLogSensation;

  /// No description provided for @failedToSaveBodyAwarenessWithCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to save body awareness: {code}.'**
  String failedToSaveBodyAwarenessWithCode(Object code);

  /// No description provided for @failedToSaveBodyAwareness.
  ///
  /// In en, this message translates to:
  /// **'Failed to save body awareness.'**
  String get failedToSaveBodyAwareness;

  /// No description provided for @stepSkipped.
  ///
  /// In en, this message translates to:
  /// **'Step skipped.'**
  String get stepSkipped;

  /// No description provided for @bodyAwarenessPrompt.
  ///
  /// In en, this message translates to:
  /// **'Where does this feeling seem to rest in your body?\nPlease touch that spot and select a color that feels true to the sensation.'**
  String get bodyAwarenessPrompt;

  /// No description provided for @exerciseInstructionWillYouJoin.
  ///
  /// In en, this message translates to:
  /// **'Would you like to join Cookie Monster for a short exercise?'**
  String get exerciseInstructionWillYouJoin;

  /// No description provided for @exerciseInstructionOutsideTheBody.
  ///
  /// In en, this message translates to:
  /// **'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?'**
  String get exerciseInstructionOutsideTheBody;

  /// No description provided for @exerciseInstructionForeheadContact.
  ///
  /// In en, this message translates to:
  /// **'Forehead Contact:\nPlace your palm on your forehead, hold for a few seconds, and relax with your breath.'**
  String get exerciseInstructionForeheadContact;

  /// No description provided for @exerciseInstructionSlowBreathing.
  ///
  /// In en, this message translates to:
  /// **'Close Eyes - Breath Tracking:\nClose your eyes, inhale slowly through your nose, and exhale in 4 seconds (repeat 5 times).'**
  String get exerciseInstructionSlowBreathing;

  /// No description provided for @exerciseInstructionWeightOfHead.
  ///
  /// In en, this message translates to:
  /// **'Feel the Weight of Your Head:\nGently tilt your head forward, notice neck tension, and relax it.'**
  String get exerciseInstructionWeightOfHead;

  /// No description provided for @exerciseInstructionBreathing478.
  ///
  /// In en, this message translates to:
  /// **'4-7-8 Breathing:\nInhale for 4 seconds, hold for 7, exhale for 8 (3 cycles).'**
  String get exerciseInstructionBreathing478;

  /// No description provided for @exerciseInstructionAbdominalAwareness.
  ///
  /// In en, this message translates to:
  /// **'Abdominal Awareness:\nPlace your hand on your abdomen and feel it rise and fall with each breath.'**
  String get exerciseInstructionAbdominalAwareness;

  /// No description provided for @exerciseInstructionHeartCenter.
  ///
  /// In en, this message translates to:
  /// **'Heart Center Opening:\nMove your chest forward, pull shoulders back, and breathe deeply.'**
  String get exerciseInstructionHeartCenter;

  /// No description provided for @exerciseInstructionBallSqueezing.
  ///
  /// In en, this message translates to:
  /// **'Ball Squeezing:\nSlowly squeeze and release your palm (10 repetitions).'**
  String get exerciseInstructionBallSqueezing;

  /// No description provided for @exerciseInstructionFingerMeditation.
  ///
  /// In en, this message translates to:
  /// **'Finger Meditation:\nTouch each finger with your thumb one by one, exhaling with every touch.'**
  String get exerciseInstructionFingerMeditation;

  /// No description provided for @exerciseInstructionHandMassage.
  ///
  /// In en, this message translates to:
  /// **'Hand Massage:\nMassage the center of your palm with your thumb in small circles (30 seconds each hand).'**
  String get exerciseInstructionHandMassage;

  /// No description provided for @exerciseInstructionShoulderDrop.
  ///
  /// In en, this message translates to:
  /// **'Shoulder Drop:\nRaise shoulders toward ears, then release (5 repetitions).'**
  String get exerciseInstructionShoulderDrop;

  /// No description provided for @exerciseInstructionBackOpening.
  ///
  /// In en, this message translates to:
  /// **'Back Opening:\nClasp hands behind you, open the chest, and take a deep breath.'**
  String get exerciseInstructionBackOpening;

  /// No description provided for @exerciseInstructionReleasingBurdens.
  ///
  /// In en, this message translates to:
  /// **'Releasing Burdens:\nWith eyes closed, imagine a warm light flowing down from your shoulders.'**
  String get exerciseInstructionReleasingBurdens;

  /// No description provided for @exerciseInstructionRelaxingFacialMuscles.
  ///
  /// In en, this message translates to:
  /// **'Relaxing Facial Muscles:\nClose eyes, tighten facial muscles, then release (3 repetitions).'**
  String get exerciseInstructionRelaxingFacialMuscles;

  /// No description provided for @exerciseInstructionJawDrop.
  ///
  /// In en, this message translates to:
  /// **'Jaw Drop:\nSlightly open your mouth, relax jaw for 5 seconds, then close it.'**
  String get exerciseInstructionJawDrop;

  /// No description provided for @exerciseInstructionSmileToYourself.
  ///
  /// In en, this message translates to:
  /// **'Smile to Yourself:\nHold a gentle smile for 30 seconds.'**
  String get exerciseInstructionSmileToYourself;

  /// No description provided for @exerciseInstructionEftTappingPoints.
  ///
  /// In en, this message translates to:
  /// **'EFT Tapping Points:\nTap each point 5-7 times: eyebrow start, side of eye, under eye, under nose, chin, collarbone, under arm, top of head.'**
  String get exerciseInstructionEftTappingPoints;

  /// No description provided for @exerciseInstructionRisingOnTiptoes.
  ///
  /// In en, this message translates to:
  /// **'Rising on Tiptoes:\nLift heels as you exhale, hold 3-5 seconds, lower slowly, and repeat 5-10 times.'**
  String get exerciseInstructionRisingOnTiptoes;

  /// No description provided for @singleClipUrlMissing.
  ///
  /// In en, this message translates to:
  /// **'Single clip URL is missing.'**
  String get singleClipUrlMissing;

  /// No description provided for @exerciseClipsMissing.
  ///
  /// In en, this message translates to:
  /// **'Exercise clips are missing.'**
  String get exerciseClipsMissing;

  /// No description provided for @videoPlayerInitializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Video player failed to initialize. Please fully restart the app.'**
  String get videoPlayerInitializationFailed;

  /// No description provided for @failedToPlayOutroClip.
  ///
  /// In en, this message translates to:
  /// **'Failed to play outro clip.'**
  String get failedToPlayOutroClip;

  /// No description provided for @finishExerciseLabel.
  ///
  /// In en, this message translates to:
  /// **'Finish exercise'**
  String get finishExerciseLabel;

  /// No description provided for @startExerciseLabel.
  ///
  /// In en, this message translates to:
  /// **'Start exercise'**
  String get startExerciseLabel;

  /// No description provided for @feedbackQuestionLabel.
  ///
  /// In en, this message translates to:
  /// **'How was this experience for you?'**
  String get feedbackQuestionLabel;

  /// No description provided for @feedbackVeryGood.
  ///
  /// In en, this message translates to:
  /// **'Very Good'**
  String get feedbackVeryGood;

  /// No description provided for @feedbackGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get feedbackGood;

  /// No description provided for @feedbackMeh.
  ///
  /// In en, this message translates to:
  /// **'Meh'**
  String get feedbackMeh;

  /// No description provided for @feedbackNotGood.
  ///
  /// In en, this message translates to:
  /// **'Not Good'**
  String get feedbackNotGood;

  /// No description provided for @feedbackAwful.
  ///
  /// In en, this message translates to:
  /// **'Awful'**
  String get feedbackAwful;

  /// No description provided for @feedbackDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get feedbackDoneLabel;

  /// No description provided for @careCornerEuNationalPrompt.
  ///
  /// In en, this message translates to:
  /// **'For country-specific support and services, please also visit your national bubble.'**
  String get careCornerEuNationalPrompt;

  /// No description provided for @euDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Funded by the European Union. Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Education and Culture Executive Agency (EACEA). Neither the European Union nor EACEA can be held responsible for them.'**
  String get euDisclaimer;

  /// No description provided for @externalLinkWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaving the app'**
  String get externalLinkWarningTitle;

  /// No description provided for @externalLinkWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'You are about to open an external website. We are not responsible for the content of external sites.'**
  String get externalLinkWarningMessage;

  /// No description provided for @externalLinkCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get externalLinkCancel;

  /// No description provided for @externalLinkContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get externalLinkContinue;

  /// No description provided for @careCornerNotAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Not yet available'**
  String get careCornerNotAvailableMessage;

  /// No description provided for @messageAlreadyOpenedToday.
  ///
  /// In en, this message translates to:
  /// **'You already opened today\'s message. Come back tomorrow!'**
  String get messageAlreadyOpenedToday;

  /// No description provided for @libraryResourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get libraryResourcesTitle;

  /// No description provided for @savedToResources.
  ///
  /// In en, this message translates to:
  /// **'Saved to Resources'**
  String get savedToResources;

  /// No description provided for @noSavedResourcesYet.
  ///
  /// In en, this message translates to:
  /// **'No saved resources yet.'**
  String get noSavedResourcesYet;

  /// No description provided for @messageOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the message. Please check your connection and try again.'**
  String get messageOpenFailed;

  /// No description provided for @genericLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load. Please check your connection and try again.'**
  String get genericLoadFailed;

  /// No description provided for @genericSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save. Please try again.'**
  String get genericSaveFailed;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @careCornerActionReference.
  ///
  /// In en, this message translates to:
  /// **'REFERENCE'**
  String get careCornerActionReference;

  /// No description provided for @genericDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete. Please try again.'**
  String get genericDeleteFailed;

  /// No description provided for @reportLabel.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportLabel;

  /// No description provided for @reportMessageAction.
  ///
  /// In en, this message translates to:
  /// **'Report message'**
  String get reportMessageAction;

  /// No description provided for @reportMessageConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Report this message to the moderators?'**
  String get reportMessageConfirmBody;

  /// No description provided for @reportMessageSent.
  ///
  /// In en, this message translates to:
  /// **'Thank you. The message was reported.'**
  String get reportMessageSent;

  /// No description provided for @reportMessageFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t send the report. Please try again.'**
  String get reportMessageFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'el',
    'en',
    'mk',
    'ro',
    'rom',
    'sr',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'mk':
      return AppLocalizationsMk();
    case 'ro':
      return AppLocalizationsRo();
    case 'rom':
      return AppLocalizationsRom();
    case 'sr':
      return AppLocalizationsSr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
