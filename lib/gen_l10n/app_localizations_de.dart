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
      'Das wahre Wunder ist, an dich selbst zu glauben.';

  @override
  String get dailyAffirmation2 => 'Vielfalt macht die Welt schön.';

  @override
  String get dailyAffirmation3 => 'Nach dem Regen kommt der Regenbogen.';

  @override
  String get dailyAffirmation4 =>
      'Erlaub dir, echt zu sein – auch dort, wo alle gleich sein sollen.';

  @override
  String get dailyAffirmation5 =>
      'Dein Wert ist nicht, was du hast, sondern wer du bist.';

  @override
  String get dailyAffirmation6 => 'Es ist okay, nicht okay zu sein.';

  @override
  String get dailyAffirmation7 =>
      'An Tischen, die du noch gar nicht kennst, wartet schon ein Platz auf dich.';

  @override
  String get dailyAffirmation8 =>
      'Du kannst alles schaffen – aber du musst nicht.';

  @override
  String get dailyAffirmation9 =>
      'Wenn der Abschied wehtut, heißt das nur: Die Zeit davor war es wert.';

  @override
  String get dailyAffirmation10 => 'Denk daran, wem du wichtig bist.';

  @override
  String get dailyAffirmation11 =>
      'Was, wenn es besser wird, als du es dir vorgestellt hast?';

  @override
  String get dailyAffirmation12 => 'Du bist genug';

  @override
  String get dailyAffirmation13 => 'Ich gehe meinen eigenen Weg';

  @override
  String get dailyAffirmation14 => 'Heute ist ein neuer Tag. Zeit zu strahlen!';

  @override
  String get dailyAffirmation15 =>
      'Verlier nie die Hoffnung. Stürme machen dich stärker – und keiner dauert ewig.';

  @override
  String get dailyAffirmation16 =>
      'Weine. Verzeih. Lerne. Geh weiter. Lass deine Tränen die Saat für dein Glück von morgen gießen.';

  @override
  String get dailyAffirmation17 =>
      'Leicht wird es vielleicht nicht – aber es wird sich lohnen.';

  @override
  String get dailyAffirmation18 =>
      'Vergiss nicht, auch auf das Gute zu schauen.';

  @override
  String get dailyAffirmation19 =>
      'Das ist nicht egoistisch, das ist Selbstfürsorge.';

  @override
  String get dailyAffirmation20 => 'Du bist großartig. Bleib dran!';

  @override
  String get dailyAffirmation21 =>
      'Glaub an dich. Du kannst Wunder vollbringen';

  @override
  String get dailyAffirmation22 =>
      'Das Leben fließt weiter – und auch das geht vorbei.';

  @override
  String get dailyAffirmation23 =>
      'Jede Herausforderung, vor der ich stehe, ist eine Chance, stärker zu werden.';

  @override
  String get dailyAffirmation24 =>
      'Ich nehme die Fragen in meinem Herzen an – die Antworten dürfen kommen, wenn ihre Zeit da ist.';

  @override
  String get dailyAffirmation25 => 'Du musst nicht perfekt sein.';

  @override
  String get dailyAffirmation26 =>
      'Perfektion ist eine Utopie. Sie taugt nur als Kompass.';

  @override
  String get dailyAffirmation27 => 'Ich stehe auf und kämpfe für meine Träume.';

  @override
  String get dailyAffirmation28 =>
      'Lass nicht andere über deine Zukunft entscheiden.';

  @override
  String get dailyAffirmation29 =>
      'Ich bin geerdet, widerstandsfähig und offen dafür, auch in unsicheren Zeiten zu wachsen.';

  @override
  String get dailyAffirmation30 =>
      'Wenn das Leben dir Momente schenkt, mach schöne Erinnerungen draus.';

  @override
  String get dailyAffirmation31 => 'Alte Wege öffnen keine neuen Türen.';

  @override
  String get dailyAffirmation32 =>
      'Fehler sind der Beweis, dass du es versuchst.';

  @override
  String get dailyAffirmation33 =>
      'Mach einfach diesen einen Schritt und versuch es – das reicht.';

  @override
  String get dailyAffirmation34 =>
      'Schau nur, was wir schaffen, wenn wir zusammenhalten.';

  @override
  String get dailyAffirmation35 =>
      'Wenn du nicht weißt, wohin du willst, führt dich jeder Weg ans Ziel.';

  @override
  String get dailyAffirmation36 =>
      'Das Leben ist ein einziger Tag – und der ist heute.';

  @override
  String get dailyAffirmation37 => 'Wir alle bestehen aus Sternenstaub.';

  @override
  String get dailyAffirmation38 =>
      'Träume mit Leidenschaft, lebe mit Verantwortung.';

  @override
  String get dailyAffirmation39 => 'Alles wird gut. Sag es noch einmal.';

  @override
  String get dailyAffirmation40 =>
      'Sei schräg, sei einzigartig, sei du selbst.';

  @override
  String get dailyAffirmation41 => 'Starke Köpfe wachsen in sicheren Räumen.';

  @override
  String get dailyAffirmation42 =>
      'Jeder Anfang ist ja doch nur eine Fortsetzung, und das Buch der Ereignisse ist immer in der Mitte aufgeschlagen.';

  @override
  String get dailyAffirmation43 =>
      'Alles hat einen Anfang und ein Ende – und das Ende kann schön sein, egal wie dunkel es gerade aussieht.';

  @override
  String get dailyAffirmation44 =>
      'Die einzige Zustimmung, die ich je brauchen werde, ist meine eigene.';

  @override
  String get dailyAffirmation45 =>
      'Wir sollten nicht nach Helden suchen, sondern nach guten Ideen.';

  @override
  String get dailyAffirmation46 =>
      'Die kleinste gute Tat ist mehr wert als der größte gute Vorsatz.';

  @override
  String get dailyAffirmation47 =>
      'Wo du herkommst, ist nichts, was du kleinreden musst – es ist ein Boden, auf dem du stehen kannst.';

  @override
  String get dailyAffirmation48 =>
      'Dein Name, deine Sprache, die Geschichte deiner Familie – das alles darfst du mit Stolz tragen.';

  @override
  String get dailyAffirmation49 =>
      'Du brauchst keine Erlaubnis, um in dieser Welt Raum einzunehmen.';

  @override
  String get dailyAffirmation50 =>
      'Du bist nicht \"zu viel\" von irgendwas. Du bist genau die richtige Menge du.';

  @override
  String get dailyAffirmation51 =>
      'Deine Wurzeln halten dich nicht zurück. Sie sind es, die dich groß wachsen lassen.';

  @override
  String get dailyAffirmation52 =>
      'Es gibt nicht nur einen Weg, irgendwo dazuzugehören. Du darfst deinen eigenen schreiben.';

  @override
  String get dailyAffirmation53 =>
      'Deine Geschichte zählt – auch die Teile, nach denen noch niemand gefragt hat.';

  @override
  String get dailyAffirmation54 =>
      'Du trägst mehr als ein Zuhause in dir – das ist keine Last, das ist ein Reichtum.';

  @override
  String get dailyAffirmation55 =>
      'Um stolz darauf zu sein, wer du bist, brauchst du niemandes Zustimmung.';

  @override
  String get dailyAffirmation56 =>
      'Du musst dir deinen Platz hier nicht verdienen. Du hast schon einen.';

  @override
  String get dailyAffirmation57 =>
      'Irgendwo steht eine Tür für dich offen – auch an Tagen, an denen es sich nicht so anfühlt.';

  @override
  String get dailyAffirmation58 =>
      'Du darfst dir an mehr als einem Ort ein Zuhause bauen.';

  @override
  String get dailyAffirmation59 =>
      'Die Menschen, die zählen, machen Platz für dich – sie verlangen nicht, dass du dich klein machst.';

  @override
  String get dailyAffirmation60 => 'Du bist kein Gast in deinem eigenen Leben.';

  @override
  String get dailyAffirmation61 =>
      'Wo auch immer du heute stehst: Du hast jedes Recht, genau dort zu stehen.';

  @override
  String get dailyAffirmation62 =>
      'Gemeinschaft ist nichts, worauf du warten musst – manchmal fängt sie mit dir an.';

  @override
  String get dailyAffirmation63 =>
      'Du musst dich nicht entscheiden zwischen dem Ort, aus dem du kommst, und dem Ort, an dem du gerade bist.';

  @override
  String get dailyAffirmation64 => 'Heute muss nicht so aussehen wie morgen.';

  @override
  String get dailyAffirmation65 =>
      'Irgendwo weiter vorn wartet eine Version deines Lebens, die du dir noch gar nicht ausgemalt hast – und sie ist gut.';

  @override
  String get dailyAffirmation66 => 'Schwere Kapitel gehen zu Ende. Deins auch.';

  @override
  String get dailyAffirmation67 =>
      'Du darfst mehr für dich wollen – und es dir holen.';

  @override
  String get dailyAffirmation68 =>
      'Die Zukunft steht nicht fest. Du kannst noch mitbestimmen.';

  @override
  String get dailyAffirmation69 => 'Auch kleine Schritte bringen dich voran.';

  @override
  String get dailyAffirmation70 =>
      'Du hängst nicht hinterher. Du bist genau da, wohin dein Weg dich gebracht hat.';

  @override
  String get dailyAffirmation71 =>
      'Was auf dich zukommt, ist noch nicht passiert. Lass ihm Raum, dich zu überraschen.';

  @override
  String get dailyAffirmation72 =>
      'Wie deine Geschichte ab hier weitergeht, entscheidest du.';

  @override
  String get dailyAffirmation73 =>
      'Du hast bisher jeden schweren Tag überstanden. Das ist kein Glück – das bist du.';

  @override
  String get dailyAffirmation74 =>
      'Müde zu sein heißt nicht, dass du versagst. Es heißt, dass du viel getragen hast.';

  @override
  String get dailyAffirmation75 =>
      'Du musst nicht unzerbrechlich sein. Du musst nur in deinem eigenen Tempo weitergehen.';

  @override
  String get dailyAffirmation76 =>
      'Stärke heißt nicht, nie zu kämpfen. Stärke heißt, trotzdem wieder aufzustehen.';

  @override
  String get dailyAffirmation77 =>
      'Du darfst stolz darauf sein, dass du durchgekommen bist – auch wenn es nicht schön aussah.';

  @override
  String get dailyAffirmation78 =>
      'Die härtesten Teile deiner Geschichte haben nicht das letzte Wort.';

  @override
  String get dailyAffirmation79 =>
      'Du hast Dinge überstanden, die niemand sieht – und das zählt.';

  @override
  String get dailyAffirmation80 =>
      'Es ist okay, wenn Heilung länger dauert als gedacht.';

  @override
  String get dailyAffirmation81 =>
      'Du musst nicht erst alles verstehen, um weiterzugehen.';

  @override
  String get dailyAffirmation82 =>
      'Jeder Tag, an dem du weitermachst, ist eine leise Form von Mut.';

  @override
  String get dailyAffirmation83 =>
      'Du darfst ganz legal einen mittelmäßigen Tag haben. Genehmigung nicht erforderlich.';

  @override
  String get dailyAffirmation84 =>
      'Manchmal besteht das Leben nur daraus, dreimal am Tag zu entscheiden, was du isst. Für immer. Du schaffst das.';

  @override
  String get dailyAffirmation85 =>
      'Nicht jeder Tag muss ein Meisterwerk sein. Manche Tage müssen einfach nur stattfinden.';

  @override
  String get dailyAffirmation86 =>
      'Du kriegst dein Leben besser hin, als deine ungelesenen Gruppenchats vermuten lassen.';

  @override
  String get dailyAffirmation87 =>
      'Selbstvertrauen ist einfach so zu tun, als wüsstest du, wo es langgeht – bis du es wirklich weißt.';

  @override
  String get dailyAffirmation88 =>
      'Du hast 100% deiner schlimmsten Tage überlebt. Solide Bilanz.';

  @override
  String get dailyAffirmation89 =>
      'Niemand hat alles im Griff. Wer so wirkt, ist nur besser darin, erst Stunden später zurückzuschreiben.';

  @override
  String get dailyAffirmation90 =>
      'Du brauchst heute keinen Fünfjahresplan. Ein ordentliches Frühstück reicht.';

  @override
  String get dailyAffirmation91 =>
      'Wachstum sieht meistens so aus: vorwärtsstolpern und es Fortschritt nennen.';

  @override
  String get dailyAffirmation92 =>
      'An manchen Tagen ist der Sieg einfach: Du bist aufgestanden. Das zählt.';

  @override
  String get dailyAffirmation93 =>
      'Du musst nicht alles allein tragen – lass dir helfen.';

  @override
  String get dailyAffirmation94 =>
      'Da draußen hält dir jemand den Rücken frei – auch an Tagen, an denen du es kaum spürst.';

  @override
  String get dailyAffirmation95 =>
      'Um Hilfe zu bitten ist keine Schwäche. Genau so entstehen echte Freundschaften.';

  @override
  String get dailyAffirmation96 =>
      'Die Menschen um dich herum brauchen dich genauso sehr wie du sie.';

  @override
  String get dailyAffirmation97 =>
      'Du bist Teil von etwas Größerem – auch an Tagen, an denen du dich unsichtbar fühlst.';

  @override
  String get dailyAffirmation98 =>
      'Du darfst dich ausruhen, bevor du komplett erschöpft bist.';

  @override
  String get dailyAffirmation99 =>
      'Dass du heute traurig bist, schließt nicht aus, dass es dir morgen wieder gut geht.';

  @override
  String get dailyAffirmation100 =>
      'Du schuldest niemandem ständig gute Laune.';

  @override
  String get dailyAffirmation101 =>
      'Es ist völlig okay, gerade keine Antwort zu haben.';

  @override
  String get dailyAffirmation102 =>
      'Heute gut für dich zu sorgen ist nicht egoistisch – es ist nötig.';

  @override
  String get dailyAffirmation103 =>
      'Die Vorurteile anderer sagen nichts darüber aus, wer du bist.';

  @override
  String get dailyAffirmation104 =>
      'Du bist nicht die Geschichte, die andere über dich erzählen.';

  @override
  String get dailyAffirmation105 =>
      'Zu glauben, du hättest weniger verdient, ist nie wahr. Du verdienst vollen Respekt.';

  @override
  String get dailyAffirmation106 =>
      'Dein Wert steht nie zur Debatte – egal, wer dir ein anderes Gefühl geben will.';

  @override
  String get dailyAffirmation107 =>
      'Du bist nicht unsichtbar. Jemand hier sieht genau, wer du bist.';

  @override
  String get dailyAffirmation108 =>
      'Dass manche dich übersehen, heißt nicht, dass alle es tun.';

  @override
  String get dailyAffirmation109 =>
      'Du bist wichtig – auch in Räumen, in denen das niemand laut ausspricht.';

  @override
  String get dailyAffirmation110 =>
      'Jemand hat dich bemerkt. Du bist nicht so unsichtbar, wie es sich anfühlt.';

  @override
  String get dailyAffirmation111 =>
      'Du musst dich nicht klein machen, um aus den richtigen Gründen gesehen zu werden.';

  @override
  String get dailyAffirmation112 =>
      'Gesehen werden beginnt damit, wie du dich selbst siehst – und genau da darfst du anfangen.';

  @override
  String get dailyAffirmation113 =>
      'Du bist nicht \"zu viel\" und nicht \"zu wenig\". Du wirst einfach gesehen.';

  @override
  String get dailyAffirmation114 =>
      'Es gibt Menschen, die genau das schätzen, was dich zu dir macht.';

  @override
  String get dailyAffirmation115 =>
      'Deine Anwesenheit verändert einen Raum – auch wenn es sich nicht so anfühlt.';

  @override
  String get dailyAffirmation116 =>
      'Mehr Menschen kennen dich – auf mehr Arten – als du ahnst.';

  @override
  String get dailyAffirmation117 =>
      'Du kannst nicht alles kontrollieren, was dir passiert. Aber wie du dem begegnest, entscheidest du.';

  @override
  String get dailyAffirmation118 =>
      'Was als Nächstes für dich kommt, bestimmst du.';

  @override
  String get dailyAffirmation119 =>
      'Kleine Entscheidungen gehören immer noch dir – auch wenn die Umstände schwer sind.';

  @override
  String get dailyAffirmation120 =>
      'In deinem eigenen Leben sitzt du nicht auf dem Beifahrersitz.';

  @override
  String get dailyAffirmation121 =>
      'Zu sagen, was du brauchst, ist eine Form von Stärke – nicht von Schwäche.';

  @override
  String get dailyAffirmation122 =>
      'Du hast hier ein Wörtchen mitzureden – auch wenn es sich gerade nicht so anfühlt.';

  @override
  String get dailyAffirmation123 =>
      'Dein nächstes Kapitel schreibt niemand außer dir.';

  @override
  String get dailyAffirmation124 =>
      'Auch in Systemen, die nicht für dich gebaut wurden, zählen deine Entscheidungen.';

  @override
  String get dailyAffirmation125 =>
      'Du darfst dir wünschen, dass es anders wird – und daran arbeiten.';

  @override
  String get dailyAffirmation126 =>
      'Was du aus dem heutigen Tag machst, liegt immer noch bei dir.';

  @override
  String get dailyAffirmation127 =>
      'Du musst dich nicht verändern, um deinen Platz hier verdient zu haben.';

  @override
  String get dailyAffirmation128 =>
      'Es gibt Menschen, die dir Raum geben, genau so zu sein, wie du bist.';

  @override
  String get dailyAffirmation129 =>
      'Du gehörst zu mehr als einem Ort – und das ist kein Widerspruch.';

  @override
  String get dailyAffirmation130 =>
      'Echte Verbundenheit verlangt nicht, dass du einen Teil von dir versteckst.';

  @override
  String get dailyAffirmation131 =>
      'Irgendwo ist jemand froh, dass es dich gibt.';

  @override
  String get dailyAffirmation132 =>
      'Du musst dich nicht erklären, um dazuzugehören.';

  @override
  String get dailyAffirmation133 =>
      'Für Gemeinschaft musst du dich nicht qualifizieren. Du bist längst mittendrin.';

  @override
  String get dailyAffirmation134 =>
      'Weit entfernt von dort zu sein, wo du angefangen hast, heißt nicht, dass du kein Zuhause hast.';

  @override
  String get dailyAffirmation135 =>
      'Du musst das nicht allein durchstehen – auch wenn es sich gerade so anfühlt.';

  @override
  String get dailyAffirmation136 =>
      'Es gibt Menschen, die ihr Leben an deiner Seite bauen – nicht nur welche, die von außen zuschauen.';

  @override
  String get dailyAffirmation137 =>
      'In deinen Wurzeln steckt die Stärke von Generationen – und die hast du mitgeerbt.';

  @override
  String get dailyAffirmation138 =>
      'Deine Sprache, deine Traditionen, die Geschichte deiner Familie – es lohnt sich, sie lebendig zu halten.';

  @override
  String get dailyAffirmation139 =>
      'Genau das, was deine Gemeinschaft anders macht, macht es so wertvoll, dazuzugehören.';

  @override
  String get dailyAffirmation140 =>
      'Du schuldest niemandem eine Entschuldigung für deine Herkunft.';

  @override
  String get dailyAffirmation141 =>
      'Dein Erbe ist nichts, was du in den Griff kriegen musst. Es ist etwas, worauf du stolz sein kannst.';

  @override
  String get dailyAffirmation142 =>
      'Deine Kultur ist kein Problem, das gelöst werden muss. Sie ist Teil deiner Stärke.';

  @override
  String get dailyAffirmation143 =>
      'Stolz darauf zu sein, wer du bist, heißt nicht, naiv durch die Welt zu gehen.';

  @override
  String get dailyAffirmation144 =>
      'Deine Identität ist keine Last, die du trägst. Sie ist ein Fundament, auf dem du stehst.';

  @override
  String get dailyAffirmation145 =>
      'Was dir weitergegeben wurde, verdient es, weitergetragen zu werden.';

  @override
  String get dailyAffirmation146 =>
      'Es ist okay, wenn sich heute alles leer anfühlt. Du musst nicht so tun, als wäre alles gut.';

  @override
  String get dailyAffirmation147 =>
      'Du darfst es leid sein, dich ständig erklären zu müssen.';

  @override
  String get dailyAffirmation148 =>
      'Traurig zu sein heißt nicht, dass du schwach bist. Es heißt, dass du etwas Echtes wahrnimmst.';

  @override
  String get dailyAffirmation149 =>
      'Du musst nicht jeden einzelnen Tag Hoffnung haben. An manchen Tagen reicht es, einfach durchzukommen.';

  @override
  String get dailyAffirmation150 =>
      'Es ist okay, wütend zu sein über Dinge, die nie fair waren.';

  @override
  String get dailyAffirmation151 =>
      'Über etwas Echtes zu weinen ist nicht dasselbe wie auseinanderzufallen.';

  @override
  String get dailyAffirmation152 =>
      'Du musst nicht begründen, warum etwas wehgetan hat. Es hat wehgetan. Das reicht.';

  @override
  String get dailyAffirmation153 =>
      'An manchen Tagen liegt die Messlatte bei \"Ich hab mich angezogen\". Respektier die Messlatte.';

  @override
  String get dailyAffirmation154 =>
      'Du hast 100% deiner Montage überstanden. Ungeschlagen.';

  @override
  String get dailyAffirmation155 =>
      'Niemandes Leben sieht wirklich so aus wie auf den Fotos. Deins muss das auch nicht.';

  @override
  String get dailyAffirmation156 =>
      'Erwachsensein ist 10% Weisheit und 90% so tun, als wüsstest du, wie der Drucker funktioniert.';

  @override
  String get dailyAffirmation157 =>
      'Du bist genau einen Snack davon entfernt, dich wie ein etwas besserer Mensch zu fühlen. Hol ihn dir.';

  @override
  String get dailyAffirmation158 =>
      'Selbstbewusstsein heißt, einen Raum so zu betreten, als wärst du dort gemeldet.';

  @override
  String get dailyAffirmation159 =>
      'Es ist okay, deine Gefühle manchmal einfach wegzuschlafen. Gefühle sind geduldig.';

  @override
  String get dailyAffirmation160 =>
      'Du musst kein \"Morgenmensch\" sein. Du musst den Morgen nur überleben.';

  @override
  String get dailyAffirmation161 =>
      'Grübeln verbrennt wahrscheinlich auch Kalorien. Du hast dir den Nachtisch verdient.';

  @override
  String get dailyAffirmation162 =>
      'Manche Entscheidungen triffst du am besten per Münzwurf – erleichtert bist du so oder so.';

  @override
  String get dailyAffirmation163 =>
      'Rein statistisch machst du das großartig – verglichen mit einem Waschbären in der Mülltonne.';

  @override
  String get dailyAffirmation164 =>
      'Tief durchatmen zählt schon als komplette Wellness-Routine. Läuft bei dir.';

  @override
  String get dailyAffirmation165 =>
      'Wäre heute ein Gruppenprojekt, hättest du mehr gemacht als die halbe Gruppe.';

  @override
  String get dailyAffirmation166 =>
      'Beim ersten Versuch überlebt niemandes Zimmerpflanze. Du machst das besser, als du denkst.';

  @override
  String get dailyAffirmation167 =>
      'Rein technisch gesehen hast du bisher jeden einzelnen \"schlimmsten Tag aller Zeiten\" überlebt.';

  @override
  String get dailyAffirmation168 =>
      'Müdigkeit ist nur dein Körper, der dir applaudiert, weil du den ganzen Tag existiert hast.';

  @override
  String get dailyAffirmation169 =>
      'Nicht jeder Tag braucht einen Plot-Twist. Manche Tage brauchen nur Snacks und ein Nickerchen.';

  @override
  String get dailyAffirmation170 =>
      'Du darfst unfertig sein und trotzdem heute schon ein ganzer Mensch.';

  @override
  String get dailyAffirmation171 =>
      'Etwas Beängstigendes aufzuschieben ist nur dein Gehirn, das ein guter Kumpel sein will.';

  @override
  String get dailyAffirmation172 =>
      'Das Leben kommt ohne Gebrauchsanweisung. Also ehrlich: Du improvisierst großartig.';

  @override
  String get dailyAffirmation173 =>
      'Du spielst heute die Hauptrolle – auch wenn der Plot nur Wäsche ist.';

  @override
  String get dailyAffirmation174 =>
      'Es ist okay, wenn dein Leben gerade nicht aufgeräumt ist. Das ist es bei niemandem – die anderen haben nur besseres Licht.';

  @override
  String get dailyAffirmation175 =>
      'Du hast dich heute ohne Anleitung durch den Tag navigiert – im Grunde eine Superkraft.';

  @override
  String get dailyAffirmation176 =>
      'Kleine Siege zählen auch – sogar solche wie \"auf die eine Nachricht geantwortet\".';

  @override
  String get dailyAffirmation177 =>
      'Du musst den Tag nicht gewinnen. Ihn mit Snacks zu überstehen ist eine völlig legitime Strategie.';

  @override
  String get dailyAffirmation178 =>
      'An manchen Tagen bist du ein Löwe. An anderen ein Löwe, der einfach nur eine Decke will. Beides ist okay.';

  @override
  String get dailyAffirmation179 =>
      'Du darfst über das Chaos lachen. Meistens ist das die gesündeste Reaktion.';

  @override
  String get dailyAffirmation180 =>
      'Dein zukünftiges Ich wird dir für das Nickerchen danken, das du gleich machst.';

  @override
  String get dailyAffirmation181 =>
      'Du verdienst Liebe, die nicht verlangt, dass du dich erst veränderst.';

  @override
  String get dailyAffirmation182 =>
      'Du verdienst Ruhe – auch an Tagen, an denen du sie dir nicht \"verdient\" hast.';

  @override
  String get dailyAffirmation183 =>
      'Du verdienst es, Raum einzunehmen – genau so, wie du bist.';

  @override
  String get dailyAffirmation184 =>
      'Du verdienst es, dass man sich für dich entscheidet – nicht nur, dass man dich duldet.';

  @override
  String get dailyAffirmation185 =>
      'Du verdienst Freundlichkeit – auch deine eigene.';

  @override
  String get dailyAffirmation186 =>
      'Du verdienst gute Dinge – auch die, um die du nie gebeten hast.';

  @override
  String get dailyAffirmation187 =>
      'Du verdienst Menschen, die für dich da sind.';

  @override
  String get dailyAffirmation188 =>
      'Du verdienst ein Leben, das sich wie deins anfühlt.';

  @override
  String get dailyAffirmation189 =>
      'Du verdienst es, dass man dir glaubt, wenn du etwas sagst.';

  @override
  String get dailyAffirmation190 =>
      'Du verdienst Sanftheit – auch in einer harten Welt.';

  @override
  String get dailyAffirmation191 =>
      'Du verdienst Freude, die keine Erklärung braucht.';

  @override
  String get dailyAffirmation192 =>
      'Du verdienst Sicherheit – egal, wo du bist.';

  @override
  String get dailyAffirmation193 =>
      'Du verdienst Liebe, die du dir nicht erst verdienen musst.';

  @override
  String get dailyAffirmation194 =>
      'Du verdienst einen Platz am Tisch – nicht nur eine Ecke im Raum.';

  @override
  String get dailyAffirmation195 =>
      'Du verdienst Träume, die deine eigenen sind – nicht von anderen geliehen.';

  @override
  String get dailyAffirmation196 =>
      'Du verdienst Geduld – vor allem deine eigene.';

  @override
  String get dailyAffirmation197 =>
      'Du verdienst es, verstanden zu werden – nicht nur geduldet.';

  @override
  String get dailyAffirmation198 =>
      'Du verdienst es, dass dir Gutes passiert – nicht nur, dass du überlebst.';

  @override
  String get dailyAffirmation199 =>
      'Du verdienst es, gefeiert zu werden – nicht nur akzeptiert.';

  @override
  String get dailyAffirmation200 =>
      'Du verdienst Wertschätzung – genau so, wie du heute bist, mit allen Baustellen.';

  @override
  String get dailyAffirmation201 =>
      'Du verdienst eine Zukunft, die deine schwersten Tage nicht wiederholt.';

  @override
  String get dailyAffirmation202 =>
      'Du verdienst es, stolz auf dich zu sein – ganz ohne Bedingungen.';

  @override
  String get dailyAffirmation203 =>
      'Du verdienst Menschen, neben denen du dich nicht klein machen musst.';

  @override
  String get dailyAffirmation204 =>
      'Du verdienst deinen eigenen Respekt – zuerst und immer.';

  @override
  String get dailyAffirmation205 =>
      'Du verdienst liebevolle Nachsicht – gerade an den Tagen, an denen du glaubst, sie nicht zu verdienen.';

  @override
  String get dailyAffirmation206 =>
      'Du verdienst es, für jemanden der Lieblingsmensch zu sein.';

  @override
  String get dailyAffirmation207 =>
      'Du verdienst ein Leben mit mehr Leichtigkeit.';

  @override
  String get dailyAffirmation208 =>
      'Du verdienst Liebe und Respekt – nicht für das, was du tust, sondern weil es dich gibt.';

  @override
  String get dailyAffirmation209 =>
      'Du verdienst es, gewollt zu werden – nicht nur gebraucht.';

  @override
  String get dailyAffirmation210 =>
      'Du verdienst es, dir selbst wieder zu vertrauen.';

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
