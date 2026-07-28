// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'When Scars (!) Become Art';

  @override
  String get loginWith => 'Log in with:';

  @override
  String get loginWithGoogle => 'Log in with Google';

  @override
  String get loginWithApple => 'Log in with Apple';

  @override
  String get loginWithFacebook => 'Log in with Facebook';

  @override
  String get orLoginWithUsernameAndPassword =>
      'Or log in with username and password';

  @override
  String get usernameLabel => 'Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Log in';

  @override
  String get loadingCredentials => 'Loading credentials...';

  @override
  String get unableToLoadCredentials => 'Unable to load credentials';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get homeLabel => 'Home';

  @override
  String get profileLabel => 'Profile';

  @override
  String get galleryLabel => 'Gallery';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get helpLabel => 'Help';

  @override
  String get profilePageTitle => 'Profile Page';

  @override
  String get profilePageBody => 'View and edit your profile information here.';

  @override
  String get galleryTitle => 'Gallery';

  @override
  String get galleryBody => 'Browse your photo gallery here.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsBody => 'Manage your app settings here.';

  @override
  String get helpTitle => 'Help & Support';

  @override
  String get helpBody => 'Get help and support here.';

  @override
  String get settingsPreferencesTitle => 'Preferences';

  @override
  String get settingsPreferencesBody => 'Personalize your app experience.';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsBody => 'Choose how we notify you.';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageBody => 'Choose the language for the app.';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get languageEnglish => '🇬🇧 English';

  @override
  String get languageSerbianLatin => '🇷🇸 Serbian (Latin)';

  @override
  String get languageMacedonian => '🇲🇰 Macedonian';

  @override
  String get languageGerman => '🇩🇪 German';

  @override
  String get languageGreek => '🇬🇷 Greek';

  @override
  String get languageRomanian => '🇷🇴 Romanian';

  @override
  String get languageArabic => '🇸🇦 Arabic';

  @override
  String get languageRomani => '🟦🟩🟨🔴 Romani';

  @override
  String get languageTurkish => '🇹🇷 Turkish';

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
  String get bodyTransitionPrompt => 'Would you like to have a body scan?';

  @override
  String get yesLabel => 'Yes';

  @override
  String get noLabel => 'No';

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
  String get meditationLabel => 'Meditation';

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
      'Embrace and dance with your demons. They might change in color.';

  @override
  String get dailyAffirmation2 =>
      'When you don\'t know where you are going, all roads will get you there.';

  @override
  String get dailyAffirmation3 => 'Laugh now, cry later.';

  @override
  String get dailyAffirmation4 => 'I have a dream...';

  @override
  String get dailyAffirmation5 =>
      'If you think you are late to life, from that moment on you are at your youngest.';

  @override
  String get dailyAffirmation6 => 'The real miracle is believing in yourself.';

  @override
  String get dailyAffirmation7 => 'Life is one day and that is today.';

  @override
  String get dailyAffirmation8 =>
      'The truth is: the natural world is changing. And we are totally dependent on that world.';

  @override
  String get dailyAffirmation9 => 'We are all made of stardust.';

  @override
  String get dailyAffirmation10 =>
      'Dream with passion, live with responsibility.';

  @override
  String get dailyAffirmation11 =>
      'Just look at what we can do when we come together.';

  @override
  String get dailyAffirmation12 =>
      'Suffer now and live the rest of your life as a champion.';

  @override
  String get dailyAffirmation13 =>
      'It\'s all going to be okay. Say it one more time.';

  @override
  String get dailyAffirmation14 => 'Just take that step and try, it\'s enough.';

  @override
  String get dailyAffirmation15 => 'Make a wave of positive changes.';

  @override
  String get dailyAffirmation16 => 'Old ways won\'t open new doors.';

  @override
  String get dailyAffirmation17 => 'Mistakes are proof that you are trying.';

  @override
  String get dailyAffirmation18 =>
      'Your heart is the size of an ocean. Go find yourself in its hidden depths.';

  @override
  String get dailyAffirmation19 => 'Be weird, be unique, be yourself.';

  @override
  String get dailyAffirmation20 => 'Whatever happens, happens for the best.';

  @override
  String get dailyAffirmation21 => 'Actions can speak louder than words.';

  @override
  String get dailyAffirmation22 =>
      'Since we existed, even for a moment, then we exist forever.';

  @override
  String get dailyAffirmation23 =>
      'If saying goodbye hurts, it means you spent your time well.';

  @override
  String get dailyAffirmation24 =>
      'If life gives you moments, make them good memories.';

  @override
  String get dailyAffirmation25 => 'What goes around, comes around.';

  @override
  String get dailyAffirmation26 => 'Diversity makes the world beautiful.';

  @override
  String get dailyAffirmation27 => 'Everything is OK, no problem.';

  @override
  String get dailyAffirmation28 =>
      'What you think, you become. What you feel, you attract. What you imagine, you create.';

  @override
  String get dailyAffirmation29 => 'Strong minds grow in safe spaces.';

  @override
  String get dailyAffirmation30 =>
      'Everything is possible, just try it. You can do it.';

  @override
  String get dailyAffirmation31 =>
      'Every beginning is only a sequel, after all, and the book of events is always open halfway through.';

  @override
  String get dailyAffirmation32 =>
      'I am grounded, resilient and open to growth even in uncertain times.';

  @override
  String get dailyAffirmation33 =>
      'Be the person you needed when you were younger.';

  @override
  String get dailyAffirmation34 =>
      'There is a crack in everything, that\'s how the light gets in.';

  @override
  String get dailyAffirmation35 => 'I stand and fight to find my dreams.';

  @override
  String get dailyAffirmation36 => 'Don\'t let the other decide your future.';

  @override
  String get dailyAffirmation37 => 'The world needs more angry women.';

  @override
  String get dailyAffirmation38 => 'The sun will rise and we will try again.';

  @override
  String get dailyAffirmation39 =>
      'Wanderer, there is no path. You make the path while walking.';

  @override
  String get dailyAffirmation40 => 'You don\'t have to be perfect.';

  @override
  String get dailyAffirmation41 =>
      'Perfection is a Utopia. It only serves as compass.';

  @override
  String get dailyAffirmation42 =>
      'Everything has a beginning and an ending, and the end can be beautiful, no matter how dark it seems now.';

  @override
  String get dailyAffirmation43 =>
      'I raise up my voice — not so that I can shout, but so that those without a voice can be heard.';

  @override
  String get dailyAffirmation44 =>
      'Everything that seems it is drowning you is actually just teaching you to swim.';

  @override
  String get dailyAffirmation45 => 'If you have a goal, you will find a way.';

  @override
  String get dailyAffirmation46 => 'After the rain comes the rainbow.';

  @override
  String get dailyAffirmation47 =>
      'Every challenge I face is an opportunity to grow stronger.';

  @override
  String get dailyAffirmation48 =>
      'I embrace the questions in my heart and welcome the answers in their own time.';

  @override
  String get dailyAffirmation49 =>
      'The only approval I will ever need is mine.';

  @override
  String get dailyAffirmation50 =>
      'Kill the urge to be chosen. Choose yourself.';

  @override
  String get dailyAffirmation51 =>
      'In hardships keep smiling. It makes them worry.';

  @override
  String get dailyAffirmation52 =>
      'Not everything that is faced can be changed, but nothing can be changed until it is faced.';

  @override
  String get dailyAffirmation53 =>
      'We shouldn\'t be looking for heroes, we should be looking for good ideas.';

  @override
  String get dailyAffirmation54 =>
      'I see the sun, and if I don\'t see the sun, I know it\'s there.';

  @override
  String get dailyAffirmation55 =>
      'Anyone who has never made a mistake has never tried anything new.';

  @override
  String get dailyAffirmation56 =>
      'There\'s a whole life in that — in knowing that the sun is there.';

  @override
  String get dailyAffirmation57 => 'Only fools never change their mind.';

  @override
  String get dailyAffirmation58 =>
      'It always seems impossible until it\'s done.';

  @override
  String get dailyAffirmation59 =>
      'Never doubt that a small group of thoughtful, committed citizens can change the world; indeed, it\'s the only thing that ever has.';

  @override
  String get dailyAffirmation60 => 'Just do it already!';

  @override
  String get dailyAffirmation61 => 'Beat the crying with a deep smile.';

  @override
  String get dailyAffirmation62 =>
      'I\'d rather die like a man than live as a coward.';

  @override
  String get dailyAffirmation63 =>
      'Allow yourself to be authentic, even in places where everyone is expected to be the same.';

  @override
  String get dailyAffirmation64 => 'You are best, keep going.';

  @override
  String get dailyAffirmation65 =>
      'Believe in yourself. You can make miracles happen.';

  @override
  String get dailyAffirmation66 =>
      'If you can worry about it, it means you are alive and it didn\'t and won\'t kill you.';

  @override
  String get dailyAffirmation67 =>
      'With the flow of life, this too shall pass.';

  @override
  String get dailyAffirmation68 => 'Keep going, one day it will be worth it.';

  @override
  String get dailyAffirmation69 =>
      'Never be what the other wants you to be, be always yourself.';

  @override
  String get dailyAffirmation70 => 'Don\'t forget to focus on the good things.';

  @override
  String get dailyAffirmation71 => 'It\'s not selfish, it\'s self care.';

  @override
  String get dailyAffirmation72 =>
      'Fear makes you weak; anger makes you strong.';

  @override
  String get dailyAffirmation73 =>
      'When someone is drowning, you don\'t ask if they can swim — you just jump in and help.';

  @override
  String get dailyAffirmation74 =>
      'The smallest good deed is far better than the biggest good intention.';

  @override
  String get dailyAffirmation75 => 'Take the risk or lose the chance.';

  @override
  String get dailyAffirmation76 =>
      'Believe that you can and you\'re halfway there.';

  @override
  String get dailyAffirmation77 =>
      'Choose the one who makes your world beautiful.';

  @override
  String get dailyAffirmation78 =>
      'The smallest act of kindness is worth more than the grandest intention.';

  @override
  String get dailyAffirmation79 =>
      'Never regret a day in your life. Good days bring you happiness and bad days bring you experience.';

  @override
  String get dailyAffirmation80 =>
      'Every pro was first an amateur. Start your dream now.';

  @override
  String get dailyAffirmation81 =>
      'It might not be easy but it\'ll be worth it.';

  @override
  String get dailyAffirmation82 =>
      'It is never too late to be what you might have been.';

  @override
  String get dailyAffirmation83 => 'Everything you can imagine is real.';

  @override
  String get dailyAffirmation84 =>
      'There is no greater agony than bearing an untold story inside you.';

  @override
  String get dailyAffirmation85 =>
      'Pursue what catches your heart, not what catches your eyes.';

  @override
  String get dailyAffirmation86 =>
      'Dare to be the best you can. At all times, Dare to be!';

  @override
  String get dailyAffirmation87 =>
      'Never lose hope. Storms make people stronger and never last forever.';

  @override
  String get dailyAffirmation88 =>
      'Cry. Forgive. Learn. Move on. Let your tears water the seeds of your future happiness.';

  @override
  String get dailyAffirmation89 =>
      'When you\'re scared of losing yourself inside the light, just hold hands with your shadow.';

  @override
  String get dailyAffirmation90 =>
      'Where earth separates to create space, there you can plant a seed.';

  @override
  String get dailyAffirmation91 =>
      'If you\'ve got nothing to dance about, find a reason to sing.';

  @override
  String get dailyAffirmation92 =>
      'Sometimes the only way to ever find yourself is to get completely lost.';

  @override
  String get dailyAffirmation93 =>
      'Everything is within your power, and your power is within you.';

  @override
  String get dailyAffirmation94 =>
      'Your worth is not what you have, but who you are.';

  @override
  String get dailyAffirmation95 => 'It\'s ok not to be ok.';

  @override
  String get dailyAffirmation96 =>
      'After a thunderstorm there is always a rainbow.';

  @override
  String get dailyAffirmation97 => 'Tomorrow is a new day. Shine!';

  @override
  String get dailyAffirmation98 =>
      'Raindrops are little kisses from the Ocean.';

  @override
  String get dailyAffirmation99 => 'Let all that you do be done in love.';

  @override
  String get dailyAffirmation100 => 'Faith over fear.';

  @override
  String get dailyAffirmation101 =>
      'Do more and more with less and less until you can do anything with nothing.';

  @override
  String get dailyAffirmation102 => 'Be the love you want to see in the world.';

  @override
  String get dailyAffirmation103 =>
      'There is a seat waiting for you at tables you haven\'t even seen.';

  @override
  String get dailyAffirmation104 =>
      'Move like everything is gonna work out. Because it is.';

  @override
  String get dailyAffirmation105 => 'I am always protected.';

  @override
  String get dailyAffirmation106 =>
      'You will never miss out on what is meant for you.';

  @override
  String get dailyAffirmation107 => 'Nobody is a professional human.';

  @override
  String get dailyAffirmation108 =>
      'On top of the clouds the sun always shines.';

  @override
  String get dailyAffirmation109 => 'Remember who cares about you.';

  @override
  String get dailyAffirmation110 => 'Nothing matters, enjoy.';

  @override
  String get dailyAffirmation111 =>
      'Being unhappy is the reason you can appreciate better days.';

  @override
  String get dailyAffirmation112 =>
      'What if it turns better than you imagined?';

  @override
  String get dailyAffirmation113 => 'You are enough.';

  @override
  String get dailyAffirmation114 => 'I make my own path.';

  @override
  String get dailyAffirmation115 =>
      'Be the change you want to see in the world.';

  @override
  String get dailyAffirmation116 =>
      'Don\'t worry about a thing, cause every little thing is gonna be alright.';

  @override
  String get dailyAffirmation117 => 'Give importance to what\'s important.';

  @override
  String get dailyAffirmation118 =>
      'You can do anything but you don\'t have to.';

  @override
  String get dailyAffirmation119 => 'The sun in the heart.';

  @override
  String get dailyAffirmation120 =>
      'Everyone is useful, no one is indispensable.';

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
  String get appleSignInFailed => 'Apple sign-in failed.';

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
  String get quoteLabel => 'Daily Affirmation';

  @override
  String get noteLabel => 'Note';

  @override
  String get noQuoteForDay => 'No affirmation saved for this day.';

  @override
  String get dailyMessageLabel => 'Daily Message';

  @override
  String get noDailyMessageForDay => 'No message saved for this day.';

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

  @override
  String get careCornerTabLabel => 'Care Corner';

  @override
  String get careCornerWellbeingTitle => 'Wellbeing';

  @override
  String get careCornerSupportTitle => 'Support & Services';

  @override
  String get careCornerEducationTitle => 'Education';

  @override
  String get careCornerHubSuffixWellbeing => 'Wellbeing Hub';

  @override
  String get careCornerHubSuffixSupport => 'Support Hub';

  @override
  String get careCornerHubSuffixEducation => 'Education Hub';

  @override
  String get careCornerBackToHubLabel => 'Back to Hub';

  @override
  String get careCornerBackLabel => 'Back';

  @override
  String get careCornerFurtherReadingTitle => 'Further Reading & Deep Dive';

  @override
  String get careCornerFreeBadge => 'FREE';

  @override
  String get careCornerResourceNotice =>
      'Resource details and local contacts are organized by country and topic.';

  @override
  String get careCornerLocalSupportCenterTitle => 'Local support center';

  @override
  String get careCornerContactInfoDescription => 'Contact information';

  @override
  String get careCornerActionCall => 'CALL';

  @override
  String get careCornerActionCallNow => 'CALL NOW';

  @override
  String get careCornerActionSecureChat => 'SECURE CHAT';

  @override
  String get careCornerActionVisitWebsite => 'VISIT WEBSITE';

  @override
  String get careCornerActionEmail => 'EMAIL';

  @override
  String get careCornerActionScheduleCall => 'SCHEDULE CALL';

  @override
  String get careCornerActionBookAppointment => 'BOOK APPOINTMENT';

  @override
  String get careCornerTopicBreathing => 'Breathing Exercises';

  @override
  String get careCornerTopicMeditation => 'Guided Meditation';

  @override
  String get careCornerTopicMusic => 'Music Sessions';

  @override
  String get careCornerTopicJournaling => 'Journaling Prompts';

  @override
  String get careCornerTopicSelfCare => 'Self-Care Routines';

  @override
  String get careCornerTopicColorTheory => 'Color Theory Videos';

  @override
  String get careCornerTopicViolenceProtection => 'Violence & Protection';

  @override
  String get careCornerTopicLegalHelp => 'Legal Help';

  @override
  String get careCornerTopicHealthcare => 'Healthcare Access';

  @override
  String get careCornerTopicSupportGroups => 'Support Groups';

  @override
  String get careCornerTopicEmergency => 'Emergency Services';

  @override
  String get careCornerTopicLocalNgos => 'Local NGOs';

  @override
  String get careCornerTopicDiscrimination => 'Discrimination';

  @override
  String get careCornerTopicRacism => 'Racism';

  @override
  String get careCornerTopicAntigypsyism => 'Antigypsyism';

  @override
  String get careCornerTopicHateSpeech => 'Hate Speech Online';

  @override
  String get careCornerTopicXenophobia => 'Xenophobia';

  @override
  String get careCornerTopicMyRights => 'My Rights';

  @override
  String get careCornerFurtherReadingIdentity => 'Identity & Belonging';

  @override
  String get careCornerFurtherReadingDiscriminationSupport =>
      'Discrimination Support';

  @override
  String get careCornerFurtherReadingSeekHelp => 'When to Seek Help';

  @override
  String get careCornerCountryRomania => 'Romania';

  @override
  String get careCornerCountrySerbia => 'Serbia';

  @override
  String get careCornerCountryGreece => 'Greece';

  @override
  String get careCornerCountryNorthMacedonia => 'North Macedonia';

  @override
  String get careCornerCountryGermany => 'Germany';

  @override
  String get careCornerCountryTurkey => 'Turkey';

  @override
  String get careCornerCountryEuropeanUnion => 'European Union';

  @override
  String get termsTitle => 'Terms of Service';

  @override
  String termsEffectiveDate(Object date) {
    return 'Effective date: $date';
  }

  @override
  String termsIntro(Object appName) {
    return 'These Terms govern your use of $appName. By creating an account or using the app, you agree to these Terms.';
  }

  @override
  String get termsSection1Title => '1. Eligibility and Accounts';

  @override
  String get termsSection1Bullet1 =>
      'You must provide accurate registration details and keep your credentials secure.';

  @override
  String get termsSection1Bullet2 =>
      'You are responsible for activity under your account.';

  @override
  String get termsSection1Bullet3 =>
      'You may not impersonate another person or misuse the platform.';

  @override
  String get termsSection1Bullet4 =>
      'Users under 16 may use the app only with parent or legal guardian consent, and only where permitted by applicable law.';

  @override
  String get termsSection2Title => '2. What the App Provides';

  @override
  String get termsSection2Bullet1 =>
      'Mood drawing check-ins, body awareness tools, guided reflection content, messages, and journaling/library features.';

  @override
  String get termsSection2Bullet2 =>
      'The app supports emotional wellbeing and self-reflection.';

  @override
  String get termsSection2Bullet3 =>
      'The app is not a crisis service and not a substitute for medical, psychiatric, or emergency care.';

  @override
  String get termsSection3Title => '3. Health and Safety Disclaimer';

  @override
  String get termsSection3Bullet1 =>
      'No content in the app is medical advice, diagnosis, or treatment.';

  @override
  String get termsSection3Bullet2 =>
      'If you are in danger or experiencing an emergency, contact local emergency services immediately.';

  @override
  String get termsSection3Bullet3 =>
      'If an exercise causes discomfort, stop and seek professional support.';

  @override
  String get termsSection4Title => '4. User Content';

  @override
  String get termsSection4Bullet1 =>
      'You retain ownership of content you create (e.g., drawings, body maps, notes, journal entries).';

  @override
  String termsSection4Bullet2(Object companyName) {
    return 'You grant $companyName a limited license to store/process your content only to operate and improve the service.';
  }

  @override
  String get termsSection4Bullet3 =>
      'You must not upload unlawful, abusive, or infringing material.';

  @override
  String get termsSection5Title => '5. Acceptable Use';

  @override
  String get termsSection5Bullet1 =>
      'Do not attempt unauthorized access, reverse engineer, disrupt, or overload services.';

  @override
  String get termsSection5Bullet2 =>
      'Do not use the app to harass, threaten, or exploit others.';

  @override
  String get termsSection5Bullet3 =>
      'Do not bypass account, usage, or security restrictions.';

  @override
  String get termsSection6Title => '6. Data and Privacy';

  @override
  String get termsSection6Bullet1 =>
      'We process account/profile data and activity data needed for app features (e.g., daily check-ins, messages, saved entries, media playback).';

  @override
  String get termsSection6Bullet2 =>
      'Data is stored using Firebase services configured for the app.';

  @override
  String get termsSection6Bullet3 =>
      'Your privacy rights and retention/deletion details are described in our Privacy Policy.';

  @override
  String termsSection6Bullet4(Object url) {
    return 'Privacy Policy: $url';
  }

  @override
  String get termsSection7Title => '7. Third-Party Services';

  @override
  String get termsSection7Bullet1 =>
      'Authentication, storage, and database features rely on third-party providers (e.g., Google/Firebase).';

  @override
  String get termsSection7Bullet2 =>
      'Use of those integrations may also be subject to third-party terms.';

  @override
  String get termsSection8Title => '8. Intellectual Property';

  @override
  String termsSection8Bullet1(Object companyName) {
    return 'All app branding, design, and non-user content are owned by $companyName or licensed to it.';
  }

  @override
  String get termsSection8Bullet2 =>
      'You may not copy, distribute, or commercialize app materials without permission.';

  @override
  String get termsSection9Title => '9. Suspension and Termination';

  @override
  String get termsSection9Bullet1 =>
      'We may suspend or terminate accounts for violations, abuse, security risks, or legal obligations.';

  @override
  String get termsSection9Bullet2 => 'You may stop using the app at any time.';

  @override
  String get termsSection10Title => '10. Warranties and Liability';

  @override
  String get termsSection10Bullet1 =>
      'The service is provided \"as is\" and \"as available\".';

  @override
  String termsSection10Bullet2(Object companyName) {
    return 'To the fullest extent allowed by law, $companyName disclaims implied warranties.';
  }

  @override
  String termsSection10Bullet3(Object companyName) {
    return 'To the fullest extent allowed by law, $companyName is not liable for indirect, incidental, or consequential damages.';
  }

  @override
  String get termsSection11Title => '11. Changes to These Terms';

  @override
  String get termsSection11Bullet1 =>
      'We may update these Terms from time to time.';

  @override
  String get termsSection11Bullet2 =>
      'If changes are material, we will provide reasonable notice in-app or by email.';

  @override
  String get termsSection11Bullet3 =>
      'Continued use after updates means you accept the updated Terms.';

  @override
  String get termsSection12Title => '12. Governing Law';

  @override
  String termsSection12Bullet1(Object country) {
    return 'These Terms are governed by the laws of $country, without regard to conflict-of-law rules.';
  }

  @override
  String get termsSection13Title => '13. Contact';

  @override
  String termsSection13Bullet1(Object email) {
    return 'For support or legal requests, contact: $email';
  }

  @override
  String get termsImportantNote =>
      'Important: please confirm legal counsel review before release.';

  @override
  String get avatarUpdated => 'Avatar updated.';

  @override
  String get avatarUpdateFailed => 'Failed to update avatar.';

  @override
  String get avatarRemoved => 'Avatar removed.';

  @override
  String get avatarRemoveFailed => 'Failed to remove avatar.';

  @override
  String get nameUpdated => 'Name updated.';

  @override
  String get nameUpdateFailed => 'Failed to update name.';

  @override
  String get editNameTitle => 'Edit name';

  @override
  String get passwordMustBeAtLeast8 =>
      'Password must be at least 8 characters.';

  @override
  String get passwordRequirementsSummary =>
      'Use 1 uppercase, 1 number, and 1 special character.';

  @override
  String get emailUnchanged => 'Email is unchanged.';

  @override
  String get verificationEmailSentNewAddress =>
      'Verification email sent to the new address.';

  @override
  String get reauthenticateToUpdateEmail => 'Re-authenticate to update email';

  @override
  String get reauthenticationFailed => 'Re-authentication failed.';

  @override
  String get emailUpdateFailed => 'Failed to update email.';

  @override
  String get editEmailTitle => 'Edit email';

  @override
  String get passwordUpdated => 'Password updated.';

  @override
  String get reauthenticateToUpdatePassword =>
      'Re-authenticate to update password';

  @override
  String get passwordUpdateFailed => 'Failed to update password.';

  @override
  String get changePasswordTitle => 'Change password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get passwordRequirementsSummaryShort =>
      'Min 8 chars, 1 uppercase, 1 number, 1 special.';

  @override
  String get takePhotoLabel => 'Take a photo';

  @override
  String get chooseFromGalleryLabel => 'Choose from gallery';

  @override
  String get chooseAvatarLabel => 'Choose avatar';

  @override
  String get avatarPickerTitle => 'Choose your avatar';

  @override
  String get removePhotoLabel => 'Remove photo';

  @override
  String get notificationsOffSummary => 'Notifications are turned off.';

  @override
  String notificationsDailyAndInactiveSummary(Object hour, Object minute) {
    return 'Daily at $hour:$minute and 7-day inactivity reminders.';
  }

  @override
  String notificationsDailyOnlySummary(Object hour, Object minute) {
    return 'Daily reminder at $hour:$minute.';
  }

  @override
  String get notificationsInactiveOnlySummary =>
      'Only 7-day inactivity reminders.';

  @override
  String get dailyReminderTitle => 'Daily reminder';

  @override
  String get dailyReminderSubtitle => 'Send a daily morning push.';

  @override
  String get reminderTimeTitle => 'Reminder time';

  @override
  String get inactiveReminderTitle => 'Inactive reminder';

  @override
  String get inactiveReminderSubtitle => 'Send a reminder after 7 days away.';

  @override
  String get notificationPreferencesSaved => 'Notification preferences saved.';

  @override
  String get notificationPreferencesSaveFailed =>
      'Failed to save notification preferences.';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get profilePhotoTitle => 'Profile photo';

  @override
  String get profilePhotoSubtitle => 'Add or remove your avatar.';

  @override
  String get displayNameTitle => 'Display name';

  @override
  String get unknownValueLabel => 'Unknown';

  @override
  String get passwordUpdateSubtitle => 'Update your password.';

  @override
  String get passwordManagedByProviderSubtitle =>
      'Managed by your sign-in provider.';

  @override
  String get appSectionTitle => 'App';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeSystemLabel => 'System';

  @override
  String get themeLightLabel => 'Light';

  @override
  String get themeDarkLabel => 'Dark';

  @override
  String get cookieMonsterTitle => 'Join the Exercise';

  @override
  String get cookieMonsterJoinPrompt => 'Join me, would you?';

  @override
  String get joinLabel => 'Join';

  @override
  String get cookieMonsterOutsidePrompt =>
      'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?';

  @override
  String get reflectLabel => 'Reflect';

  @override
  String get experienceFeedbackTitle => 'How was this experience for you?';

  @override
  String get experienceFeedbackPositive => 'Positive: dance';

  @override
  String get experienceFeedbackNeutral => 'Neutral: meeeehhhhhh';

  @override
  String get experienceFeedbackNegative => 'Negative: fall down';

  @override
  String get selectBodyAreaFirst => 'Select a body area first.';

  @override
  String noClipFound(Object activityKey) {
    return 'No clip found for \"$activityKey\".';
  }

  @override
  String failedToLoadMonsterClip(Object error) {
    return 'Failed to load monster clip: $error';
  }

  @override
  String get colorLabel => 'Color';

  @override
  String get tapBodyToLogSensation => 'Tap the body to log a sensation.';

  @override
  String failedToSaveBodyAwarenessWithCode(Object code) {
    return 'Failed to save body awareness: $code.';
  }

  @override
  String get failedToSaveBodyAwareness => 'Failed to save body awareness.';

  @override
  String get stepSkipped => 'Step skipped.';

  @override
  String get bodyAwarenessPrompt =>
      'Where does this feeling seem to rest in your body?\nPlease touch that spot and select a color that feels true to the sensation.';

  @override
  String get exerciseInstructionWillYouJoin =>
      'Would you like to join Cookie Monster for a short exercise?';

  @override
  String get exerciseInstructionOutsideTheBody =>
      'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?';

  @override
  String get exerciseInstructionForeheadContact =>
      'Forehead Contact:\nPlace your palm on your forehead, hold for a few seconds, and relax with your breath.';

  @override
  String get exerciseInstructionSlowBreathing =>
      'Close Eyes - Breath Tracking:\nClose your eyes, inhale slowly through your nose, and exhale in 4 seconds (repeat 5 times).';

  @override
  String get exerciseInstructionWeightOfHead =>
      'Feel the Weight of Your Head:\nGently tilt your head forward, notice neck tension, and relax it.';

  @override
  String get exerciseInstructionBreathing478 =>
      '4-7-8 Breathing:\nInhale for 4 seconds, hold for 7, exhale for 8 (3 cycles).';

  @override
  String get exerciseInstructionAbdominalAwareness =>
      'Abdominal Awareness:\nPlace your hand on your abdomen and feel it rise and fall with each breath.';

  @override
  String get exerciseInstructionHeartCenter =>
      'Heart Center Opening:\nMove your chest forward, pull shoulders back, and breathe deeply.';

  @override
  String get exerciseInstructionBallSqueezing =>
      'Ball Squeezing:\nSlowly squeeze and release your palm (10 repetitions).';

  @override
  String get exerciseInstructionFingerMeditation =>
      'Finger Meditation:\nTouch each finger with your thumb one by one, exhaling with every touch.';

  @override
  String get exerciseInstructionHandMassage =>
      'Hand Massage:\nMassage the center of your palm with your thumb in small circles (30 seconds each hand).';

  @override
  String get exerciseInstructionShoulderDrop =>
      'Shoulder Drop:\nRaise shoulders toward ears, then release (5 repetitions).';

  @override
  String get exerciseInstructionBackOpening =>
      'Back Opening:\nClasp hands behind you, open the chest, and take a deep breath.';

  @override
  String get exerciseInstructionReleasingBurdens =>
      'Releasing Burdens:\nWith eyes closed, imagine a warm light flowing down from your shoulders.';

  @override
  String get exerciseInstructionRelaxingFacialMuscles =>
      'Relaxing Facial Muscles:\nClose eyes, tighten facial muscles, then release (3 repetitions).';

  @override
  String get exerciseInstructionJawDrop =>
      'Jaw Drop:\nSlightly open your mouth, relax jaw for 5 seconds, then close it.';

  @override
  String get exerciseInstructionSmileToYourself =>
      'Smile to Yourself:\nHold a gentle smile for 30 seconds.';

  @override
  String get exerciseInstructionEftTappingPoints =>
      'EFT Tapping Points:\nTap each point 5-7 times: eyebrow start, side of eye, under eye, under nose, chin, collarbone, under arm, top of head.';

  @override
  String get exerciseInstructionRisingOnTiptoes =>
      'Rising on Tiptoes:\nLift heels as you exhale, hold 3-5 seconds, lower slowly, and repeat 5-10 times.';

  @override
  String get singleClipUrlMissing => 'Single clip URL is missing.';

  @override
  String get exerciseClipsMissing => 'Exercise clips are missing.';

  @override
  String get videoPlayerInitializationFailed =>
      'Video player failed to initialize. Please fully restart the app.';

  @override
  String get failedToPlayOutroClip => 'Failed to play outro clip.';

  @override
  String get finishExerciseLabel => 'Finish exercise';

  @override
  String get startExerciseLabel => 'Start exercise';

  @override
  String get feedbackQuestionLabel => 'How was this experience for you?';

  @override
  String get feedbackVeryGood => 'Very Good';

  @override
  String get feedbackGood => 'Good';

  @override
  String get feedbackMeh => 'Meh';

  @override
  String get feedbackNotGood => 'Not Good';

  @override
  String get feedbackAwful => 'Awful';

  @override
  String get feedbackDoneLabel => 'Done';

  @override
  String get careCornerEuNationalPrompt =>
      'For country-specific support and services, please also visit your national bubble.';

  @override
  String get euDisclaimer =>
      'Funded by the European Union. Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Education and Culture Executive Agency (EACEA). Neither the European Union nor EACEA can be held responsible for them.';

  @override
  String get externalLinkWarningTitle => 'Leaving the app';

  @override
  String get externalLinkWarningMessage =>
      'You are about to open an external website. We are not responsible for the content of external sites.';

  @override
  String get externalLinkCancel => 'Cancel';

  @override
  String get externalLinkContinue => 'Continue';

  @override
  String get careCornerNotAvailableMessage => 'Not yet available';

  @override
  String get messageAlreadyOpenedToday =>
      'You already opened today\'s message. Come back tomorrow!';

  @override
  String get libraryResourcesTitle => 'Resources';

  @override
  String get savedToResources => 'Saved to Resources';

  @override
  String get noSavedResourcesYet => 'No saved resources yet.';

  @override
  String get messageOpenFailed =>
      'Couldn\'t open the message. Please check your connection and try again.';

  @override
  String get genericLoadFailed =>
      'Couldn\'t load. Please check your connection and try again.';

  @override
  String get genericSaveFailed => 'Couldn\'t save. Please try again.';

  @override
  String get retryLabel => 'Retry';

  @override
  String get careCornerActionReference => 'REFERENCE';

  @override
  String get genericDeleteFailed => 'Couldn\'t delete. Please try again.';

  @override
  String get reportLabel => 'Report';

  @override
  String get reportMessageAction => 'Report message';

  @override
  String get reportMessageConfirmBody =>
      'Report this message to the moderators?';

  @override
  String get reportMessageSent => 'Thank you. The message was reported.';

  @override
  String get reportMessageFailed =>
      'Couldn\'t send the report. Please try again.';
}
