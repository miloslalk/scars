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
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
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
  /// **'Would you like to take a moment to gently tune into the physical sensations in your body before identifying your feeling?'**
  String get bodyTransitionPrompt;

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
  /// **'You are allowed to take this day one breath at a time.'**
  String get dailyAffirmation1;

  /// No description provided for @dailyAffirmation2.
  ///
  /// In en, this message translates to:
  /// **'Your feelings matter, and your body deserves gentle care.'**
  String get dailyAffirmation2;

  /// No description provided for @dailyAffirmation3.
  ///
  /// In en, this message translates to:
  /// **'You are stronger than this moment feels right now.'**
  String get dailyAffirmation3;

  /// No description provided for @dailyAffirmation4.
  ///
  /// In en, this message translates to:
  /// **'Small steps today are still meaningful progress.'**
  String get dailyAffirmation4;

  /// No description provided for @dailyAffirmation5.
  ///
  /// In en, this message translates to:
  /// **'You belong exactly as you are, here and now.'**
  String get dailyAffirmation5;

  /// No description provided for @dailyAffirmation6.
  ///
  /// In en, this message translates to:
  /// **'Your voice, your pace, and your healing all count.'**
  String get dailyAffirmation6;

  /// No description provided for @dailyAffirmation7.
  ///
  /// In en, this message translates to:
  /// **'You can rest and still be growing.'**
  String get dailyAffirmation7;

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
  /// **'Quote'**
  String get quoteLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @noQuoteForDay.
  ///
  /// In en, this message translates to:
  /// **'No quote saved for this day.'**
  String get noQuoteForDay;

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
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'sr':
      {
        switch (locale.scriptCode) {
          case 'Latn':
            return AppLocalizationsSrLatn();
        }
        break;
      }
  }

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
