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
      'Тука можеш да ги видиш и уредиш своите податоци.';

  @override
  String get galleryTitle => 'Галерија';

  @override
  String get galleryBody => 'Прелистај ја својата галерија со фотографии тука.';

  @override
  String get settingsTitle => 'Поставки';

  @override
  String get settingsBody => 'Управувај со поставките на апликацијата тука.';

  @override
  String get helpTitle => 'Помош и поддршка';

  @override
  String get helpBody => 'Добиј помош и поддршка тука.';

  @override
  String get settingsPreferencesTitle => 'Преференци';

  @override
  String get settingsPreferencesBody =>
      'Прилагоди го искуството во апликацијата.';

  @override
  String get settingsNotificationsTitle => 'Известувања';

  @override
  String get settingsNotificationsBody => 'Избери како да те известуваме.';

  @override
  String get settingsLanguageTitle => 'Јазик';

  @override
  String get settingsLanguageBody => 'Избери го јазикот на апликацијата.';

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
  String get registrationTitle => 'Создај своја сметка';

  @override
  String get registrationSubtitle =>
      'Пополни ги своите податоци за да започнеш.';

  @override
  String get fullNameLabel => 'Име и презиме';

  @override
  String get emailLabel => 'Е-пошта';

  @override
  String get confirmPasswordLabel => 'Потврди ја лозинката';

  @override
  String get registerButton => 'Регистрирај се';

  @override
  String get registerLink => 'Регистрирај се';

  @override
  String get noAccountPrompt => 'Немаш сметка?';

  @override
  String get alreadyHaveAccount => 'Веќе имаш сметка?';

  @override
  String get fieldRequired => 'Ова поле е задолжително.';

  @override
  String get invalidEmail => 'Внеси валидна е-пошта.';

  @override
  String get passwordTooShort => 'Лозинката мора да има најмалку 6 знаци.';

  @override
  String get passwordsDoNotMatch => 'Лозинките не се совпаѓаат.';

  @override
  String get registerSuccess => 'Регистрацијата е завршена.';

  @override
  String get mySpaceLabel => 'Мој простор';

  @override
  String get messagesLabel => 'Пораки';

  @override
  String get logoutLabel => 'Одјави се';

  @override
  String get userMenuTooltip => 'Кориснички мени';

  @override
  String get userMenuAccountFallback => 'Сметка';

  @override
  String get guidedMeditationTitle => 'Водена медитација';

  @override
  String get guidedMeditationDescription =>
      'Одвој момент за да дишеш и да слушаш.';

  @override
  String get guidedMeditationMetadataLoadFailed =>
      'Метаподатоците не може да се вчитаат. Се пушта резервна нумера.';

  @override
  String get guidedMeditationSourceFirebase => 'Извор: Firebase';

  @override
  String get guidedMeditationSourceFallback =>
      'Извор: вградена резервна нумера';

  @override
  String get skipLabel => 'Прескокни';

  @override
  String get pauseLabel => 'Пауза';

  @override
  String get playLabel => 'Пушти';

  @override
  String get homeHowFeelingToday => 'Како се чувствуваш денес?';

  @override
  String get startLabel => 'Почни';

  @override
  String get savingLabel => 'Се зачувува...';

  @override
  String get canvasNotReady => 'Платното сè уште не е подготвено.';

  @override
  String saveFailedWithError(Object error) {
    return 'Зачувувањето не успеа: $error';
  }

  @override
  String get bodyTransitionPrompt =>
      'Сакаш ли да одвоиш момент и нежно да се поврзеш со физичките сензации во своето тело пред да го препознаеш чувството?';

  @override
  String get yesLabel => 'Yes';

  @override
  String get noLabel => 'No';

  @override
  String get continueLabel => 'Продолжи';

  @override
  String get saveLabel => 'Зачувај';

  @override
  String get homeCheckAgainAnytime =>
      'Може повторно да се пријавиш во секое време денес.';

  @override
  String get moodCheckLabel => 'Проверка на расположението';

  @override
  String get bodyCheckLabel => 'Проверка на телото';

  @override
  String get meditationLabel => 'Медитација';

  @override
  String get moodCheckFullscreenTitle =>
      'Проверка на расположението (цел екран)';

  @override
  String get exitFullscreenLabel => 'Излези од цел екран';

  @override
  String get fullscreenLabel => 'Цел екран';

  @override
  String get skipToQuoteLabel => 'Премини на цитат';

  @override
  String homeGreeting(Object name) {
    return 'Здраво $name, како се чувствуваш денес?';
  }

  @override
  String get todaysAffirmationLabel => 'Афирмација на денот';

  @override
  String get thereFallback => 'ти';

  @override
  String get dailyAffirmation1 =>
      'Дозволено ти е да го преживееш овој ден дишејќи еден здив по еден.';

  @override
  String get dailyAffirmation2 =>
      'Твоите чувства се важни, а твоето тело заслужува нежна грижа.';

  @override
  String get dailyAffirmation3 => 'Посилен си отколку што се чини овој момент.';

  @override
  String get dailyAffirmation4 =>
      'Малите чекори денес сепак се значаен напредок.';

  @override
  String get dailyAffirmation5 =>
      'Припаѓаш токму онаков каков што си, тука и сега.';

  @override
  String get dailyAffirmation6 =>
      'Твојот глас, твоето темпо и твоето исцелување се важни.';

  @override
  String get dailyAffirmation7 => 'Може да се одмараш и сепак да растеш.';

  @override
  String get dailyAffirmation8 =>
      'Вистината е: природниот свет се менува. И ние сме целосно зависни од тој свет.';

  @override
  String get dailyAffirmation9 => 'Сите сме направени од ѕвездена прашина.';

  @override
  String get dailyAffirmation10 =>
      'Сонувајте со страст, живејте со одговорност.';

  @override
  String get dailyAffirmation11 =>
      'Само погледнете што можеме да направиме кога ќе се собереме.';

  @override
  String get dailyAffirmation12 =>
      'Страдај сега и живеј го остатокот од животот како шампион.';

  @override
  String get dailyAffirmation13 => 'Се ќе биде во ред. Кажи уште еднаш.';

  @override
  String get dailyAffirmation14 =>
      'Само направете го тој чекор и обидете се, доста е.';

  @override
  String get dailyAffirmation15 => 'Направете бран на позитивни промени.';

  @override
  String get dailyAffirmation16 => 'Старите начини нема да отворат нови врати.';

  @override
  String get dailyAffirmation17 => 'Грешките се доказ дека се трудите.';

  @override
  String get dailyAffirmation18 =>
      'Вашето срце е со големина на океан. Оди најди се во нејзините скриени длабочини.';

  @override
  String get dailyAffirmation19 =>
      'Бидете чудни, бидете уникатни, бидете свои.';

  @override
  String get dailyAffirmation20 =>
      'Што и да се случи, се случува на најдоброто.';

  @override
  String get dailyAffirmation21 =>
      'Дејствата можат да зборуваат погласно од зборовите.';

  @override
  String get dailyAffirmation22 =>
      'Откако постоевме, макар и за момент, тогаш постоиме засекогаш.';

  @override
  String get dailyAffirmation23 =>
      'Ако збогувањето ве боли, тоа значи дека добро сте го поминале времето.';

  @override
  String get dailyAffirmation24 =>
      'Ако животот ви дава моменти, направете им убави спомени.';

  @override
  String get dailyAffirmation25 => 'Она што оди наоколу, доаѓа наоколу.';

  @override
  String get dailyAffirmation26 => 'Различноста го прави светот убав.';

  @override
  String get dailyAffirmation27 => 'Се е во ред, нема проблем.';

  @override
  String get dailyAffirmation28 =>
      'Што мислиш, стануваш. Тоа што го чувствуваш, го привлекуваш. Она што го замислувате, го создавате.';

  @override
  String get dailyAffirmation29 => 'Силните умови растат во безбедни простори.';

  @override
  String get dailyAffirmation30 =>
      'Сè е можно, само обидете се. Можете да го направите тоа.';

  @override
  String get dailyAffirmation31 =>
      'На крајот на краиштата, секој почеток е само продолжение, а книгата на настани е секогаш отворена на половина пат.';

  @override
  String get dailyAffirmation32 =>
      'Јас сум приземјен, издржлив и отворен за раст дури и во несигурни времиња.';

  @override
  String get dailyAffirmation33 =>
      'Бидете личноста која ви била потребна кога сте биле помлади.';

  @override
  String get dailyAffirmation34 =>
      'Во се има пукнатина, така влегува светлината.';

  @override
  String get dailyAffirmation35 =>
      'Стојам и се борам да си ги најдам соништата.';

  @override
  String get dailyAffirmation36 =>
      'Не дозволувајте другиот да одлучува за вашата иднина.';

  @override
  String get dailyAffirmation37 => 'На светот му требаат повеќе лути жени.';

  @override
  String get dailyAffirmation38 =>
      'Сонцето ќе изгрее и ќе се обидеме повторно.';

  @override
  String get dailyAffirmation39 =>
      'Скитник, нема патека. Патеката ја правиш додека одиш.';

  @override
  String get dailyAffirmation40 => 'Не мора да бидете совршени.';

  @override
  String get dailyAffirmation41 =>
      'Совршенството е утопија. Служи само како компас.';

  @override
  String get dailyAffirmation42 =>
      'Сè има почеток и крај, а крајот може да биде убав, без разлика колку е темно сега.';

  @override
  String get dailyAffirmation43 =>
      'Го кревам гласот - не за да можам да викам, туку за да се слушнат оние без глас.';

  @override
  String get dailyAffirmation44 =>
      'Сè што изгледа дека ве дави, всушност само ве учи да пливате.';

  @override
  String get dailyAffirmation45 => 'Ако имаш цел, ќе најдеш начин.';

  @override
  String get dailyAffirmation46 => 'По дождот доаѓа виножитото.';

  @override
  String get dailyAffirmation47 =>
      'Секој предизвик со кој се соочувам е можност да станам посилен.';

  @override
  String get dailyAffirmation48 =>
      'Ги прифаќам прашањата во моето срце и ги дочекувам одговорите во свое време.';

  @override
  String get dailyAffirmation49 =>
      'Единственото одобрение што некогаш ќе ми треба е моето.';

  @override
  String get dailyAffirmation50 =>
      'Убијте ја желбата да бидете избрани. Изберете сами.';

  @override
  String get dailyAffirmation51 =>
      'Во тешкотии, продолжете да се смеете. Тоа ги прави загрижени.';

  @override
  String get dailyAffirmation52 =>
      'Не може да се смени сето она што е соочено, но ништо не може да се смени додека не се соочи.';

  @override
  String get dailyAffirmation53 =>
      'Не треба да бараме херои, треба да бараме добри идеи.';

  @override
  String get dailyAffirmation54 =>
      'Го гледам сонцето, а ако не го видам сонцето, знам дека е таму.';

  @override
  String get dailyAffirmation55 =>
      'Секој кој никогаш не направил грешка, никогаш не пробал ништо ново.';

  @override
  String get dailyAffirmation56 =>
      'Има цел живот во тоа - знаејќи дека сонцето е таму.';

  @override
  String get dailyAffirmation57 =>
      'Само будалите никогаш не го менуваат мислењето.';

  @override
  String get dailyAffirmation58 =>
      'Секогаш изгледа невозможно додека не се заврши.';

  @override
  String get dailyAffirmation59 =>
      'Никогаш не се сомневајте дека мала група внимателни, посветени граѓани може да го промени светот; навистина, тоа е единственото нешто што некогаш го имало.';

  @override
  String get dailyAffirmation60 => 'Само направете го тоа веќе!';

  @override
  String get dailyAffirmation61 => 'Победете го плачењето со длабока насмевка.';

  @override
  String get dailyAffirmation62 =>
      'Подобро да умрам како маж отколку да живеам како кукавица.';

  @override
  String get dailyAffirmation63 =>
      'Дозволете си да бидете автентични, дури и на места каде што се очекува сите да бидат исти.';

  @override
  String get dailyAffirmation64 => 'Најдобри сте, продолжете.';

  @override
  String get dailyAffirmation65 =>
      'Верувај во себе. Можете да направите чуда да се случуваат.';

  @override
  String get dailyAffirmation66 =>
      'Ако можеш да се грижиш за тоа, тоа значи дека си жив и тоа не те убиело и нема да те убие.';

  @override
  String get dailyAffirmation67 => 'Со текот на животот и ова ќе помине.';

  @override
  String get dailyAffirmation68 => 'Продолжете, еден ден ќе вреди.';

  @override
  String get dailyAffirmation69 =>
      'Никогаш не биди она што другиот сака да бидеш, биди секогаш свој.';

  @override
  String get dailyAffirmation70 =>
      'Не заборавајте да се фокусирате на добрите работи.';

  @override
  String get dailyAffirmation71 => 'Тоа не е себично, тоа е грижа за себе.';

  @override
  String get dailyAffirmation72 =>
      'Стравот ве прави слаби; гневот ве прави силни.';

  @override
  String get dailyAffirmation73 =>
      'Кога некој се дави, не прашувате дали знае да плива - само скокате и помагате.';

  @override
  String get dailyAffirmation74 =>
      'Најмалото добро дело е далеку подобро од најголемата добра намера.';

  @override
  String get dailyAffirmation75 => 'Преземете ризик или изгубите шанса.';

  @override
  String get dailyAffirmation76 =>
      'Верувајте дека можете и сте на половина пат.';

  @override
  String get dailyAffirmation77 =>
      'Изберете го оној кој го прави вашиот свет убав.';

  @override
  String get dailyAffirmation78 =>
      'Најмалиот чин на добрина вреди повеќе од најголемата намера.';

  @override
  String get dailyAffirmation79 =>
      'Никогаш не жали за ниту еден ден во животот. Добрите денови ви носат среќа, а лошите денови ви носат искуство.';

  @override
  String get dailyAffirmation80 =>
      'Секој професионалец прво бил аматер. Започнете го вашиот сон сега.';

  @override
  String get dailyAffirmation81 => 'Можеби не е лесно, но ќе вреди.';

  @override
  String get dailyAffirmation82 =>
      'Никогаш не е доцна да бидете она што можеби сте биле.';

  @override
  String get dailyAffirmation83 => 'Сè што можете да замислите е реално.';

  @override
  String get dailyAffirmation84 =>
      'Нема поголема агонија од тоа да носите нераскажана приказна во себе.';

  @override
  String get dailyAffirmation85 =>
      'Следете го она што ви го фаќа срцето, а не она што ви привлекува очи.';

  @override
  String get dailyAffirmation86 =>
      'Осмели се да бидеш најдобар што можеш. Во секое време, Осмели се да бидеш!';

  @override
  String get dailyAffirmation87 =>
      'Никогаш не губи надеж. Бурите ги прават луѓето посилни и никогаш не траат вечно.';

  @override
  String get dailyAffirmation88 =>
      'Плачете. Прости. Научете. Продолжи понатаму. Нека твоите солзи го наводнуваат семето на твојата идна среќа.';

  @override
  String get dailyAffirmation89 =>
      'Кога се плашите да не се изгубите во светлината, само држете се за рака со вашата сенка.';

  @override
  String get dailyAffirmation90 =>
      'Онаму каде што земјата се одвојува за да создаде простор, таму можете да засадите семе.';

  @override
  String get dailyAffirmation91 =>
      'Ако немате што да танцувате, најдете причина да пеете.';

  @override
  String get dailyAffirmation92 =>
      'Понекогаш единствениот начин да се пронајдете е целосно да се изгубите.';

  @override
  String get dailyAffirmation93 => 'Сè е во ваша моќ, а вашата моќ е во вас.';

  @override
  String get dailyAffirmation94 =>
      'Вашата вредност не е она што го имате, туку тоа кој сте.';

  @override
  String get dailyAffirmation95 => 'Во ред е да не си ок.';

  @override
  String get dailyAffirmation96 =>
      'По бура со грмотевици секогаш има виножито.';

  @override
  String get dailyAffirmation97 => 'Утре е нов ден. Блеснете!';

  @override
  String get dailyAffirmation98 => 'Капките дожд се мали бакнежи од океанот.';

  @override
  String get dailyAffirmation99 =>
      'Сè што правите нека биде направено во љубов.';

  @override
  String get dailyAffirmation100 => 'Верба над стравот.';

  @override
  String get dailyAffirmation101 =>
      'Правете повеќе и повеќе со помалку и помалку додека не можете да направите нешто со ништо.';

  @override
  String get dailyAffirmation102 =>
      'Бидете љубовта што сакате да ја видите во светот.';

  @override
  String get dailyAffirmation103 =>
      'Ве чека место на маси кои не сте ги ни виделе.';

  @override
  String get dailyAffirmation104 =>
      'Движете се како да сè ќе успее. Затоа што е.';

  @override
  String get dailyAffirmation105 => 'Секогаш сум заштитен.';

  @override
  String get dailyAffirmation106 =>
      'Никогаш нема да го пропуштите она што е наменето за вас.';

  @override
  String get dailyAffirmation107 => 'Никој не е професионален човек.';

  @override
  String get dailyAffirmation108 =>
      'На врвот на облаците сонцето секогаш сјае.';

  @override
  String get dailyAffirmation109 => 'Запомнете кој се грижи за вас.';

  @override
  String get dailyAffirmation110 => 'Ништо не е важно, уживајте.';

  @override
  String get dailyAffirmation111 =>
      'Да се ​​биде несреќен е причината поради која можете да ги цените подобрите денови.';

  @override
  String get dailyAffirmation112 =>
      'Што ако се сврти подобро отколку што сте замислиле?';

  @override
  String get dailyAffirmation113 => 'Доволни сте.';

  @override
  String get dailyAffirmation114 => 'Јас го правам својот пат.';

  @override
  String get dailyAffirmation115 =>
      'Бидете промената што сакате да ја видите во светот.';

  @override
  String get dailyAffirmation116 =>
      'Не грижете се за ништо, бидејќи секоја ситница ќе биде во ред.';

  @override
  String get dailyAffirmation117 => 'Дајте му важност на она што е важно.';

  @override
  String get dailyAffirmation118 => 'Можете да направите сè, но не морате.';

  @override
  String get dailyAffirmation119 => 'Сонцето во срцето.';

  @override
  String get dailyAffirmation120 => 'Сите се корисни, никој не е незаменлив.';

  @override
  String get pleaseLogInAgain => 'Те молиме повторно пријави се.';

  @override
  String get unableToCaptureDrawing => 'Не е можно да се сними цртежот.';

  @override
  String get unableToExportDrawing => 'Не е можно да се извезе цртежот.';

  @override
  String get drawingSaved => 'Цртежот е зачуван.';

  @override
  String failedToSaveWithCode(Object code) {
    return 'Зачувувањето не успеа: $code';
  }

  @override
  String get failedToSaveDrawing => 'Зачувувањето на цртежот не успеа.';

  @override
  String get toolsLabel => 'Алатки';

  @override
  String get useThisColorLabel => 'Користи ја оваа боја';

  @override
  String get textSizeLabel => 'Големина на текст';

  @override
  String get eraserSizeLabel => 'Големина на гума';

  @override
  String get brushSizeLabel => 'Големина на четка';

  @override
  String get fontLabel => 'Фонт';

  @override
  String get addTextTitle => 'Додај текст';

  @override
  String get writeUpToTwoLinesHint => 'Напиши до 2 реда';

  @override
  String get cancelLabel => 'Откажи';

  @override
  String get addLabel => 'Додај';

  @override
  String get undoLabel => 'Врати';

  @override
  String get clearLabel => 'Исчисти';

  @override
  String get moreToolsLabel => 'Повеќе алатки';

  @override
  String get verificationExpiredDeleted =>
      'Потврдата истече. Сметката е избришана.';

  @override
  String verifyEmailUntil(Object email, Object expiryText) {
    return 'Те молиме потврди ја својата е-пошта $email до $expiryText.';
  }

  @override
  String verifyEmail(Object email) {
    return 'Те молиме потврди ја својата е-пошта $email.';
  }

  @override
  String get googleSignInFailed => 'Најавата со Google не успеа.';

  @override
  String get appleSignInFailed => 'Најавата со Apple не успеа.';

  @override
  String get userFallbackName => 'Корисник';

  @override
  String get resetPasswordTitle => 'Ресетирај лозинка';

  @override
  String get enterValidEmail => 'Внеси валидна е-пошта.';

  @override
  String get sendLinkLabel => 'Испрати линк';

  @override
  String passwordResetSent(Object email) {
    return 'Е-поштата за ресетирање на лозинката е испратена на $email.';
  }

  @override
  String get unableToSendPasswordReset =>
      'Не е можно да се испрати е-пошта за ресетирање на лозинка.';

  @override
  String get signingInLabel => 'Се пријавуваш...';

  @override
  String get forgotPasswordLabel => 'Заборавена лозинка?';

  @override
  String get acceptTermsRequired =>
      'Те молиме прифати ги условите за користење.';

  @override
  String get usernameAlreadyExists => 'Корисничкото име веќе постои.';

  @override
  String get registrationFailed => 'Регистрацијата не успеа.';

  @override
  String verificationEmailSent(Object email) {
    return 'Е-поштата за потврда е испратена на $email.';
  }

  @override
  String registrationFailedWithCode(Object code) {
    return 'Регистрацијата не успеа: $code';
  }

  @override
  String get registrationTimedOut =>
      'Истекна време за регистрација. Провери го емулаторот.';

  @override
  String registrationFailedWithError(Object error) {
    return 'Регистрацијата не успеа: $error';
  }

  @override
  String get atLeast6Characters => 'Најмалку 6 знаци.';

  @override
  String get passwordTooWeak => 'Лозинката е премногу слаба.';

  @override
  String get passwordRuleAtLeast8 => 'Најмалку 8 знаци';

  @override
  String get passwordRuleUppercase => 'Најмалку 1 голема буква';

  @override
  String get passwordRuleNumber => 'Најмалку 1 цифра';

  @override
  String get passwordRuleSpecial => 'Најмалку 1 специјален знак';

  @override
  String get iAcceptPrefix => 'Ги прифаќам';

  @override
  String get termsAndServicesLabel => 'условите за користење';

  @override
  String get oneBalloonPerDayMessage =>
      'Може да пукнеш еден балон на ден. Врати се утре.';

  @override
  String get languageEnglishLabel => 'Англиски';

  @override
  String get messageTitle => 'Порака';

  @override
  String get closeLabel => 'Затвори';

  @override
  String get savedToMySpace => 'Зачувано во Мој простор.';

  @override
  String get alreadyOpenedTodayMessage =>
      'Веќе ја отвори денешната порака. Врати се утре за нов балон.';

  @override
  String get mySpaceIntro =>
      'Календар, дневник и твојата зачувана библиотека на едно место.';

  @override
  String get calendarLabel => 'Календар';

  @override
  String get journalLabel => 'Дневник';

  @override
  String get libraryLabel => 'Библиотека';

  @override
  String get mySpaceCalendarSubtitle => 'Расположение, тело, цитат, белешка';

  @override
  String get mySpaceJournalSubtitle => 'Записи и поттикнувања';

  @override
  String get mySpaceLibrarySubtitle => 'Зачувани ресурси';

  @override
  String get deleteDrawingTitle => 'Да се избрише цртежот?';

  @override
  String get deleteDrawingBody => 'Оваа дејство не може да се поништи.';

  @override
  String get deleteLabel => 'Избриши';

  @override
  String get failedToDeleteDrawing => 'Бришењето на цртежот не успеа.';

  @override
  String get noDrawingsForDay => 'Нема зачувани цртежи за овој ден.';

  @override
  String get noBodyMapForDay => 'Нема зачувана мапа на тело за овој ден.';

  @override
  String get noFrontMapForDay => 'Нема зачувана предна мапа за овој ден.';

  @override
  String get noBackMapForDay => 'Нема зачувана задна мапа за овој ден.';

  @override
  String get showBackLabel => 'Прикажи грб';

  @override
  String get showFrontLabel => 'Прикажи лице';

  @override
  String get previewUnavailable => 'Прегледот не е достапен';

  @override
  String get deleteDrawingTooltip => 'Избриши цртеж';

  @override
  String get dayOverviewTitle => 'Преглед на ден';

  @override
  String selectedDateLabel(Object dateLabel) {
    return 'Избран датум: $dateLabel';
  }

  @override
  String get moodLabel => 'Расположение';

  @override
  String get bodyLabel => 'Тело';

  @override
  String get quoteLabel => 'Цитат';

  @override
  String get noteLabel => 'Белешка';

  @override
  String get noQuoteForDay => 'Нема зачуван цитат за овој ден.';

  @override
  String get dailyMessageLabel => 'Дневна порака';

  @override
  String get noDailyMessageForDay => 'Нема зачувана порака за овој ден.';

  @override
  String get noNoteForDay => 'Нема зачувана белешка за овој ден.';

  @override
  String get doneLabel => 'Готово';

  @override
  String get failedToSaveJournalEntry =>
      'Зачувувањето на записот во дневникот не успеа.';

  @override
  String get mySpaceJournalTitle => 'Мој простор – Дневник';

  @override
  String get noJournalEntriesYet => 'Сè уште нема записи во дневникот.';

  @override
  String get entryCannotBeEmpty => 'Записот не може да биде празен.';

  @override
  String get newEntryTitle => 'Нов запис';

  @override
  String get promptsLabel => 'Поттикнувања';

  @override
  String get startWritingHint => 'Почни да пишуваш...';

  @override
  String get mySpaceLibraryTitle => 'Мој простор – Библиотека';

  @override
  String get savedResourcesTitle => 'Зачувани ресурси';

  @override
  String get guidedBreathingVideo => 'Видео за водено дишење';

  @override
  String get calmingAudio => 'Смирувачко аудио';

  @override
  String get savedMessagesTitle => 'Зачувани пораки';

  @override
  String get loadingLabel => 'Се вчитува...';

  @override
  String get noSavedMessagesYet => 'Сè уште нема зачувани пораки.';

  @override
  String get contactsLabel => 'Контакти';

  @override
  String get therapistLabel => 'Терапевт';

  @override
  String get trustedFriendLabel => 'Доверлив пријател';

  @override
  String get promptComfortToday => 'Што ти донесе утеха денес?';

  @override
  String get promptBodyMorning => 'Како се чувствуваше твоето тело наутро?';

  @override
  String get promptThreeGrateful => 'Наброј три работи за кои си благодарен.';

  @override
  String get promptEmotionColor =>
      'Кога твоите чувства би биле боја, која би била?';

  @override
  String get promptFutureSelf => 'Напиши кратка порака до твоето идно јас.';

  @override
  String get deleteAccountDialogTitle => 'Да се избрише сметката?';

  @override
  String get deleteAccountDialogBody =>
      'Ова трајно ја брише твојата сметка и податоците во апликацијата. Ова дејство не може да се поништи.';

  @override
  String get deleteAccountActionLabel => 'Избриши сметка';

  @override
  String get confirmLabel => 'Потврди';

  @override
  String get deleteAccountRequiresRecentLogin =>
      'Те молиме повторно пријави се, па пак обиди се да ја избришеш сметката.';

  @override
  String get deleteAccountFailed => 'Бришењето на сметката не успеа.';

  @override
  String get deleteAccountSettingsSubtitle =>
      'Трајно избриши ја својата сметка и податоците во апликацијата.';

  @override
  String get careCornerTabLabel => 'Катче за грижа';

  @override
  String get careCornerWellbeingTitle => 'Благосостојба';

  @override
  String get careCornerSupportTitle => 'Поддршка и услуги';

  @override
  String get careCornerEducationTitle => 'Образование';

  @override
  String get careCornerHubSuffixWellbeing => 'Хаб за благосостојба';

  @override
  String get careCornerHubSuffixSupport => 'Хаб за поддршка';

  @override
  String get careCornerHubSuffixEducation => 'Образовен хаб';

  @override
  String get careCornerBackToHubLabel => 'Назад на хаб';

  @override
  String get careCornerBackLabel => 'Назад';

  @override
  String get careCornerFurtherReadingTitle =>
      'Понатамошно читање и продлабочување';

  @override
  String get careCornerFreeBadge => 'БЕСПЛАТНО';

  @override
  String get careCornerResourceNotice =>
      'Деталите за ресурсите и локалните контакти се организирани по земја и тема.';

  @override
  String get careCornerLocalSupportCenterTitle => 'Локален центар за поддршка';

  @override
  String get careCornerContactInfoDescription => 'Контакт информации';

  @override
  String get careCornerActionCall => 'ПОВИКАЈ';

  @override
  String get careCornerActionCallNow => 'ПОВИКАЈ ВЕДНАШ';

  @override
  String get careCornerActionSecureChat => 'БЕЗБЕДЕН ЧАТ';

  @override
  String get careCornerActionVisitWebsite => 'ПОСЕТИ САЈТ';

  @override
  String get careCornerActionEmail => 'Е-ПОШТА';

  @override
  String get careCornerActionScheduleCall => 'ЗАКАЖИ ПОВИК';

  @override
  String get careCornerActionBookAppointment => 'ЗАКАЖИ ТЕРМИН';

  @override
  String get careCornerTopicBreathing => 'Вежби за дишење';

  @override
  String get careCornerTopicMeditation => 'Водена медитација';

  @override
  String get careCornerTopicMusic => 'Музички сесии';

  @override
  String get careCornerTopicJournaling => 'Поттикнувања за дневник';

  @override
  String get careCornerTopicSelfCare => 'Рутини за самогрижа';

  @override
  String get careCornerTopicColorTheory => 'Видеа за теорија на боите';

  @override
  String get careCornerTopicViolenceProtection => 'Насилство и заштита';

  @override
  String get careCornerTopicLegalHelp => 'Правна помош';

  @override
  String get careCornerTopicHealthcare => 'Пристап до здравствена заштита';

  @override
  String get careCornerTopicSupportGroups => 'Групи за поддршка';

  @override
  String get careCornerTopicEmergency => 'Итни служби';

  @override
  String get careCornerTopicLocalNgos => 'Локални НВО';

  @override
  String get careCornerTopicDiscrimination => 'Дискриминација';

  @override
  String get careCornerTopicRacism => 'Расизам';

  @override
  String get careCornerTopicAntigypsyism => 'Антициганизам';

  @override
  String get careCornerTopicHateSpeech => 'Говор на омраза на интернет';

  @override
  String get careCornerTopicXenophobia => 'Ксенофобија';

  @override
  String get careCornerTopicMyRights => 'Моите права';

  @override
  String get careCornerFurtherReadingIdentity => 'Идентитет и припадност';

  @override
  String get careCornerFurtherReadingDiscriminationSupport =>
      'Поддршка кај дискриминација';

  @override
  String get careCornerFurtherReadingSeekHelp => 'Кога да побараш помош';

  @override
  String get careCornerCountryRomania => 'Романија';

  @override
  String get careCornerCountrySerbia => 'Србија';

  @override
  String get careCornerCountryGreece => 'Грција';

  @override
  String get careCornerCountryNorthMacedonia => 'Северна Македонија';

  @override
  String get careCornerCountryGermany => 'Германија';

  @override
  String get careCornerCountryTurkey => 'Турција';

  @override
  String get careCornerCountryEuropeanUnion => 'Европска унија';

  @override
  String get termsTitle => 'Услови за користење';

  @override
  String termsEffectiveDate(Object date) {
    return 'Важи од: $date';
  }

  @override
  String termsIntro(Object appName) {
    return 'Овие услови го регулираат твоето користење на $appName. Со создавање сметка или со користење на апликацијата, се согласуваш со овие услови.';
  }

  @override
  String get termsSection1Title => '1. Подобност и сметки';

  @override
  String get termsSection1Bullet1 =>
      'Мора да дадеш точни податоци при регистрација и да ги чуваш своите податоци за најава безбедно.';

  @override
  String get termsSection1Bullet2 =>
      'Одговорен си за активноста под твојата сметка.';

  @override
  String get termsSection1Bullet3 =>
      'Не смееш да се претставуваш како друго лице или да ја злоупотребуваш платформата.';

  @override
  String get termsSection1Bullet4 =>
      'Корисници под 16 години може да ја користат апликацијата само со согласност на родител или законски старател и само таму каде што е тоа дозволено со закон.';

  @override
  String get termsSection2Title => '2. Што нуди апликацијата';

  @override
  String get termsSection2Bullet1 =>
      'Проверки на расположението преку цртеж, алатки за свест за телото, содржини за водено размислување, пораки и функции за дневник/библиотека.';

  @override
  String get termsSection2Bullet2 =>
      'Апликацијата ја поддржува емоционалната благосостојба и саморефлексијата.';

  @override
  String get termsSection2Bullet3 =>
      'Апликацијата не е кризна служба и не е замена за медицинска, психијатриска или итна помош.';

  @override
  String get termsSection3Title =>
      '3. Здравствено и безбедносно предупредување';

  @override
  String get termsSection3Bullet1 =>
      'Ниедна содржина во апликацијата не претставува медицински совет, дијагноза или лекување.';

  @override
  String get termsSection3Bullet2 =>
      'Ако си во опасност или во итна ситуација, веднаш контактирај ги локалните итни служби.';

  @override
  String get termsSection3Bullet3 =>
      'Ако некоја вежба предизвика непријатност, прекини и побарај стручна поддршка.';

  @override
  String get termsSection4Title => '4. Корисничка содржина';

  @override
  String get termsSection4Bullet1 =>
      'Ја задржуваш сопственоста врз содржината што ја создаваш (на пр. цртежи, мапи на телото, белешки, записи во дневник).';

  @override
  String termsSection4Bullet2(Object companyName) {
    return 'Му даваш на $companyName ограничена лиценца за чување/обработка на твојата содржина исклучиво за работа и подобрување на услугата.';
  }

  @override
  String get termsSection4Bullet3 =>
      'Не смееш да поставуваш незаконски, навредливи или содржини што кршат права.';

  @override
  String get termsSection5Title => '5. Прифатлива употреба';

  @override
  String get termsSection5Bullet1 =>
      'Не се обидувај со неовластен пристап, обратен инженеринг, нарушување или преоптоварување на услугите.';

  @override
  String get termsSection5Bullet2 =>
      'Не ја користи апликацијата за вознемирување, заплашување или искористување на други.';

  @override
  String get termsSection5Bullet3 =>
      'Не заобиколувај ограничувања за сметки, користење или безбедност.';

  @override
  String get termsSection6Title => '6. Податоци и приватност';

  @override
  String get termsSection6Bullet1 =>
      'Обработуваме податоци за сметка/профил и податоци за активност што се потребни за функциите на апликацијата (на пр. дневни проверки, пораки, зачувани записи, репродукција на медиуми).';

  @override
  String get termsSection6Bullet2 =>
      'Податоците се чуваат преку Firebase услугите конфигурирани за апликацијата.';

  @override
  String get termsSection6Bullet3 =>
      'Твоите права за приватност и деталите за чување/бришење се опишани во нашата Политика за приватност.';

  @override
  String termsSection6Bullet4(Object url) {
    return 'Политика за приватност: $url';
  }

  @override
  String get termsSection7Title => '7. Услуги од трети страни';

  @override
  String get termsSection7Bullet1 =>
      'Автентикацијата, складирањето и функциите на базата на податоци се потпираат на трети страни (на пр. Google/Firebase).';

  @override
  String get termsSection7Bullet2 =>
      'Користењето на тие интеграции исто така може да биде предмет на условите на третите страни.';

  @override
  String get termsSection8Title => '8. Интелектуална сопственост';

  @override
  String termsSection8Bullet1(Object companyName) {
    return 'Сите брендови, дизајн и не-кориснички содржини на апликацијата се сопственост на $companyName или се лиценцирани кон неа.';
  }

  @override
  String get termsSection8Bullet2 =>
      'Не смееш да копираш, дистрибуираш или комерцијализираш материјали од апликацијата без дозвола.';

  @override
  String get termsSection9Title => '9. Суспензија и прекин';

  @override
  String get termsSection9Bullet1 =>
      'Може да суспендираме или прекинеме сметки заради прекршувања, злоупотреба, безбедносни ризици или законски обврски.';

  @override
  String get termsSection9Bullet2 =>
      'Може да престанеш да ја користиш апликацијата во секое време.';

  @override
  String get termsSection10Title => '10. Гаранции и одговорност';

  @override
  String get termsSection10Bullet1 =>
      'Услугата се обезбедува „каква што е“ и „како што е достапна“.';

  @override
  String termsSection10Bullet2(Object companyName) {
    return 'Во најголема мера дозволена со закон, $companyName се откажува од имплицитните гаранции.';
  }

  @override
  String termsSection10Bullet3(Object companyName) {
    return 'Во најголема мера дозволена со закон, $companyName не одговара за индиректни, случајни или последователни штети.';
  }

  @override
  String get termsSection11Title => '11. Промени на овие услови';

  @override
  String get termsSection11Bullet1 =>
      'Може повремено да ги ажурираме овие услови.';

  @override
  String get termsSection11Bullet2 =>
      'Ако промените се значајни, ќе те известиме разумно во апликацијата или преку е-пошта.';

  @override
  String get termsSection11Bullet3 =>
      'Продолженото користење после ажурирањата значи дека ги прифаќаш ажурираните услови.';

  @override
  String get termsSection12Title => '12. Меродавно право';

  @override
  String termsSection12Bullet1(Object country) {
    return 'Овие услови се регулирани со законите на $country, без оглед на правилата за судир на закони.';
  }

  @override
  String get termsSection13Title => '13. Контакт';

  @override
  String termsSection13Bullet1(Object email) {
    return 'За поддршка или правни барања, контактирај: $email';
  }

  @override
  String get termsImportantNote =>
      'Важно: те молиме обезбеди преглед од правен советник пред објавување.';

  @override
  String get avatarUpdated => 'Аватарот е ажуриран.';

  @override
  String get avatarUpdateFailed => 'Ажурирањето на аватарот не успеа.';

  @override
  String get avatarRemoved => 'Аватарот е отстранет.';

  @override
  String get avatarRemoveFailed => 'Отстранувањето на аватарот не успеа.';

  @override
  String get nameUpdated => 'Името е ажурирано.';

  @override
  String get nameUpdateFailed => 'Ажурирањето на името не успеа.';

  @override
  String get editNameTitle => 'Уреди име';

  @override
  String get passwordMustBeAtLeast8 =>
      'Лозинката мора да има најмалку 8 знаци.';

  @override
  String get passwordRequirementsSummary =>
      'Користи 1 голема буква, 1 цифра и 1 специјален знак.';

  @override
  String get emailUnchanged => 'Е-поштата е непроменета.';

  @override
  String get verificationEmailSentNewAddress =>
      'Е-поштата за потврда е испратена на новата адреса.';

  @override
  String get reauthenticateToUpdateEmail =>
      'Повторно автентицирај се за да ја ажурираш е-поштата';

  @override
  String get reauthenticationFailed => 'Повторната автентикација не успеа.';

  @override
  String get emailUpdateFailed => 'Ажурирањето на е-поштата не успеа.';

  @override
  String get editEmailTitle => 'Уреди е-пошта';

  @override
  String get passwordUpdated => 'Лозинката е ажурирана.';

  @override
  String get reauthenticateToUpdatePassword =>
      'Повторно автентицирај се за да ја ажурираш лозинката';

  @override
  String get passwordUpdateFailed => 'Ажурирањето на лозинката не успеа.';

  @override
  String get changePasswordTitle => 'Промени лозинка';

  @override
  String get newPasswordLabel => 'Нова лозинка';

  @override
  String get passwordRequirementsSummaryShort =>
      'Мин. 8 знаци, 1 голема буква, 1 цифра, 1 специјален.';

  @override
  String get takePhotoLabel => 'Сними фотографија';

  @override
  String get chooseFromGalleryLabel => 'Избери од галерија';

  @override
  String get chooseAvatarLabel => 'Избери аватар';

  @override
  String get avatarPickerTitle => 'Избери го својот аватар';

  @override
  String get removePhotoLabel => 'Отстрани фотографија';

  @override
  String get notificationsOffSummary => 'Известувањата се исклучени.';

  @override
  String notificationsDailyAndInactiveSummary(Object hour, Object minute) {
    return 'Секојдневно во $hour:$minute и потсетници по 7 дена неактивност.';
  }

  @override
  String notificationsDailyOnlySummary(Object hour, Object minute) {
    return 'Дневен потсетник во $hour:$minute.';
  }

  @override
  String get notificationsInactiveOnlySummary =>
      'Само потсетници по 7 дена неактивност.';

  @override
  String get dailyReminderTitle => 'Дневен потсетник';

  @override
  String get dailyReminderSubtitle => 'Испрати дневен утрински потсетник.';

  @override
  String get reminderTimeTitle => 'Време на потсетник';

  @override
  String get inactiveReminderTitle => 'Потсетник за неактивност';

  @override
  String get inactiveReminderSubtitle =>
      'Испрати потсетник по 7 дена отсуство.';

  @override
  String get notificationPreferencesSaved =>
      'Подесувањата за известувања се зачувани.';

  @override
  String get notificationPreferencesSaveFailed =>
      'Зачувувањето на подесувањата за известувања не успеа.';

  @override
  String get accountSectionTitle => 'Сметка';

  @override
  String get profilePhotoTitle => 'Профилна фотографија';

  @override
  String get profilePhotoSubtitle => 'Додај или отстрани го својот аватар.';

  @override
  String get displayNameTitle => 'Прикажано име';

  @override
  String get unknownValueLabel => 'Непознато';

  @override
  String get passwordUpdateSubtitle => 'Ажурирај ја својата лозинка.';

  @override
  String get passwordManagedByProviderSubtitle =>
      'Управувано од твојот провајдер за најава.';

  @override
  String get appSectionTitle => 'Апликација';

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeSystemLabel => 'Систем';

  @override
  String get themeLightLabel => 'Светла';

  @override
  String get themeDarkLabel => 'Темна';

  @override
  String get cookieMonsterTitle => 'Колаче Чудовиште';

  @override
  String get cookieMonsterJoinPrompt => 'Ќе ми се придружиш ли?';

  @override
  String get joinLabel => 'Придружи се';

  @override
  String get cookieMonsterOutsidePrompt =>
      'Кога ќе замислиш место каде што се чувствуваш опуштено, кои физички сензации ги забележуваш во своето тело?';

  @override
  String get reflectLabel => 'Размисли';

  @override
  String get experienceFeedbackTitle => 'Како беше ова искуство за тебе?';

  @override
  String get experienceFeedbackPositive => 'Позитивно: танц';

  @override
  String get experienceFeedbackNeutral => 'Неутрално: меееххххх';

  @override
  String get experienceFeedbackNegative => 'Негативно: пад';

  @override
  String get selectBodyAreaFirst => 'Прво избери дел од телото.';

  @override
  String noClipFound(Object activityKey) {
    return 'Не е најден клип за „$activityKey“.';
  }

  @override
  String failedToLoadMonsterClip(Object error) {
    return 'Вчитувањето на клипот не успеа: $error';
  }

  @override
  String get colorLabel => 'Боја';

  @override
  String get tapBodyToLogSensation =>
      'Допри го телото за да забележиш сензација.';

  @override
  String failedToSaveBodyAwarenessWithCode(Object code) {
    return 'Зачувувањето на свеста за телото не успеа: $code.';
  }

  @override
  String get failedToSaveBodyAwareness =>
      'Зачувувањето на свеста за телото не успеа.';

  @override
  String get stepSkipped => 'Чекорот е прескокнат.';

  @override
  String get bodyAwarenessPrompt =>
      'Каде се чини дека ова чувство почива во твоето тело?\nДопри го тоа место и избери боја што ти се чини блиска на сензацијата.';

  @override
  String get exerciseInstructionWillYouJoin =>
      'Сакаш ли да му се придружиш на Колаче Чудовиште за кратка вежба?';

  @override
  String get exerciseInstructionOutsideTheBody =>
      'Кога ќе замислиш место каде што се чувствуваш опуштено, кои физички сензации ги забележуваш во своето тело?';

  @override
  String get exerciseInstructionForeheadContact =>
      'Контакт со чело:\nСтави го дланот на челото, држи неколку секунди и опушти се со здивот.';

  @override
  String get exerciseInstructionSlowBreathing =>
      'Затвори очи – следење на здивот:\nЗатвори очи, вдиши лагано низ нос и издиши за 4 секунди (повтори 5 пати).';

  @override
  String get exerciseInstructionWeightOfHead =>
      'Почувствувај ја тежината на главата:\nНежно наведни ја главата напред, забележи тензија во вратот и опушти ја.';

  @override
  String get exerciseInstructionBreathing478 =>
      '4-7-8 дишење:\nВдиши 4 секунди, задржи 7, издиши 8 (3 циклуси).';

  @override
  String get exerciseInstructionAbdominalAwareness =>
      'Свест за стомакот:\nСтави ја раката на стомакот и почувствувај како се крева и спушта со секој здив.';

  @override
  String get exerciseInstructionHeartCenter =>
      'Отворање на срцевиот центар:\nПомести ги градите напред, повлечи ги рамењата назад и длабоко вдиши.';

  @override
  String get exerciseInstructionBallSqueezing =>
      'Стискање топка:\nПолека стисни и опушти го дланот (10 повторувања).';

  @override
  String get exerciseInstructionFingerMeditation =>
      'Медитација со прсти:\nДопри секој прст со палецот еден по еден, издишувајќи со секој допир.';

  @override
  String get exerciseInstructionHandMassage =>
      'Масажа на дланка:\nМасирај го средниот дел од дланот со палецот во мали кругови (по 30 секунди по рака).';

  @override
  String get exerciseInstructionShoulderDrop =>
      'Спуштање на рамења:\nПодигни ги рамењата кон ушите, потоа отпушти ги (5 повторувања).';

  @override
  String get exerciseInstructionBackOpening =>
      'Отворање на грб:\nСврти ги рацете зад грбот, отвори ги градите и длабоко вдиши.';

  @override
  String get exerciseInstructionReleasingBurdens =>
      'Ослободување од товари:\nСо затворени очи, замисли топла светлина што се спушта низ твоите рамења.';

  @override
  String get exerciseInstructionRelaxingFacialMuscles =>
      'Опуштање на мускули на лицето:\nЗатвори очи, затегни ги мускулите на лицето, потоа опушти ги (3 повторувања).';

  @override
  String get exerciseInstructionJawDrop =>
      'Опуштање на вилицата:\nЛесно отвори ја устата, опушти ја вилицата 5 секунди и затвори ја.';

  @override
  String get exerciseInstructionSmileToYourself =>
      'Насмевни се на себе:\nЗадржи нежна насмевка 30 секунди.';

  @override
  String get exerciseInstructionEftTappingPoints =>
      'EFT точки за тапкање:\nТапкај секоја точка 5–7 пати: почеток на веѓа, страна на око, под око, под нос, брада, клучна коска, под рака, теме.';

  @override
  String get exerciseInstructionRisingOnTiptoes =>
      'Кревање на прсти:\nПодигни ги петите додека издишуваш, задржи 3–5 секунди, спушти полека и повтори 5–10 пати.';

  @override
  String get singleClipUrlMissing => 'Недостасува URL на единечен клип.';

  @override
  String get exerciseClipsMissing => 'Недостасуваат клипови за вежба.';

  @override
  String get videoPlayerInitializationFailed =>
      'Видео плеерот не успеа да се иницијализира. Те молиме целосно рестартирај ја апликацијата.';

  @override
  String get failedToPlayOutroClip =>
      'Репродукцијата на завршниот клип не успеа.';

  @override
  String get finishExerciseLabel => 'Заврши вежба';

  @override
  String get startExerciseLabel => 'Започни вежба';

  @override
  String get feedbackQuestionLabel => 'Како ти се допадна вежбата?';

  @override
  String get feedbackVeryGood => 'Многу добро';

  @override
  String get feedbackGood => 'Добро';

  @override
  String get feedbackMeh => 'Така-така';

  @override
  String get feedbackNotGood => 'Не е добро';

  @override
  String get feedbackAwful => 'Ужасно';

  @override
  String get feedbackDoneLabel => 'Готово';

  @override
  String get careCornerEuNationalPrompt =>
      'For country-specific support and services, please also visit your national bubble.';

  @override
  String get euDisclaimer =>
      'Финансирано од Европската унија. Искажаните гледишта и мислења се исклучиво на авторот/авторите и не мора нужно да ги одразуваат гледиштата и мислењата на Европската унија или на Европската извршна агенција за образование и култура (EACEA). Ниту Европската унија, ниту EACEA можат да бидат одговорни за нив.';

  @override
  String get externalLinkWarningTitle => 'Ја напушташ апликацијата';

  @override
  String get externalLinkWarningMessage =>
      'Ќе отвориш надворешна веб-страница. Не сме одговорни за содржината на надворешните страници.';

  @override
  String get externalLinkCancel => 'Откажи';

  @override
  String get externalLinkContinue => 'Продолжи';

  @override
  String get careCornerNotAvailableMessage => 'Сè уште не е достапно';

  @override
  String get messageAlreadyOpenedToday =>
      'Веќе ја отворивте денешната порака. Вратете се утре!';

  @override
  String get libraryResourcesTitle => 'Ресурси';

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
