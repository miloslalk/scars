// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'When Scars (!) Become Art';

  @override
  String get loginWith => 'Anmelden mit:';

  @override
  String get loginWithGoogle => 'Mit Google anmelden';

  @override
  String get loginWithApple => 'Mit Apple anmelden';

  @override
  String get loginWithFacebook => 'Mit Facebook anmelden';

  @override
  String get orLoginWithUsernameAndPassword =>
      'Oder mit Benutzername und Passwort anmelden';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get loadingCredentials => 'Anmeldedaten werden geladen...';

  @override
  String get unableToLoadCredentials =>
      'Anmeldedaten konnten nicht geladen werden';

  @override
  String get invalidCredentials => 'Ungültige Anmeldedaten';

  @override
  String get homeLabel => 'Start';

  @override
  String get profileLabel => 'Profil';

  @override
  String get galleryLabel => 'Galerie';

  @override
  String get settingsLabel => 'Einstellungen';

  @override
  String get helpLabel => 'Hilfe';

  @override
  String get profilePageTitle => 'Profilseite';

  @override
  String get profilePageBody =>
      'Hier kannst du deine Profilinformationen ansehen und bearbeiten.';

  @override
  String get galleryTitle => 'Galerie';

  @override
  String get galleryBody => 'Durchsuche hier deine Fotogalerie.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsBody => 'Verwalte hier deine App-Einstellungen.';

  @override
  String get helpTitle => 'Hilfe & Support';

  @override
  String get helpBody => 'Hier bekommst du Hilfe und Support.';

  @override
  String get settingsPreferencesTitle => 'Präferenzen';

  @override
  String get settingsPreferencesBody => 'Passe dein App-Erlebnis an.';

  @override
  String get settingsNotificationsTitle => 'Benachrichtigungen';

  @override
  String get settingsNotificationsBody =>
      'Lege fest, wie wir dich benachrichtigen.';

  @override
  String get settingsLanguageTitle => 'Sprache';

  @override
  String get settingsLanguageBody => 'Wähle die Sprache der App.';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get languageEnglish => '🇬🇧 Englisch';

  @override
  String get languageSerbianLatin => '🇷🇸 Serbisch (Lateinisch)';

  @override
  String get languageMacedonian => '🇲🇰 Mazedonisch';

  @override
  String get languageGerman => '🇩🇪 Deutsch';

  @override
  String get languageGreek => '🇬🇷 Griechisch';

  @override
  String get languageRomanian => '🇷🇴 Rumänisch';

  @override
  String get languageArabic => '🇸🇦 Arabisch';

  @override
  String get languageRomani => '🟦🟩🟨🔴 Romanes';

  @override
  String get languageTurkish => '🇹🇷 Türkisch';

  @override
  String get registrationTitle => 'Erstelle dein Konto';

  @override
  String get registrationSubtitle => 'Fülle deine Daten aus, um loszulegen.';

  @override
  String get fullNameLabel => 'Vollständiger Name';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get registerLink => 'Registrieren';

  @override
  String get noAccountPrompt => 'Noch kein Konto?';

  @override
  String get alreadyHaveAccount => 'Hast du bereits ein Konto?';

  @override
  String get fieldRequired => 'Dieses Feld ist erforderlich.';

  @override
  String get invalidEmail => 'Gib eine gültige E-Mail-Adresse ein.';

  @override
  String get passwordTooShort =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get passwordsDoNotMatch => 'Die Passwörter stimmen nicht überein.';

  @override
  String get registerSuccess => 'Registrierung abgeschlossen.';

  @override
  String get mySpaceLabel => 'Mein Bereich';

  @override
  String get messagesLabel => 'Nachrichten';

  @override
  String get logoutLabel => 'Abmelden';

  @override
  String get userMenuTooltip => 'Benutzermenü';

  @override
  String get userMenuAccountFallback => 'Konto';

  @override
  String get guidedMeditationTitle => 'Geführte Meditation';

  @override
  String get guidedMeditationDescription =>
      'Nimm dir einen Moment zum Atmen und Zuhören.';

  @override
  String get guidedMeditationMetadataLoadFailed =>
      'Metadaten konnten nicht geladen werden. Es wird eine Ersatzspur abgespielt.';

  @override
  String get guidedMeditationSourceFirebase => 'Quelle: Firebase';

  @override
  String get guidedMeditationSourceFallback => 'Quelle: integrierte Ersatzspur';

  @override
  String get skipLabel => 'Überspringen';

  @override
  String get pauseLabel => 'Pause';

  @override
  String get playLabel => 'Abspielen';

  @override
  String get homeHowFeelingToday => 'Wie fühlst du dich heute?';

  @override
  String get startLabel => 'Start';

  @override
  String get savingLabel => 'Wird gespeichert...';

  @override
  String get canvasNotReady => 'Die Zeichenfläche ist noch nicht bereit.';

  @override
  String saveFailedWithError(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get bodyTransitionPrompt =>
      'Möchtest du dir einen Moment Zeit nehmen, um sanft auf die körperlichen Empfindungen in deinem Körper zu achten, bevor du dein Gefühl benennst?';

  @override
  String get yesLabel => 'Yes';

  @override
  String get noLabel => 'No';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get saveLabel => 'Speichern';

  @override
  String get homeCheckAgainAnytime =>
      'Du kannst heute jederzeit wieder einchecken.';

  @override
  String get moodCheckLabel => 'Stimmungs-Check';

  @override
  String get bodyCheckLabel => 'Körper-Check';

  @override
  String get meditationLabel => 'Meditation';

  @override
  String get moodCheckFullscreenTitle => 'Stimmungs-Check (Vollbild)';

  @override
  String get exitFullscreenLabel => 'Vollbild beenden';

  @override
  String get fullscreenLabel => 'Vollbild';

  @override
  String get skipToQuoteLabel => 'Zum Zitat springen';

  @override
  String homeGreeting(Object name) {
    return 'Hallo $name, wie fühlst du dich heute?';
  }

  @override
  String get todaysAffirmationLabel => 'Affirmation des Tages';

  @override
  String get thereFallback => 'du';

  @override
  String get dailyAffirmation1 =>
      'Du darfst diesen Tag einen Atemzug nach dem anderen nehmen.';

  @override
  String get dailyAffirmation2 =>
      'Deine Gefühle sind wichtig, und dein Körper verdient liebevolle Fürsorge.';

  @override
  String get dailyAffirmation3 =>
      'Du bist stärker, als sich dieser Moment gerade anfühlt.';

  @override
  String get dailyAffirmation4 =>
      'Kleine Schritte heute sind trotzdem bedeutsamer Fortschritt.';

  @override
  String get dailyAffirmation5 =>
      'Du gehörst genau so dazu, wie du bist, hier und jetzt.';

  @override
  String get dailyAffirmation6 =>
      'Deine Stimme, dein Tempo und deine Heilung zählen alle.';

  @override
  String get dailyAffirmation7 => 'Du kannst ausruhen und trotzdem wachsen.';

  @override
  String get dailyAffirmation8 =>
      'Die Wahrheit ist: Die natürliche Welt verändert sich. Und wir sind völlig von dieser Welt abhängig.';

  @override
  String get dailyAffirmation9 => 'Wir bestehen alle aus Sternenstaub.';

  @override
  String get dailyAffirmation10 =>
      'Träumen Sie mit Leidenschaft, leben Sie mit Verantwortung.';

  @override
  String get dailyAffirmation11 =>
      'Schauen Sie sich einfach an, was wir tun können, wenn wir zusammenkommen.';

  @override
  String get dailyAffirmation12 =>
      'Leiden Sie jetzt und leben Sie den Rest Ihres Lebens als Champion.';

  @override
  String get dailyAffirmation13 => 'Es wird alles gut. Sag es noch einmal.';

  @override
  String get dailyAffirmation14 =>
      'Machen Sie einfach diesen Schritt und versuchen Sie es, es reicht.';

  @override
  String get dailyAffirmation15 =>
      'Machen Sie eine Welle positiver Veränderungen.';

  @override
  String get dailyAffirmation16 => 'Alte Wege werden keine neuen Türen öffnen.';

  @override
  String get dailyAffirmation17 =>
      'Fehler sind der Beweis dafür, dass Sie es versuchen.';

  @override
  String get dailyAffirmation18 =>
      'Dein Herz hat die Größe eines Ozeans. Finden Sie sich in seinen verborgenen Tiefen wieder.';

  @override
  String get dailyAffirmation19 =>
      'Sei seltsam, sei einzigartig, sei du selbst.';

  @override
  String get dailyAffirmation20 =>
      'Was auch immer passiert, es geschieht zum Besten.';

  @override
  String get dailyAffirmation21 => 'Taten können mehr sagen als Worte.';

  @override
  String get dailyAffirmation22 =>
      'Da wir existierten, auch nur für einen Moment, existieren wir für immer.';

  @override
  String get dailyAffirmation23 =>
      'Wenn der Abschied weh tut, bedeutet das, dass Sie Ihre Zeit gut verbracht haben.';

  @override
  String get dailyAffirmation24 =>
      'Wenn das Leben Ihnen Momente schenkt, machen Sie daraus schöne Erinnerungen.';

  @override
  String get dailyAffirmation25 => 'Alles rächt sich irgendwann.';

  @override
  String get dailyAffirmation26 => 'Vielfalt macht die Welt schön.';

  @override
  String get dailyAffirmation27 => 'Alles ist in Ordnung, kein Problem.';

  @override
  String get dailyAffirmation28 =>
      'Was du denkst, wirst du. Was du fühlst, ziehst du an. Was Sie sich vorstellen, erschaffen Sie.';

  @override
  String get dailyAffirmation29 => 'Starke Köpfe wachsen in sicheren Räumen.';

  @override
  String get dailyAffirmation30 =>
      'Alles ist möglich, probieren Sie es einfach aus. Du kannst es schaffen.';

  @override
  String get dailyAffirmation31 =>
      'Schließlich ist jeder Anfang nur eine Fortsetzung, und das Buch der Ereignisse ist immer zur Hälfte geöffnet.';

  @override
  String get dailyAffirmation32 =>
      'Ich bin geerdet, belastbar und offen für Wachstum, auch in unsicheren Zeiten.';

  @override
  String get dailyAffirmation33 =>
      'Seien Sie die Person, die Sie brauchten, als Sie jünger waren.';

  @override
  String get dailyAffirmation34 =>
      'Alles hat einen Riss, dadurch kommt das Licht hinein.';

  @override
  String get dailyAffirmation35 =>
      'Ich stehe und kämpfe, um meine Träume zu finden.';

  @override
  String get dailyAffirmation36 =>
      'Lass den anderen nicht über deine Zukunft entscheiden.';

  @override
  String get dailyAffirmation37 => 'Die Welt braucht mehr wütende Frauen.';

  @override
  String get dailyAffirmation38 =>
      'Die Sonne wird aufgehen und wir werden es noch einmal versuchen.';

  @override
  String get dailyAffirmation39 =>
      'Wanderer, es gibt keinen Weg. Du erschaffst den Weg beim Gehen.';

  @override
  String get dailyAffirmation40 => 'Du musst nicht perfekt sein.';

  @override
  String get dailyAffirmation41 =>
      'Perfektion ist eine Utopie. Es dient nur als Kompass.';

  @override
  String get dailyAffirmation42 =>
      'Alles hat einen Anfang und ein Ende, und das Ende kann schön sein, egal wie düster es jetzt erscheint.';

  @override
  String get dailyAffirmation43 =>
      'Ich erhebe meine Stimme – nicht, damit ich schreien kann, sondern damit diejenigen, die keine Stimme haben, gehört werden können.';

  @override
  String get dailyAffirmation44 =>
      'Alles, was so aussieht, als würde es Sie ertränken, bringt Ihnen in Wirklichkeit nur das Schwimmen bei.';

  @override
  String get dailyAffirmation45 =>
      'Wenn Sie ein Ziel haben, werden Sie einen Weg finden.';

  @override
  String get dailyAffirmation46 => 'Nach dem Regen kommt der Regenbogen.';

  @override
  String get dailyAffirmation47 =>
      'Jede Herausforderung, der ich gegenüberstehe, ist eine Chance, stärker zu werden.';

  @override
  String get dailyAffirmation48 =>
      'Ich nehme die Fragen in meinem Herzen an und begrüße die Antworten, wenn sie zu ihrer Zeit kommen.';

  @override
  String get dailyAffirmation49 =>
      'Die einzige Genehmigung, die ich jemals brauchen werde, ist meine.';

  @override
  String get dailyAffirmation50 =>
      'Töte den Drang, ausgewählt zu werden. Wählen Sie sich selbst.';

  @override
  String get dailyAffirmation51 =>
      'Auch in schwierigen Zeiten lächle weiter. Es macht ihnen Sorgen.';

  @override
  String get dailyAffirmation52 =>
      'Nicht alles, was vor uns liegt, kann geändert werden, aber nichts kann geändert werden, bis man sich damit auseinandersetzt.';

  @override
  String get dailyAffirmation53 =>
      'Wir sollten nicht nach Helden suchen, wir sollten nach guten Ideen suchen.';

  @override
  String get dailyAffirmation54 =>
      'Ich sehe die Sonne, und wenn ich sie nicht sehe, weiß ich, dass sie da ist.';

  @override
  String get dailyAffirmation55 =>
      'Wer noch nie einen Fehler gemacht hat, hat nie etwas Neues ausprobiert.';

  @override
  String get dailyAffirmation56 =>
      'Darin steckt ein ganzes Leben – in dem Wissen, dass die Sonne da ist.';

  @override
  String get dailyAffirmation57 => 'Nur Dummköpfe ändern nie ihre Meinung.';

  @override
  String get dailyAffirmation58 =>
      'Es scheint immer unmöglich, bis es fertig ist.';

  @override
  String get dailyAffirmation59 =>
      'Zweifle nie daran, dass eine kleine Gruppe nachdenklicher, engagierter Bürger die Welt verändern kann; Tatsächlich ist es das Einzige, was es jemals gab.';

  @override
  String get dailyAffirmation60 => 'Mach es einfach schon!';

  @override
  String get dailyAffirmation61 =>
      'Besiege das Weinen mit einem tiefen Lächeln.';

  @override
  String get dailyAffirmation62 =>
      'Ich würde lieber wie ein Mann sterben, als als Feigling zu leben.';

  @override
  String get dailyAffirmation63 =>
      'Erlauben Sie sich, authentisch zu sein, auch an Orten, an denen erwartet wird, dass alle gleich sind.';

  @override
  String get dailyAffirmation64 => 'Du bist der Beste, mach weiter.';

  @override
  String get dailyAffirmation65 =>
      'An sich selbst glauben. Du kannst Wunder bewirken.';

  @override
  String get dailyAffirmation66 =>
      'Wenn Sie sich darüber Sorgen machen können, bedeutet das, dass Sie am Leben sind und es Sie nicht getötet hat und auch nicht töten wird.';

  @override
  String get dailyAffirmation67 =>
      'Mit dem Fluss des Lebens wird auch dies vorübergehen.';

  @override
  String get dailyAffirmation68 =>
      'Machen Sie weiter, eines Tages wird es sich lohnen.';

  @override
  String get dailyAffirmation69 =>
      'Sei niemals das, was der andere von dir will, sei immer du selbst.';

  @override
  String get dailyAffirmation70 =>
      'Vergessen Sie nicht, sich auf die guten Dinge zu konzentrieren.';

  @override
  String get dailyAffirmation71 =>
      'Es ist nicht egoistisch, es ist Selbstfürsorge.';

  @override
  String get dailyAffirmation72 =>
      'Angst macht dich schwach; Wut macht dich stark.';

  @override
  String get dailyAffirmation73 =>
      'Wenn jemand ertrinkt, fragt man nicht, ob er schwimmen kann – man springt einfach ein und hilft.';

  @override
  String get dailyAffirmation74 =>
      'Die kleinste gute Tat ist weitaus besser als die größte gute Absicht.';

  @override
  String get dailyAffirmation75 =>
      'Gehen Sie das Risiko ein oder verpassen Sie die Chance.';

  @override
  String get dailyAffirmation76 =>
      'Glauben Sie, dass Sie es können und Sie haben die Hälfte geschafft.';

  @override
  String get dailyAffirmation77 =>
      'Wählen Sie denjenigen, der Ihre Welt schön macht.';

  @override
  String get dailyAffirmation78 =>
      'Der kleinste Akt der Freundlichkeit ist mehr wert als die größte Absicht.';

  @override
  String get dailyAffirmation79 =>
      'Bereue niemals einen Tag in deinem Leben. Gute Tage bringen dir Glück und schlechte Tage bringen dir Erfahrung.';

  @override
  String get dailyAffirmation80 =>
      'Jeder Profi war zunächst Amateur. Beginnen Sie jetzt Ihren Traum.';

  @override
  String get dailyAffirmation81 =>
      'Es ist vielleicht nicht einfach, aber es wird sich lohnen.';

  @override
  String get dailyAffirmation82 =>
      'Es ist nie zu spät, das zu sein, was man hätte sein können.';

  @override
  String get dailyAffirmation83 =>
      'Alles, was Sie sich vorstellen können, ist real.';

  @override
  String get dailyAffirmation84 =>
      'Es gibt keine größere Qual, als eine unerzählte Geschichte in sich zu tragen.';

  @override
  String get dailyAffirmation85 =>
      'Verfolge das, was dein Herz fesselt, nicht das, was deine Augen fesselt.';

  @override
  String get dailyAffirmation86 =>
      'Trauen Sie sich, Ihr Bestes zu geben. Trauen Sie sich jederzeit, es zu sein!';

  @override
  String get dailyAffirmation87 =>
      'Verliere niemals die Hoffnung. Stürme machen Menschen stärker und dauern nie ewig.';

  @override
  String get dailyAffirmation88 =>
      'Weinen. Verzeihen. Lernen. Weitergehen. Lassen Sie Ihre Tränen den Samen Ihres zukünftigen Glücks bewässern.';

  @override
  String get dailyAffirmation89 =>
      'Wenn Sie Angst haben, sich im Licht zu verlieren, halten Sie einfach die Hände Ihres Schattens.';

  @override
  String get dailyAffirmation90 =>
      'Wo sich die Erde trennt, um Platz zu schaffen, da kann man einen Samen pflanzen.';

  @override
  String get dailyAffirmation91 =>
      'Wenn Sie nichts zum Tanzen haben, finden Sie einen Grund zum Singen.';

  @override
  String get dailyAffirmation92 =>
      'Manchmal ist der einzige Weg, sich selbst zu finden, völlig verloren zu gehen.';

  @override
  String get dailyAffirmation93 =>
      'Alles liegt in deiner Macht, und deine Macht liegt in dir.';

  @override
  String get dailyAffirmation94 =>
      'Dein Wert ist nicht das, was du hast, sondern wer du bist.';

  @override
  String get dailyAffirmation95 =>
      'Es ist in Ordnung, nicht in Ordnung zu sein.';

  @override
  String get dailyAffirmation96 =>
      'Nach einem Gewitter gibt es immer einen Regenbogen.';

  @override
  String get dailyAffirmation97 => 'Morgen ist ein neuer Tag. Glanz!';

  @override
  String get dailyAffirmation98 =>
      'Regentropfen sind kleine Küsse aus dem Ozean.';

  @override
  String get dailyAffirmation99 =>
      'Lass alles, was du tust, in Liebe geschehen.';

  @override
  String get dailyAffirmation100 => 'Glaube statt Angst.';

  @override
  String get dailyAffirmation101 =>
      'Machen Sie immer mehr mit immer weniger, bis Sie mit nichts alles erreichen können.';

  @override
  String get dailyAffirmation102 =>
      'Sei die Liebe, die du in der Welt sehen willst.';

  @override
  String get dailyAffirmation103 =>
      'An Tischen, die Sie noch nicht einmal gesehen haben, wartet ein Platz auf Sie.';

  @override
  String get dailyAffirmation104 =>
      'Bewegen Sie sich, als würde alles klappen. Weil es so ist.';

  @override
  String get dailyAffirmation105 => 'Ich bin immer beschützt.';

  @override
  String get dailyAffirmation106 =>
      'Sie werden nie das verpassen, was für Sie bestimmt ist.';

  @override
  String get dailyAffirmation107 => 'Niemand ist ein professioneller Mensch.';

  @override
  String get dailyAffirmation108 => 'Über den Wolken scheint immer die Sonne.';

  @override
  String get dailyAffirmation109 =>
      'Denken Sie daran, wer sich um Sie kümmert.';

  @override
  String get dailyAffirmation110 => 'Nichts ist wichtig, viel Spaß.';

  @override
  String get dailyAffirmation111 =>
      'Unglücklich zu sein ist der Grund, warum man bessere Tage schätzen kann.';

  @override
  String get dailyAffirmation112 =>
      'Was ist, wenn es besser wird, als Sie es sich vorgestellt haben?';

  @override
  String get dailyAffirmation113 => 'Du bist genug.';

  @override
  String get dailyAffirmation114 => 'Ich gehe meinen eigenen Weg.';

  @override
  String get dailyAffirmation115 =>
      'Seien Sie die Veränderung, die Sie in der Welt sehen möchten.';

  @override
  String get dailyAffirmation116 =>
      'Mach dir um nichts Sorgen, denn alles wird gut.';

  @override
  String get dailyAffirmation117 => 'Geben Sie dem Wichtigen Bedeutung.';

  @override
  String get dailyAffirmation118 => 'Du kannst alles tun, musst es aber nicht.';

  @override
  String get dailyAffirmation119 => 'Die Sonne im Herzen.';

  @override
  String get dailyAffirmation120 =>
      'Jeder ist nützlich, niemand ist unverzichtbar.';

  @override
  String get pleaseLogInAgain => 'Bitte melde dich erneut an.';

  @override
  String get unableToCaptureDrawing =>
      'Die Zeichnung konnte nicht erfasst werden.';

  @override
  String get unableToExportDrawing =>
      'Die Zeichnung konnte nicht exportiert werden.';

  @override
  String get drawingSaved => 'Zeichnung gespeichert.';

  @override
  String failedToSaveWithCode(Object code) {
    return 'Speichern fehlgeschlagen: $code';
  }

  @override
  String get failedToSaveDrawing =>
      'Zeichnung konnte nicht gespeichert werden.';

  @override
  String get toolsLabel => 'Werkzeuge';

  @override
  String get useThisColorLabel => 'Diese Farbe verwenden';

  @override
  String get textSizeLabel => 'Textgröße';

  @override
  String get eraserSizeLabel => 'Radierergröße';

  @override
  String get brushSizeLabel => 'Pinselgröße';

  @override
  String get fontLabel => 'Schriftart';

  @override
  String get addTextTitle => 'Text hinzufügen';

  @override
  String get writeUpToTwoLinesHint => 'Schreibe bis zu 2 Zeilen';

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get addLabel => 'Hinzufügen';

  @override
  String get undoLabel => 'Rückgängig';

  @override
  String get clearLabel => 'Leeren';

  @override
  String get moreToolsLabel => 'Weitere Werkzeuge';

  @override
  String get verificationExpiredDeleted =>
      'Bestätigung abgelaufen. Konto gelöscht.';

  @override
  String verifyEmailUntil(Object email, Object expiryText) {
    return 'Bitte bestätige deine E-Mail $email bis zum $expiryText.';
  }

  @override
  String verifyEmail(Object email) {
    return 'Bitte bestätige deine E-Mail $email.';
  }

  @override
  String get googleSignInFailed => 'Anmeldung mit Google fehlgeschlagen.';

  @override
  String get appleSignInFailed => 'Anmeldung mit Apple fehlgeschlagen.';

  @override
  String get userFallbackName => 'Nutzer';

  @override
  String get resetPasswordTitle => 'Passwort zurücksetzen';

  @override
  String get enterValidEmail => 'Gib eine gültige E-Mail-Adresse ein.';

  @override
  String get sendLinkLabel => 'Link senden';

  @override
  String passwordResetSent(Object email) {
    return 'E-Mail zum Zurücksetzen des Passworts an $email gesendet.';
  }

  @override
  String get unableToSendPasswordReset =>
      'Die E-Mail zum Zurücksetzen des Passworts konnte nicht gesendet werden.';

  @override
  String get signingInLabel => 'Anmeldung läuft...';

  @override
  String get forgotPasswordLabel => 'Passwort vergessen?';

  @override
  String get acceptTermsRequired => 'Bitte akzeptiere die Nutzungsbedingungen.';

  @override
  String get usernameAlreadyExists => 'Benutzername existiert bereits.';

  @override
  String get registrationFailed => 'Registrierung fehlgeschlagen.';

  @override
  String verificationEmailSent(Object email) {
    return 'Bestätigungs-E-Mail an $email gesendet.';
  }

  @override
  String registrationFailedWithCode(Object code) {
    return 'Registrierung fehlgeschlagen: $code';
  }

  @override
  String get registrationTimedOut =>
      'Zeitüberschreitung bei der Registrierung. Prüfe den Emulator.';

  @override
  String registrationFailedWithError(Object error) {
    return 'Registrierung fehlgeschlagen: $error';
  }

  @override
  String get atLeast6Characters => 'Mindestens 6 Zeichen.';

  @override
  String get passwordTooWeak => 'Das Passwort ist zu schwach.';

  @override
  String get passwordRuleAtLeast8 => 'Mindestens 8 Zeichen';

  @override
  String get passwordRuleUppercase => 'Mindestens 1 Großbuchstabe';

  @override
  String get passwordRuleNumber => 'Mindestens 1 Zahl';

  @override
  String get passwordRuleSpecial => 'Mindestens 1 Sonderzeichen';

  @override
  String get iAcceptPrefix => 'Ich akzeptiere';

  @override
  String get termsAndServicesLabel => 'die Nutzungsbedingungen';

  @override
  String get oneBalloonPerDayMessage =>
      'Du kannst einen Ballon pro Tag zerplatzen lassen. Komm morgen wieder.';

  @override
  String get languageEnglishLabel => 'Englisch';

  @override
  String get messageTitle => 'Nachricht';

  @override
  String get closeLabel => 'Schließen';

  @override
  String get savedToMySpace => 'In Mein Bereich gespeichert.';

  @override
  String get alreadyOpenedTodayMessage =>
      'Du hast die Nachricht von heute bereits geöffnet. Komm morgen für einen neuen Ballon wieder.';

  @override
  String get mySpaceIntro =>
      'Kalender, Tagebuch und deine gespeicherte Bibliothek an einem Ort.';

  @override
  String get calendarLabel => 'Kalender';

  @override
  String get journalLabel => 'Tagebuch';

  @override
  String get libraryLabel => 'Bibliothek';

  @override
  String get mySpaceCalendarSubtitle => 'Stimmung, Körper, Zitat, Notiz';

  @override
  String get mySpaceJournalSubtitle => 'Einträge und Impulse';

  @override
  String get mySpaceLibrarySubtitle => 'Gespeicherte Ressourcen';

  @override
  String get deleteDrawingTitle => 'Zeichnung löschen?';

  @override
  String get deleteDrawingBody =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteLabel => 'Löschen';

  @override
  String get failedToDeleteDrawing => 'Zeichnung konnte nicht gelöscht werden.';

  @override
  String get noDrawingsForDay =>
      'Keine Zeichnungen für diesen Tag gespeichert.';

  @override
  String get noBodyMapForDay => 'Keine Körperkarte für diesen Tag gespeichert.';

  @override
  String get noFrontMapForDay =>
      'Keine Vorderansicht für diesen Tag gespeichert.';

  @override
  String get noBackMapForDay => 'Keine Rückansicht für diesen Tag gespeichert.';

  @override
  String get showBackLabel => 'Rückseite zeigen';

  @override
  String get showFrontLabel => 'Vorderseite zeigen';

  @override
  String get previewUnavailable => 'Vorschau nicht verfügbar';

  @override
  String get deleteDrawingTooltip => 'Zeichnung löschen';

  @override
  String get dayOverviewTitle => 'Tagesübersicht';

  @override
  String selectedDateLabel(Object dateLabel) {
    return 'Ausgewähltes Datum: $dateLabel';
  }

  @override
  String get moodLabel => 'Stimmung';

  @override
  String get bodyLabel => 'Körper';

  @override
  String get quoteLabel => 'Zitat';

  @override
  String get noteLabel => 'Notiz';

  @override
  String get noQuoteForDay => 'Kein Zitat für diesen Tag gespeichert.';

  @override
  String get dailyMessageLabel => 'Tägliche Nachricht';

  @override
  String get noDailyMessageForDay =>
      'Für diesen Tag ist keine Nachricht gespeichert.';

  @override
  String get noNoteForDay => 'Keine Notiz für diesen Tag gespeichert.';

  @override
  String get doneLabel => 'Fertig';

  @override
  String get failedToSaveJournalEntry =>
      'Tagebucheintrag konnte nicht gespeichert werden.';

  @override
  String get mySpaceJournalTitle => 'Mein Bereich – Tagebuch';

  @override
  String get noJournalEntriesYet => 'Noch keine Tagebucheinträge.';

  @override
  String get entryCannotBeEmpty => 'Der Eintrag darf nicht leer sein.';

  @override
  String get newEntryTitle => 'Neuer Eintrag';

  @override
  String get promptsLabel => 'Impulse';

  @override
  String get startWritingHint => 'Beginne zu schreiben...';

  @override
  String get mySpaceLibraryTitle => 'Mein Bereich – Bibliothek';

  @override
  String get savedResourcesTitle => 'Gespeicherte Ressourcen';

  @override
  String get guidedBreathingVideo => 'Geführtes Atemvideo';

  @override
  String get calmingAudio => 'Beruhigendes Audio';

  @override
  String get savedMessagesTitle => 'Gespeicherte Nachrichten';

  @override
  String get loadingLabel => 'Wird geladen...';

  @override
  String get noSavedMessagesYet => 'Noch keine gespeicherten Nachrichten.';

  @override
  String get contactsLabel => 'Kontakte';

  @override
  String get therapistLabel => 'Therapeut:in';

  @override
  String get trustedFriendLabel => 'Vertrauensperson';

  @override
  String get promptComfortToday => 'Was hat dir heute Trost gespendet?';

  @override
  String get promptBodyMorning =>
      'Wie hat sich dein Körper heute Morgen angefühlt?';

  @override
  String get promptThreeGrateful =>
      'Nenne drei Dinge, für die du dankbar bist.';

  @override
  String get promptEmotionColor =>
      'Wenn deine Gefühle eine Farbe wären, welche wäre es?';

  @override
  String get promptFutureSelf =>
      'Schreibe eine kurze Nachricht an dein zukünftiges Ich.';

  @override
  String get deleteAccountDialogTitle => 'Konto löschen?';

  @override
  String get deleteAccountDialogBody =>
      'Damit werden dein Konto und deine App-Daten dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteAccountActionLabel => 'Konto löschen';

  @override
  String get confirmLabel => 'Bestätigen';

  @override
  String get deleteAccountRequiresRecentLogin =>
      'Bitte melde dich erneut an und versuche es dann noch einmal.';

  @override
  String get deleteAccountFailed => 'Konto konnte nicht gelöscht werden.';

  @override
  String get deleteAccountSettingsSubtitle =>
      'Lösche dein Konto und deine App-Daten dauerhaft.';

  @override
  String get careCornerTabLabel => 'Fürsorge-Ecke';

  @override
  String get careCornerWellbeingTitle => 'Wohlbefinden';

  @override
  String get careCornerSupportTitle => 'Hilfe & Dienste';

  @override
  String get careCornerEducationTitle => 'Bildung';

  @override
  String get careCornerHubSuffixWellbeing => 'Wohlbefinden-Hub';

  @override
  String get careCornerHubSuffixSupport => 'Hilfe-Hub';

  @override
  String get careCornerHubSuffixEducation => 'Bildungs-Hub';

  @override
  String get careCornerBackToHubLabel => 'Zurück zum Hub';

  @override
  String get careCornerBackLabel => 'Zurück';

  @override
  String get careCornerFurtherReadingTitle => 'Weiterführende Inhalte';

  @override
  String get careCornerFreeBadge => 'KOSTENLOS';

  @override
  String get careCornerResourceNotice =>
      'Ressourcendetails und lokale Kontakte sind nach Land und Thema geordnet.';

  @override
  String get careCornerLocalSupportCenterTitle =>
      'Lokales Unterstützungszentrum';

  @override
  String get careCornerContactInfoDescription => 'Kontaktinformationen';

  @override
  String get careCornerActionCall => 'ANRUFEN';

  @override
  String get careCornerActionCallNow => 'JETZT ANRUFEN';

  @override
  String get careCornerActionSecureChat => 'SICHERER CHAT';

  @override
  String get careCornerActionVisitWebsite => 'WEBSITE BESUCHEN';

  @override
  String get careCornerActionEmail => 'E-MAIL';

  @override
  String get careCornerActionScheduleCall => 'ANRUF PLANEN';

  @override
  String get careCornerActionBookAppointment => 'TERMIN BUCHEN';

  @override
  String get careCornerTopicBreathing => 'Atemübungen';

  @override
  String get careCornerTopicMeditation => 'Geführte Meditation';

  @override
  String get careCornerTopicMusic => 'Musik-Sessions';

  @override
  String get careCornerTopicJournaling => 'Tagebuch-Impulse';

  @override
  String get careCornerTopicSelfCare => 'Selbstfürsorge-Routinen';

  @override
  String get careCornerTopicColorTheory => 'Videos zur Farbenlehre';

  @override
  String get careCornerTopicViolenceProtection => 'Gewalt & Schutz';

  @override
  String get careCornerTopicLegalHelp => 'Rechtshilfe';

  @override
  String get careCornerTopicHealthcare => 'Zugang zur Gesundheitsversorgung';

  @override
  String get careCornerTopicSupportGroups => 'Selbsthilfegruppen';

  @override
  String get careCornerTopicEmergency => 'Notdienste';

  @override
  String get careCornerTopicLocalNgos => 'Lokale NGOs';

  @override
  String get careCornerTopicDiscrimination => 'Diskriminierung';

  @override
  String get careCornerTopicRacism => 'Rassismus';

  @override
  String get careCornerTopicAntigypsyism => 'Antiziganismus';

  @override
  String get careCornerTopicHateSpeech => 'Hassrede im Netz';

  @override
  String get careCornerTopicXenophobia => 'Fremdenfeindlichkeit';

  @override
  String get careCornerTopicMyRights => 'Meine Rechte';

  @override
  String get careCornerFurtherReadingIdentity => 'Identität & Zugehörigkeit';

  @override
  String get careCornerFurtherReadingDiscriminationSupport =>
      'Unterstützung bei Diskriminierung';

  @override
  String get careCornerFurtherReadingSeekHelp =>
      'Wann du Hilfe suchen solltest';

  @override
  String get careCornerCountryRomania => 'Rumänien';

  @override
  String get careCornerCountrySerbia => 'Serbien';

  @override
  String get careCornerCountryGreece => 'Griechenland';

  @override
  String get careCornerCountryNorthMacedonia => 'Nordmazedonien';

  @override
  String get careCornerCountryGermany => 'Deutschland';

  @override
  String get careCornerCountryTurkey => 'Türkei';

  @override
  String get careCornerCountryEuropeanUnion => 'Europäische Union';

  @override
  String get termsTitle => 'Nutzungsbedingungen';

  @override
  String termsEffectiveDate(Object date) {
    return 'Gültig ab: $date';
  }

  @override
  String termsIntro(Object appName) {
    return 'Diese Bedingungen regeln deine Nutzung von $appName. Indem du ein Konto erstellst oder die App nutzt, stimmst du diesen Bedingungen zu.';
  }

  @override
  String get termsSection1Title => '1. Berechtigung und Konten';

  @override
  String get termsSection1Bullet1 =>
      'Du musst bei der Registrierung korrekte Angaben machen und deine Zugangsdaten sicher aufbewahren.';

  @override
  String get termsSection1Bullet2 =>
      'Du bist für alle Aktivitäten unter deinem Konto verantwortlich.';

  @override
  String get termsSection1Bullet3 =>
      'Du darfst dich nicht als eine andere Person ausgeben oder die Plattform missbrauchen.';

  @override
  String get termsSection1Bullet4 =>
      'Nutzer:innen unter 16 Jahren dürfen die App nur mit Zustimmung eines Elternteils oder gesetzlichen Vormunds und nur dort, wo dies gesetzlich zulässig ist, verwenden.';

  @override
  String get termsSection2Title => '2. Was die App bietet';

  @override
  String get termsSection2Bullet1 =>
      'Stimmungs-Check-ins per Zeichnung, Werkzeuge zur Körperwahrnehmung, Inhalte zur geführten Reflexion, Nachrichten sowie Tagebuch- und Bibliotheksfunktionen.';

  @override
  String get termsSection2Bullet2 =>
      'Die App unterstützt dein emotionales Wohlbefinden und deine Selbstreflexion.';

  @override
  String get termsSection2Bullet3 =>
      'Die App ist kein Krisendienst und kein Ersatz für medizinische, psychiatrische oder notfallmedizinische Versorgung.';

  @override
  String get termsSection3Title => '3. Gesundheits- und Sicherheitshinweis';

  @override
  String get termsSection3Bullet1 =>
      'Keine Inhalte in der App stellen medizinische Beratung, Diagnose oder Behandlung dar.';

  @override
  String get termsSection3Bullet2 =>
      'Wenn du in Gefahr bist oder einen Notfall erlebst, kontaktiere sofort die örtlichen Notdienste.';

  @override
  String get termsSection3Bullet3 =>
      'Wenn eine Übung Unwohlsein verursacht, höre auf und suche professionelle Unterstützung.';

  @override
  String get termsSection4Title => '4. Nutzerinhalte';

  @override
  String get termsSection4Bullet1 =>
      'Du behältst das Eigentum an den Inhalten, die du erstellst (z. B. Zeichnungen, Körperkarten, Notizen, Tagebucheinträge).';

  @override
  String termsSection4Bullet2(Object companyName) {
    return 'Du gewährst $companyName eine eingeschränkte Lizenz zum Speichern und Verarbeiten deiner Inhalte, ausschließlich um den Dienst zu betreiben und zu verbessern.';
  }

  @override
  String get termsSection4Bullet3 =>
      'Du darfst keine rechtswidrigen, missbräuchlichen oder rechtsverletzenden Inhalte hochladen.';

  @override
  String get termsSection5Title => '5. Zulässige Nutzung';

  @override
  String get termsSection5Bullet1 =>
      'Versuche keinen unbefugten Zugriff, kein Reverse Engineering, keine Störung oder Überlastung der Dienste.';

  @override
  String get termsSection5Bullet2 =>
      'Verwende die App nicht, um andere zu belästigen, zu bedrohen oder auszunutzen.';

  @override
  String get termsSection5Bullet3 =>
      'Umgehe keine Konto-, Nutzungs- oder Sicherheitsbeschränkungen.';

  @override
  String get termsSection6Title => '6. Daten und Privatsphäre';

  @override
  String get termsSection6Bullet1 =>
      'Wir verarbeiten Konto-/Profildaten und Aktivitätsdaten, die für die Funktionen der App erforderlich sind (z. B. tägliche Check-ins, Nachrichten, gespeicherte Einträge, Medienwiedergabe).';

  @override
  String get termsSection6Bullet2 =>
      'Die Daten werden über die für die App konfigurierten Firebase-Dienste gespeichert.';

  @override
  String get termsSection6Bullet3 =>
      'Deine Datenschutzrechte sowie Details zur Aufbewahrung/Löschung findest du in unserer Datenschutzerklärung.';

  @override
  String termsSection6Bullet4(Object url) {
    return 'Datenschutzerklärung: $url';
  }

  @override
  String get termsSection7Title => '7. Drittanbieterdienste';

  @override
  String get termsSection7Bullet1 =>
      'Authentifizierung, Speicherung und Datenbankfunktionen beruhen auf Drittanbietern (z. B. Google/Firebase).';

  @override
  String get termsSection7Bullet2 =>
      'Die Nutzung dieser Integrationen kann zusätzlich den Bedingungen der Drittanbieter unterliegen.';

  @override
  String get termsSection8Title => '8. Geistiges Eigentum';

  @override
  String termsSection8Bullet1(Object companyName) {
    return 'Alle App-Marken, Designs und nicht von Nutzer:innen stammenden Inhalte sind Eigentum von $companyName oder an sie lizenziert.';
  }

  @override
  String get termsSection8Bullet2 =>
      'Du darfst App-Materialien ohne Erlaubnis nicht kopieren, verbreiten oder kommerziell nutzen.';

  @override
  String get termsSection9Title => '9. Sperrung und Kündigung';

  @override
  String get termsSection9Bullet1 =>
      'Wir können Konten bei Verstößen, Missbrauch, Sicherheitsrisiken oder rechtlichen Verpflichtungen sperren oder kündigen.';

  @override
  String get termsSection9Bullet2 =>
      'Du kannst die Nutzung der App jederzeit beenden.';

  @override
  String get termsSection10Title => '10. Gewährleistung und Haftung';

  @override
  String get termsSection10Bullet1 =>
      'Der Dienst wird „wie besehen“ und „wie verfügbar“ bereitgestellt.';

  @override
  String termsSection10Bullet2(Object companyName) {
    return 'Soweit gesetzlich zulässig, schließt $companyName stillschweigende Gewährleistungen aus.';
  }

  @override
  String termsSection10Bullet3(Object companyName) {
    return 'Soweit gesetzlich zulässig, haftet $companyName nicht für indirekte, zufällige oder Folgeschäden.';
  }

  @override
  String get termsSection11Title => '11. Änderungen dieser Bedingungen';

  @override
  String get termsSection11Bullet1 =>
      'Wir können diese Bedingungen von Zeit zu Zeit aktualisieren.';

  @override
  String get termsSection11Bullet2 =>
      'Bei wesentlichen Änderungen informieren wir dich angemessen in der App oder per E-Mail.';

  @override
  String get termsSection11Bullet3 =>
      'Die fortgesetzte Nutzung nach Aktualisierungen bedeutet, dass du den aktualisierten Bedingungen zustimmst.';

  @override
  String get termsSection12Title => '12. Geltendes Recht';

  @override
  String termsSection12Bullet1(Object country) {
    return 'Diese Bedingungen unterliegen dem Recht von $country, ohne Berücksichtigung kollisionsrechtlicher Regelungen.';
  }

  @override
  String get termsSection13Title => '13. Kontakt';

  @override
  String termsSection13Bullet1(Object email) {
    return 'Für Support oder rechtliche Anfragen kontaktiere: $email';
  }

  @override
  String get termsImportantNote =>
      'Wichtig: Bitte lasse die Bedingungen vor der Veröffentlichung rechtlich prüfen.';

  @override
  String get avatarUpdated => 'Avatar aktualisiert.';

  @override
  String get avatarUpdateFailed => 'Avatar konnte nicht aktualisiert werden.';

  @override
  String get avatarRemoved => 'Avatar entfernt.';

  @override
  String get avatarRemoveFailed => 'Avatar konnte nicht entfernt werden.';

  @override
  String get nameUpdated => 'Name aktualisiert.';

  @override
  String get nameUpdateFailed => 'Name konnte nicht aktualisiert werden.';

  @override
  String get editNameTitle => 'Namen bearbeiten';

  @override
  String get passwordMustBeAtLeast8 =>
      'Das Passwort muss mindestens 8 Zeichen lang sein.';

  @override
  String get passwordRequirementsSummary =>
      'Verwende 1 Großbuchstaben, 1 Zahl und 1 Sonderzeichen.';

  @override
  String get emailUnchanged => 'Die E-Mail ist unverändert.';

  @override
  String get verificationEmailSentNewAddress =>
      'Bestätigungs-E-Mail an die neue Adresse gesendet.';

  @override
  String get reauthenticateToUpdateEmail =>
      'Erneut anmelden, um die E-Mail zu aktualisieren';

  @override
  String get reauthenticationFailed => 'Erneute Anmeldung fehlgeschlagen.';

  @override
  String get emailUpdateFailed => 'E-Mail konnte nicht aktualisiert werden.';

  @override
  String get editEmailTitle => 'E-Mail bearbeiten';

  @override
  String get passwordUpdated => 'Passwort aktualisiert.';

  @override
  String get reauthenticateToUpdatePassword =>
      'Erneut anmelden, um das Passwort zu aktualisieren';

  @override
  String get passwordUpdateFailed =>
      'Passwort konnte nicht aktualisiert werden.';

  @override
  String get changePasswordTitle => 'Passwort ändern';

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get passwordRequirementsSummaryShort =>
      'Mind. 8 Zeichen, 1 Großbuchstabe, 1 Zahl, 1 Sonderzeichen.';

  @override
  String get takePhotoLabel => 'Foto aufnehmen';

  @override
  String get chooseFromGalleryLabel => 'Aus Galerie auswählen';

  @override
  String get chooseAvatarLabel => 'Avatar auswählen';

  @override
  String get avatarPickerTitle => 'Wähle deinen Avatar';

  @override
  String get removePhotoLabel => 'Foto entfernen';

  @override
  String get notificationsOffSummary => 'Benachrichtigungen sind deaktiviert.';

  @override
  String notificationsDailyAndInactiveSummary(Object hour, Object minute) {
    return 'Täglich um $hour:$minute und Erinnerungen nach 7 Tagen Inaktivität.';
  }

  @override
  String notificationsDailyOnlySummary(Object hour, Object minute) {
    return 'Tägliche Erinnerung um $hour:$minute.';
  }

  @override
  String get notificationsInactiveOnlySummary =>
      'Nur Erinnerungen nach 7 Tagen Inaktivität.';

  @override
  String get dailyReminderTitle => 'Tägliche Erinnerung';

  @override
  String get dailyReminderSubtitle =>
      'Sende eine tägliche Morgen-Benachrichtigung.';

  @override
  String get reminderTimeTitle => 'Erinnerungszeit';

  @override
  String get inactiveReminderTitle => 'Inaktivitätserinnerung';

  @override
  String get inactiveReminderSubtitle =>
      'Sende eine Erinnerung nach 7 Tagen Abwesenheit.';

  @override
  String get notificationPreferencesSaved =>
      'Benachrichtigungseinstellungen gespeichert.';

  @override
  String get notificationPreferencesSaveFailed =>
      'Benachrichtigungseinstellungen konnten nicht gespeichert werden.';

  @override
  String get accountSectionTitle => 'Konto';

  @override
  String get profilePhotoTitle => 'Profilbild';

  @override
  String get profilePhotoSubtitle =>
      'Füge deinen Avatar hinzu oder entferne ihn.';

  @override
  String get displayNameTitle => 'Anzeigename';

  @override
  String get unknownValueLabel => 'Unbekannt';

  @override
  String get passwordUpdateSubtitle => 'Aktualisiere dein Passwort.';

  @override
  String get passwordManagedByProviderSubtitle =>
      'Wird von deinem Anmeldeanbieter verwaltet.';

  @override
  String get appSectionTitle => 'App';

  @override
  String get themeTitle => 'Design';

  @override
  String get themeSystemLabel => 'System';

  @override
  String get themeLightLabel => 'Hell';

  @override
  String get themeDarkLabel => 'Dunkel';

  @override
  String get cookieMonsterTitle => 'Krümelmonster';

  @override
  String get cookieMonsterJoinPrompt => 'Machst du mit?';

  @override
  String get joinLabel => 'Mitmachen';

  @override
  String get cookieMonsterOutsidePrompt =>
      'Wenn du dir einen Ort vorstellst, an dem du dich wohlfühlst, welche körperlichen Empfindungen bemerkst du in deinem Körper?';

  @override
  String get reflectLabel => 'Reflektieren';

  @override
  String get experienceFeedbackTitle => 'Wie war diese Erfahrung für dich?';

  @override
  String get experienceFeedbackPositive => 'Positiv: tanzen';

  @override
  String get experienceFeedbackNeutral => 'Neutral: määäähhhhhh';

  @override
  String get experienceFeedbackNegative => 'Negativ: umfallen';

  @override
  String get selectBodyAreaFirst => 'Wähle zuerst einen Körperbereich.';

  @override
  String noClipFound(Object activityKey) {
    return 'Kein Clip für „$activityKey“ gefunden.';
  }

  @override
  String failedToLoadMonsterClip(Object error) {
    return 'Monster-Clip konnte nicht geladen werden: $error';
  }

  @override
  String get colorLabel => 'Farbe';

  @override
  String get tapBodyToLogSensation =>
      'Tippe auf den Körper, um eine Empfindung festzuhalten.';

  @override
  String failedToSaveBodyAwarenessWithCode(Object code) {
    return 'Körperwahrnehmung konnte nicht gespeichert werden: $code.';
  }

  @override
  String get failedToSaveBodyAwareness =>
      'Körperwahrnehmung konnte nicht gespeichert werden.';

  @override
  String get stepSkipped => 'Schritt übersprungen.';

  @override
  String get bodyAwarenessPrompt =>
      'Wo scheint dieses Gefühl in deinem Körper zu ruhen?\nBerühre bitte diese Stelle und wähle eine Farbe, die sich für dich stimmig anfühlt.';

  @override
  String get exerciseInstructionWillYouJoin =>
      'Möchtest du mit dem Krümelmonster eine kurze Übung machen?';

  @override
  String get exerciseInstructionOutsideTheBody =>
      'Wenn du dir einen Ort vorstellst, an dem du dich wohlfühlst, welche körperlichen Empfindungen bemerkst du in deinem Körper?';

  @override
  String get exerciseInstructionForeheadContact =>
      'Stirnkontakt:\nLege deine Handfläche auf die Stirn, halte sie einige Sekunden und entspanne dich mit deinem Atem.';

  @override
  String get exerciseInstructionSlowBreathing =>
      'Augen schließen – Atem beobachten:\nSchließe die Augen, atme langsam durch die Nase ein und in 4 Sekunden aus (5 Wiederholungen).';

  @override
  String get exerciseInstructionWeightOfHead =>
      'Spüre das Gewicht deines Kopfes:\nNeige den Kopf sanft nach vorn, spüre die Nackenanspannung und löse sie.';

  @override
  String get exerciseInstructionBreathing478 =>
      '4-7-8-Atmung:\nAtme 4 Sekunden ein, halte 7, atme 8 Sekunden aus (3 Zyklen).';

  @override
  String get exerciseInstructionAbdominalAwareness =>
      'Bauchwahrnehmung:\nLege die Hand auf den Bauch und spüre, wie er sich bei jedem Atemzug hebt und senkt.';

  @override
  String get exerciseInstructionHeartCenter =>
      'Herzöffnung:\nBewege die Brust nach vorn, ziehe die Schultern zurück und atme tief.';

  @override
  String get exerciseInstructionBallSqueezing =>
      'Ball drücken:\nDrücke die Handfläche langsam zusammen und öffne sie wieder (10 Wiederholungen).';

  @override
  String get exerciseInstructionFingerMeditation =>
      'Fingermeditation:\nBerühre mit dem Daumen nacheinander jeden Finger und atme bei jeder Berührung aus.';

  @override
  String get exerciseInstructionHandMassage =>
      'Handmassage:\nMassiere die Mitte deiner Handfläche mit dem Daumen in kleinen Kreisen (je 30 Sekunden pro Hand).';

  @override
  String get exerciseInstructionShoulderDrop =>
      'Schultern fallen lassen:\nHebe die Schultern zu den Ohren und lasse sie wieder los (5 Wiederholungen).';

  @override
  String get exerciseInstructionBackOpening =>
      'Rücken öffnen:\nFalte die Hände hinter dem Rücken, öffne die Brust und atme tief ein.';

  @override
  String get exerciseInstructionReleasingBurdens =>
      'Lasten loslassen:\nSchließe die Augen und stelle dir ein warmes Licht vor, das von deinen Schultern herabfließt.';

  @override
  String get exerciseInstructionRelaxingFacialMuscles =>
      'Gesichtsmuskeln entspannen:\nSchließe die Augen, spanne die Gesichtsmuskeln an und löse sie wieder (3 Wiederholungen).';

  @override
  String get exerciseInstructionJawDrop =>
      'Kiefer lockern:\nÖffne den Mund leicht, entspanne den Kiefer 5 Sekunden lang und schließe ihn wieder.';

  @override
  String get exerciseInstructionSmileToYourself =>
      'Sich selbst anlächeln:\nHalte 30 Sekunden lang ein sanftes Lächeln.';

  @override
  String get exerciseInstructionEftTappingPoints =>
      'EFT-Klopfpunkte:\nKlopfe jeden Punkt 5–7 Mal: Augenbrauenanfang, Seite des Auges, unter dem Auge, unter der Nase, Kinn, Schlüsselbein, unter dem Arm, Scheitel.';

  @override
  String get exerciseInstructionRisingOnTiptoes =>
      'Auf die Zehenspitzen heben:\nHebe beim Ausatmen die Fersen, halte 3–5 Sekunden, senke sie langsam und wiederhole 5–10 Mal.';

  @override
  String get singleClipUrlMissing => 'Die URL des Einzel-Clips fehlt.';

  @override
  String get exerciseClipsMissing => 'Die Übungs-Clips fehlen.';

  @override
  String get videoPlayerInitializationFailed =>
      'Der Videoplayer konnte nicht initialisiert werden. Bitte starte die App vollständig neu.';

  @override
  String get failedToPlayOutroClip =>
      'Der Outro-Clip konnte nicht abgespielt werden.';

  @override
  String get finishExerciseLabel => 'Übung beenden';

  @override
  String get startExerciseLabel => 'Übung starten';

  @override
  String get feedbackQuestionLabel => 'Wie hat dir die Übung gefallen?';

  @override
  String get feedbackVeryGood => 'Sehr gut';

  @override
  String get feedbackGood => 'Gut';

  @override
  String get feedbackMeh => 'Geht so';

  @override
  String get feedbackNotGood => 'Nicht gut';

  @override
  String get feedbackAwful => 'Schrecklich';

  @override
  String get feedbackDoneLabel => 'Fertig';

  @override
  String get careCornerEuNationalPrompt =>
      'For country-specific support and services, please also visit your national bubble.';

  @override
  String get euDisclaimer =>
      'Von der Europäischen Union finanziert. Die geäußerten Ansichten und Meinungen entsprechen jedoch ausschließlich denen des Autors bzw. der Autoren und spiegeln nicht zwingend die der Europäischen Union oder der Europäischen Exekutivagentur für Bildung und Kultur (EACEA) wider. Weder die Europäische Union noch die EACEA können dafür verantwortlich gemacht werden.';

  @override
  String get externalLinkWarningTitle => 'Du verlässt die App';

  @override
  String get externalLinkWarningMessage =>
      'Du bist dabei, eine externe Website zu öffnen. Wir sind nicht für die Inhalte externer Websites verantwortlich.';

  @override
  String get externalLinkCancel => 'Abbrechen';

  @override
  String get externalLinkContinue => 'Fortfahren';

  @override
  String get careCornerNotAvailableMessage => 'Noch nicht verfügbar';

  @override
  String get messageAlreadyOpenedToday =>
      'Du hast die heutige Nachricht bereits geöffnet. Komm morgen wieder!';

  @override
  String get libraryResourcesTitle => 'Ressourcen';

  @override
  String get savedToResources => 'In Ressourcen gespeichert';

  @override
  String get noSavedResourcesYet => 'Noch keine gespeicherten Ressourcen.';

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
}
