// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'When Scars (!) Become Art';

  @override
  String get loginWith => 'Најави се со:';

  @override
  String get loginWithGoogle => 'Најави се со Google';

  @override
  String get loginWithApple => 'Најави се со Apple';

  @override
  String get loginWithFacebook => 'Најави се со Facebook';

  @override
  String get orLoginWithUsernameAndPassword =>
      'Или најави се со корисничко име и лозинка';

  @override
  String get usernameLabel => 'Корисничко име';

  @override
  String get passwordLabel => 'Лозинка';

  @override
  String get loginButton => 'Најави се';

  @override
  String get loadingCredentials => 'Се вчитуваат податоци за најава...';

  @override
  String get unableToLoadCredentials =>
      'Не може да се вчитаат податоците за најава';

  @override
  String get invalidCredentials => 'Невалидни податоци за најава';

  @override
  String get homeLabel => 'Дома';

  @override
  String get profileLabel => 'Профил';

  @override
  String get galleryLabel => 'Галерија';

  @override
  String get settingsLabel => 'Поставки';

  @override
  String get helpLabel => 'Помош';

  @override
  String get profilePageTitle => 'Страница на профил';

  @override
  String get profilePageBody =>
      'Тука можете да ги видите и уредите вашите податоци.';

  @override
  String get galleryTitle => 'Галерија';

  @override
  String get galleryBody =>
      'Прелистајте ја вашата галерија со фотографии овде.';

  @override
  String get settingsTitle => 'Поставки';

  @override
  String get settingsBody => 'Управувајте со поставките на апликацијата овде.';

  @override
  String get helpTitle => 'Помош и поддршка';

  @override
  String get helpBody => 'Добијте помош и поддршка овде.';

  @override
  String get settingsPreferencesTitle => 'Преференции';

  @override
  String get settingsPreferencesBody =>
      'Прилагодете го искуството во апликацијата.';

  @override
  String get settingsNotificationsTitle => 'Известувања';

  @override
  String get settingsNotificationsBody => 'Изберете како да ве известуваме.';

  @override
  String get settingsLanguageTitle => 'Јазик';

  @override
  String get settingsLanguageBody => 'Изберете го јазикот на апликацијата.';

  @override
  String get settingsLanguageSystem => 'Системски стандард';

  @override
  String get languageEnglish => '🇬🇧 Англиски';

  @override
  String get languageSerbianLatin => '🇷🇸 Српски (латиница)';

  @override
  String get languageMacedonian => '🇲🇰 Македонски';

  @override
  String get languageGerman => '🇩🇪 Германски';

  @override
  String get languageGreek => '🇬🇷 Грчки';

  @override
  String get languageRomanian => '🇷🇴 Романски';

  @override
  String get languageArabic => '🇸🇦 Арапски';

  @override
  String get languageRomani => '🟦🟩🟨🔴 Ромски';

  @override
  String get languageTurkish => '🇹🇷 Турски';

  @override
  String get registrationTitle => 'Create your account';

  @override
  String get registrationSubtitle => 'Fill in your details to get started.';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get emailLabel => 'Email';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get registerButton => 'Register';

  @override
  String get registerLink => 'Register';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get registerSuccess => 'Registration completed.';

  @override
  String get mySpaceLabel => 'My Space';

  @override
  String get messagesLabel => 'Messages';

  @override
  String get logoutLabel => 'Log out';

  @override
  String get userMenuTooltip => 'User menu';

  @override
  String get userMenuAccountFallback => 'Account';

  @override
  String get guidedMeditationTitle => 'Guided Meditation';

  @override
  String get guidedMeditationDescription =>
      'Take a moment to breathe and listen.';

  @override
  String get guidedMeditationMetadataLoadFailed =>
      'Could not load remote track metadata. Playing fallback track.';

  @override
  String get guidedMeditationSourceFirebase => 'Source: Firebase';

  @override
  String get guidedMeditationSourceFallback => 'Source: built-in fallback';

  @override
  String get skipLabel => 'Skip';

  @override
  String get pauseLabel => 'Pause';

  @override
  String get playLabel => 'Play';

  @override
  String get homeHowFeelingToday => 'How are you feeling today?';

  @override
  String get startLabel => 'Start';

  @override
  String get savingLabel => 'Saving...';

  @override
  String get canvasNotReady => 'Canvas is not ready yet.';

  @override
  String saveFailedWithError(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get bodyTransitionPrompt =>
      'Would you like to take a moment to gently tune into the physical sensations in your body before identifying your feeling?';

  @override
  String get continueLabel => 'Continue';

  @override
  String get saveLabel => 'Save';

  @override
  String get homeCheckAgainAnytime => 'You can check in again anytime today.';

  @override
  String get moodCheckLabel => 'Mood check';

  @override
  String get bodyCheckLabel => 'Body check';

  @override
  String get moodCheckFullscreenTitle => 'Mood check (fullscreen)';

  @override
  String get exitFullscreenLabel => 'Exit fullscreen';

  @override
  String get fullscreenLabel => 'Fullscreen';

  @override
  String get skipToQuoteLabel => 'Skip to quote';

  @override
  String homeGreeting(Object name) {
    return 'Hi $name, How are you feeling today?';
  }

  @override
  String get todaysAffirmationLabel => 'Today\'s affirmation';

  @override
  String get thereFallback => 'there';

  @override
  String get dailyAffirmation1 =>
      'You are allowed to take this day one breath at a time.';

  @override
  String get dailyAffirmation2 =>
      'Your feelings matter, and your body deserves gentle care.';

  @override
  String get dailyAffirmation3 =>
      'You are stronger than this moment feels right now.';

  @override
  String get dailyAffirmation4 =>
      'Small steps today are still meaningful progress.';

  @override
  String get dailyAffirmation5 =>
      'You belong exactly as you are, here and now.';

  @override
  String get dailyAffirmation6 =>
      'Your voice, your pace, and your healing all count.';

  @override
  String get dailyAffirmation7 => 'You can rest and still be growing.';

  @override
  String get pleaseLogInAgain => 'Please log in again.';

  @override
  String get unableToCaptureDrawing => 'Unable to capture drawing.';

  @override
  String get unableToExportDrawing => 'Unable to export drawing.';

  @override
  String get drawingSaved => 'Drawing saved.';

  @override
  String failedToSaveWithCode(Object code) {
    return 'Failed to save: $code';
  }

  @override
  String get failedToSaveDrawing => 'Failed to save drawing.';

  @override
  String get toolsLabel => 'Tools';

  @override
  String get useThisColorLabel => 'Use this color';

  @override
  String get textSizeLabel => 'Text size';

  @override
  String get eraserSizeLabel => 'Eraser size';

  @override
  String get brushSizeLabel => 'Brush size';

  @override
  String get fontLabel => 'Font';

  @override
  String get addTextTitle => 'Add text';

  @override
  String get writeUpToTwoLinesHint => 'Write up to 2 lines';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get addLabel => 'Add';

  @override
  String get undoLabel => 'Undo';

  @override
  String get clearLabel => 'Clear';

  @override
  String get moreToolsLabel => 'More tools';

  @override
  String get verificationExpiredDeleted =>
      'Verification expired. Account deleted.';

  @override
  String verifyEmailUntil(Object email, Object expiryText) {
    return 'Please verify your email $email until $expiryText.';
  }

  @override
  String verifyEmail(Object email) {
    return 'Please verify your email $email.';
  }

  @override
  String get googleSignInFailed => 'Google sign-in failed.';

  @override
  String get userFallbackName => 'User';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get enterValidEmail => 'Enter a valid email.';

  @override
  String get sendLinkLabel => 'Send link';

  @override
  String passwordResetSent(Object email) {
    return 'Password reset email sent to $email.';
  }

  @override
  String get unableToSendPasswordReset =>
      'Unable to send password reset email.';

  @override
  String get signingInLabel => 'Signing in...';

  @override
  String get forgotPasswordLabel => 'Forgot password?';

  @override
  String get acceptTermsRequired => 'Please accept terms and services.';

  @override
  String get usernameAlreadyExists => 'Username already exists.';

  @override
  String get registrationFailed => 'Registration failed.';

  @override
  String verificationEmailSent(Object email) {
    return 'Verification email sent to $email.';
  }

  @override
  String registrationFailedWithCode(Object code) {
    return 'Registration failed: $code';
  }

  @override
  String get registrationTimedOut => 'Registration timed out. Check emulator.';

  @override
  String registrationFailedWithError(Object error) {
    return 'Registration failed: $error';
  }

  @override
  String get atLeast6Characters => 'At least 6 characters.';

  @override
  String get passwordTooWeak => 'Password is too weak.';

  @override
  String get passwordRuleAtLeast8 => 'At least 8 characters';

  @override
  String get passwordRuleUppercase => 'At least 1 uppercase letter';

  @override
  String get passwordRuleNumber => 'At least 1 number';

  @override
  String get passwordRuleSpecial => 'At least 1 special character';

  @override
  String get iAcceptPrefix => 'I accept';

  @override
  String get termsAndServicesLabel => 'terms and services';

  @override
  String get oneBalloonPerDayMessage =>
      'You can pop one balloon per day. Come back tomorrow.';

  @override
  String get languageEnglishLabel => 'English';

  @override
  String get messageTitle => 'Message';

  @override
  String get closeLabel => 'Close';

  @override
  String get savedToMySpace => 'Saved to My Space.';

  @override
  String get alreadyOpenedTodayMessage =>
      'You already opened today\'s message. Come back tomorrow for a new balloon.';

  @override
  String get mySpaceIntro =>
      'Calendar, journaling, and your saved library in one place.';

  @override
  String get calendarLabel => 'Calendar';

  @override
  String get journalLabel => 'Journal';

  @override
  String get libraryLabel => 'Library';

  @override
  String get mySpaceCalendarSubtitle => 'Mood, body, quote, note';

  @override
  String get mySpaceJournalSubtitle => 'Entries and prompts';

  @override
  String get mySpaceLibrarySubtitle => 'Saved resources';

  @override
  String get deleteDrawingTitle => 'Delete drawing?';

  @override
  String get deleteDrawingBody => 'This action cannot be undone.';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get failedToDeleteDrawing => 'Failed to delete drawing.';

  @override
  String get noDrawingsForDay => 'No drawings saved for this day.';

  @override
  String get noBodyMapForDay => 'No body map saved for this day.';

  @override
  String get noFrontMapForDay => 'No front map saved for this day.';

  @override
  String get noBackMapForDay => 'No back map saved for this day.';

  @override
  String get showBackLabel => 'Show back';

  @override
  String get showFrontLabel => 'Show front';

  @override
  String get previewUnavailable => 'Preview unavailable';

  @override
  String get deleteDrawingTooltip => 'Delete drawing';

  @override
  String get dayOverviewTitle => 'Day overview';

  @override
  String selectedDateLabel(Object dateLabel) {
    return 'Selected date: $dateLabel';
  }

  @override
  String get moodLabel => 'Mood';

  @override
  String get bodyLabel => 'Body';

  @override
  String get quoteLabel => 'Quote';

  @override
  String get noteLabel => 'Note';

  @override
  String get noQuoteForDay => 'No quote saved for this day.';

  @override
  String get noNoteForDay => 'No note saved for this day.';

  @override
  String get doneLabel => 'Done';

  @override
  String get failedToSaveJournalEntry => 'Failed to save journal entry.';

  @override
  String get mySpaceJournalTitle => 'My Space Journal';

  @override
  String get noJournalEntriesYet => 'No journal entries yet.';

  @override
  String get entryCannotBeEmpty => 'Entry cannot be empty.';

  @override
  String get newEntryTitle => 'New Entry';

  @override
  String get promptsLabel => 'Prompts';

  @override
  String get startWritingHint => 'Start writing...';

  @override
  String get mySpaceLibraryTitle => 'My Space Library';

  @override
  String get savedResourcesTitle => 'Saved Resources';

  @override
  String get guidedBreathingVideo => 'Guided breathing video';

  @override
  String get calmingAudio => 'Calming audio';

  @override
  String get savedMessagesTitle => 'Saved Messages';

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get noSavedMessagesYet => 'No saved messages yet.';

  @override
  String get contactsLabel => 'Contacts';

  @override
  String get therapistLabel => 'Therapist';

  @override
  String get trustedFriendLabel => 'Trusted friend';

  @override
  String get promptComfortToday =>
      'What is one thing that brought you comfort today?';

  @override
  String get promptBodyMorning => 'How did your body feel this morning?';

  @override
  String get promptThreeGrateful => 'Name three things you are grateful for.';

  @override
  String get promptEmotionColor =>
      'If your emotions were a color, what would it be?';

  @override
  String get promptFutureSelf => 'Write a short note to your future self.';

  @override
  String get deleteAccountDialogTitle => 'Delete account?';

  @override
  String get deleteAccountDialogBody =>
      'This permanently deletes your account and app data. This action cannot be undone.';

  @override
  String get deleteAccountActionLabel => 'Delete account';

  @override
  String get confirmLabel => 'Confirm';

  @override
  String get deleteAccountRequiresRecentLogin =>
      'Please log in again, then retry account deletion.';

  @override
  String get deleteAccountFailed => 'Failed to delete account.';

  @override
  String get deleteAccountSettingsSubtitle =>
      'Permanently delete your account and app data.';
}
