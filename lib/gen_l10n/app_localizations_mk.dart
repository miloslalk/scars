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
  String get dailyAffirmation1 => 'Вистинското чудо е да веруваш во себе.';

  @override
  String get dailyAffirmation2 => 'Различноста го прави светот убав.';

  @override
  String get dailyAffirmation3 => 'По дождот доаѓа виножито.';

  @override
  String get dailyAffirmation4 =>
      'Дозволи си да бидеш тоа што си, дури и таму каде што се очекува сите да бидат исти.';

  @override
  String get dailyAffirmation5 =>
      'Твојата вредност не е во тоа што го имаш, туку во тоа што си.';

  @override
  String get dailyAffirmation6 => 'Океј е да не си океј.';

  @override
  String get dailyAffirmation7 =>
      'Тебе те чека место и на маси што уште не ги имаш ни видено.';

  @override
  String get dailyAffirmation8 => 'Можеш сè — ама не мораш.';

  @override
  String get dailyAffirmation9 =>
      'Ако разделбата боли, значи убаво го имаш поминато времето.';

  @override
  String get dailyAffirmation10 => 'Сети се кој навистина мисли на тебе.';

  @override
  String get dailyAffirmation11 =>
      'А што ако испадне подобро отколку што замислуваш?';

  @override
  String get dailyAffirmation12 => 'Тоа што си, доволно е.';

  @override
  String get dailyAffirmation13 => 'Својот пат си го правам јас.';

  @override
  String get dailyAffirmation14 => 'Денес е нов ден. Блесни!';

  @override
  String get dailyAffirmation15 =>
      'Не губи надеж. Бурите ги прават луѓето посилни — и никогаш не траат вечно.';

  @override
  String get dailyAffirmation16 =>
      'Исплачи се. Прости. Научи. Продолжи. Нека солзите го полеат семето на твојата идна среќа.';

  @override
  String get dailyAffirmation17 => 'Можеби нема да биде лесно, ама ќе вреди.';

  @override
  String get dailyAffirmation18 =>
      'Не заборавај да се фокусираш на убавите работи.';

  @override
  String get dailyAffirmation19 => 'Не е себичност — тоа е грижа за себе.';

  @override
  String get dailyAffirmation20 => 'Супер си, само продолжи.';

  @override
  String get dailyAffirmation21 => 'Верувај во себе. Можеш да правиш чуда.';

  @override
  String get dailyAffirmation22 => 'Како што тече животот, ќе помине и ова.';

  @override
  String get dailyAffirmation23 =>
      'Секој предизвик пред мене е можност да зајакнам.';

  @override
  String get dailyAffirmation24 =>
      'Ги прифаќам прашањата во моето срце, а одговорите ги пречекувам кога ќе дојде нивното време.';

  @override
  String get dailyAffirmation25 => 'Не мораш да бидеш совршенство.';

  @override
  String get dailyAffirmation26 =>
      'Совршенството е утопија. Служи само како компас.';

  @override
  String get dailyAffirmation27 =>
      'Стојам исправено и се борам за своите соништа.';

  @override
  String get dailyAffirmation28 =>
      'Не дозволувај другите да ти ја одлучуваат иднината.';

  @override
  String get dailyAffirmation29 =>
      'Стојам цврсто на земја, издржувам, а срцето ми е отворено за раст — дури и во несигурни времиња.';

  @override
  String get dailyAffirmation30 =>
      'Ако животот ти дава мигови, претвори ги во убави спомени.';

  @override
  String get dailyAffirmation31 => 'Старите патишта не отвораат нови врати.';

  @override
  String get dailyAffirmation32 => 'Грешките се доказ дека се обидуваш.';

  @override
  String get dailyAffirmation33 =>
      'Само направи чекор и обиди се — тоа е доволно.';

  @override
  String get dailyAffirmation34 =>
      'Само погледни што сè можеме кога ќе се здружиме.';

  @override
  String get dailyAffirmation35 =>
      'Кога не знаеш каде одиш, сите патишта те водат таму.';

  @override
  String get dailyAffirmation36 => 'Животот е еден ден — и тој ден е денес.';

  @override
  String get dailyAffirmation37 => 'Сите сме создадени од ѕвезден прав.';

  @override
  String get dailyAffirmation38 => 'Сонувај страсно, живеј одговорно.';

  @override
  String get dailyAffirmation39 =>
      'Сè ќе биде во ред. Ајде, кажи го тоа уште еднаш.';

  @override
  String get dailyAffirmation40 =>
      'Чудно? Супер. Поинакво? Уште подобро. Биди си ти.';

  @override
  String get dailyAffirmation41 => 'Силните умови растат на безбедни места.';

  @override
  String get dailyAffirmation42 =>
      'Секој почеток е само продолжение, а книгата на настаните е секогаш отворена на половина.';

  @override
  String get dailyAffirmation43 =>
      'Сè има почеток и крај — а крајот може да биде убав, колку и да изгледа мрачно сега.';

  @override
  String get dailyAffirmation44 =>
      'Единственото одобрување што некогаш ќе ми треба е моето.';

  @override
  String get dailyAffirmation45 =>
      'Не треба да бараме херои — треба да бараме добри идеи.';

  @override
  String get dailyAffirmation46 =>
      'И најмалото добро дело вреди повеќе од најголемата добра намера.';

  @override
  String get dailyAffirmation47 =>
      'Твоето потекло не е причина да се смалуваш. Тоа е тло на кое стоиш.';

  @override
  String get dailyAffirmation48 =>
      'Твоето име, твојот јазик, приказната на твоето семејство — сето тоа е твое, носи го со гордост.';

  @override
  String get dailyAffirmation49 =>
      'Не ти треба ничија дозвола за да заземеш место во овој свет.';

  @override
  String get dailyAffirmation50 =>
      'Не си „премногу“ од ништо. Тебе те има точно колку што треба.';

  @override
  String get dailyAffirmation51 =>
      'Твоите корени не те задржуваат — токму тие ти даваат да растеш високо.';

  @override
  String get dailyAffirmation52 =>
      'Нема само еден начин да припаѓаш некаде. Ти го пишуваш својот.';

  @override
  String get dailyAffirmation53 =>
      'Твојата приказна е важна — дури и деловите за кои никој уште не прашал.';

  @override
  String get dailyAffirmation54 =>
      'Во себе носиш повеќе од еден дом — и тоа не е товар, туку богатство.';

  @override
  String get dailyAffirmation55 =>
      'За да се гордееш со тоа што си, не ти треба прво ничие одобрување.';

  @override
  String get dailyAffirmation56 =>
      'Не мораш да го заслужуваш своето место тука. Веќе го имаш.';

  @override
  String get dailyAffirmation57 =>
      'Некаде има отворена врата за тебе, дури и во деновите кога не ти се чини така.';

  @override
  String get dailyAffirmation58 =>
      'Смееш да изградиш дом на повеќе од едно место.';

  @override
  String get dailyAffirmation59 =>
      'Луѓето што вредат ќе ти направат место — нема да бараат да се смалиш.';

  @override
  String get dailyAffirmation60 => 'Не си на гости во сопствениот живот.';

  @override
  String get dailyAffirmation61 =>
      'Каде и да стоиш денес — имаш полно право да стоиш токму таму.';

  @override
  String get dailyAffirmation62 =>
      'Заедницата не е нешто што се чека. Понекогаш таа почнува токму од тебе.';

  @override
  String get dailyAffirmation63 =>
      'Не мораш да избираш меѓу тоа од каде си и тоа каде си сега.';

  @override
  String get dailyAffirmation64 =>
      'Утрешниот ден не мора да личи на денешниот.';

  @override
  String get dailyAffirmation65 =>
      'Некаде понатаму постои верзија од твојот живот што уште не ја имаш ни замислено — и убава е.';

  @override
  String get dailyAffirmation66 =>
      'Тешките поглавја завршуваат. Ќе заврши и твоето.';

  @override
  String get dailyAffirmation67 =>
      'Имаш право да сакаш повеќе за себе — и да отидеш по тоа.';

  @override
  String get dailyAffirmation68 =>
      'Иднината не е запишана во камен. Ти сè уште имаш збор.';

  @override
  String get dailyAffirmation69 => 'И малите чекори се движење напред.';

  @override
  String get dailyAffirmation70 =>
      'Не доцниш во животот. Точно си таму каде што те донесе твојот пат.';

  @override
  String get dailyAffirmation71 =>
      'Она што ти следува уште не се случило. Остави му простор да те изненади.';

  @override
  String get dailyAffirmation72 =>
      'Од тука натаму, ти одлучуваш како изгледа твојата приказна.';

  @override
  String get dailyAffirmation73 =>
      'Досега имаш поминато низ секој тежок ден. Тоа не е среќа — тоа си ти.';

  @override
  String get dailyAffirmation74 =>
      'Умората не значи дека потфрлаш. Значи дека носиш многу.';

  @override
  String get dailyAffirmation75 =>
      'Не мораш да си од челик. Доволно е да одиш напред со своето темпо.';

  @override
  String get dailyAffirmation76 =>
      'Силата не значи никогаш да не ти биде тешко. Значи да продолжиш и покрај тоа.';

  @override
  String get dailyAffirmation77 =>
      'Смееш да се гордееш што имаш поминато низ тоа, дури и ако не изгледаше убаво.';

  @override
  String get dailyAffirmation78 =>
      'Најтешките делови од твојата приказна го немаат последниот збор.';

  @override
  String get dailyAffirmation79 =>
      'Имаш преживеано работи што луѓето не ги гледаат. И тоа вреди нешто.';

  @override
  String get dailyAffirmation80 =>
      'Во ред е ако заздравувањето трае подолго отколку што очекуваше.';

  @override
  String get dailyAffirmation81 =>
      'Не мора да ти е сè јасно за да продолжиш напред.';

  @override
  String get dailyAffirmation82 =>
      'Секој ден кога повторно се појавуваш е тивок вид храброст.';

  @override
  String get dailyAffirmation83 =>
      'Имаш законско право на сосема просечен ден. Дозвола не ти треба.';

  @override
  String get dailyAffirmation84 =>
      'Понекогаш животот е само одлучување што ќе јадеш, три пати на ден, засекогаш. Можеш ти тоа.';

  @override
  String get dailyAffirmation85 =>
      'Не мора секој ден да биде ремек-дело. Некои денови само треба да се случат.';

  @override
  String get dailyAffirmation86 =>
      'Ти оди подобро отколку што кажуваат нотификациите од групниот чет.';

  @override
  String get dailyAffirmation87 =>
      'Самодовербата е само да се правиш дека знаеш каде одиш — сè додека навистина не дознаеш.';

  @override
  String get dailyAffirmation88 =>
      'Имаш преживеано 100% од своите најлоши денови. Солидна статистика.';

  @override
  String get dailyAffirmation89 =>
      'Никој нема сè средено. Оние што изгледаат така само поладнокрвно ги оставаат пораките на „видено“.';

  @override
  String get dailyAffirmation90 =>
      'Денес не ти треба петгодишен план. Доволен е пристоен појадок.';

  @override
  String get dailyAffirmation91 =>
      'Личниот раст најчесто изгледа вака: се сопнуваш нанапред и го викаш тоа напредок.';

  @override
  String get dailyAffirmation92 =>
      'Некои денови победа е и самото станување од кревет. И тоа се брои.';

  @override
  String get dailyAffirmation93 =>
      'Не мораш да носиш сè без помош — пушти ги луѓето да ти помогнат.';

  @override
  String get dailyAffirmation94 =>
      'Некој таму ти го чува грбот, дури и во деновите кога тоа тешко се чувствува.';

  @override
  String get dailyAffirmation95 =>
      'Да побараш помош не е слабост. Токму така се градат вистински пријателства.';

  @override
  String get dailyAffirmation96 =>
      'На луѓето околу тебе им требаш исто онолку колку што тие ти требаат тебе.';

  @override
  String get dailyAffirmation97 =>
      'Дел си од нешто поголемо, дури и во деновите кога се чувствуваш како воздух.';

  @override
  String get dailyAffirmation98 =>
      'Смееш да се одмориш и пред да паднеш од умор.';

  @override
  String get dailyAffirmation99 =>
      'Денешната тага не ја откажува утрешната насмевка.';

  @override
  String get dailyAffirmation100 => 'Никому не му должиш постојана позитива.';

  @override
  String get dailyAffirmation101 =>
      'Сосема е во ред да немаш одговор во моментов.';

  @override
  String get dailyAffirmation102 =>
      'Да се грижиш за себе денес не е себично — неопходно е.';

  @override
  String get dailyAffirmation103 =>
      'Туѓите предрасуди не се доказ за тоа кој си ти.';

  @override
  String get dailyAffirmation104 =>
      'Ти не си приказната што другите ја раскажуваат за тебе.';

  @override
  String get dailyAffirmation105 =>
      'Ако мислиш дека заслужуваш помалку — тоа никогаш не е точно. Заслужуваш целосна почит.';

  @override
  String get dailyAffirmation106 =>
      'Твојата вредност никогаш не е тема за расправа, кој и да те тера да мислиш поинаку.';

  @override
  String get dailyAffirmation107 =>
      'Невидливоста е чувство, а не факт. Некој тука гледа точно кој си.';

  @override
  String get dailyAffirmation108 =>
      'Тоа што некои те превидуваат не значи дека никој не те гледа.';

  @override
  String get dailyAffirmation109 =>
      'Вредиш, дури и во простории каде што никој не го кажува тоа наглас.';

  @override
  String get dailyAffirmation110 =>
      'Некој те забележа. Те гледаат повеќе отколку што ти се чини.';

  @override
  String get dailyAffirmation111 =>
      'Не мораш да се смалиш за да те забележат од вистинските причини.';

  @override
  String get dailyAffirmation112 =>
      'Да те видат другите почнува со тоа како се гледаш ти — и смееш да почнеш токму таму.';

  @override
  String get dailyAffirmation113 =>
      'Не си ни „премногу“ ни „недоволно“. Едноставно — те гледаат.';

  @override
  String get dailyAffirmation114 =>
      'Има луѓе што ценат токму тоа што те прави да бидеш ти.';

  @override
  String get dailyAffirmation115 =>
      'Твоето присуство ја менува просторијата, дури и кога ти се чини дека не е така.';

  @override
  String get dailyAffirmation116 =>
      'Те знаат повеќе луѓе, и на повеќе начини, отколку што ти се чини.';

  @override
  String get dailyAffirmation117 =>
      'Не контролираш сè што ти се случува. Но контролираш како ќе го пречекаш.';

  @override
  String get dailyAffirmation118 => 'Ти одлучуваш што доаѓа следно за тебе.';

  @override
  String get dailyAffirmation119 =>
      'Малите избори сè уште се твои, дури и во тешки околности.';

  @override
  String get dailyAffirmation120 =>
      'Не си патник во сопствениот живот. Ти возиш.';

  @override
  String get dailyAffirmation121 =>
      'Да побараш тоа што ти треба е моќ, а не слабост.';

  @override
  String get dailyAffirmation122 =>
      'Имаш збор и во ова, дури и кога не ти се чини така.';

  @override
  String get dailyAffirmation123 =>
      'Никој друг освен тебе не го пишува твоето следно поглавје.';

  @override
  String get dailyAffirmation124 =>
      'Дури и во системи што не се градени за тебе, твоите избори сепак вредат.';

  @override
  String get dailyAffirmation125 =>
      'Смееш да сакаш работите да бидат поинакви — и да работиш на тоа.';

  @override
  String get dailyAffirmation126 =>
      'Што ќе направиш со денешниот ден — тоа е сè уште твоја одлука.';

  @override
  String get dailyAffirmation127 =>
      'Не мораш да го менуваш тоа што си за да имаш место тука.';

  @override
  String get dailyAffirmation128 =>
      'Има луѓе што ќе направат место токму за тоа што си.';

  @override
  String get dailyAffirmation129 =>
      'Припаѓаш на повеќе од едно место — и тоа не е противречност.';

  @override
  String get dailyAffirmation130 =>
      'Вистинската блискост не бара да криеш ниту еден дел од себе.';

  @override
  String get dailyAffirmation131 =>
      'Некаде таму, некому му е мило што постоиш.';

  @override
  String get dailyAffirmation132 => 'Не мораш да се објаснуваш за да припаѓаш.';

  @override
  String get dailyAffirmation133 =>
      'Заедницата не е нешто за што треба да се квалификуваш. Веќе си во неа.';

  @override
  String get dailyAffirmation134 =>
      'Тоа што си далеку од таму каде што сè почна не значи дека си без дом.';

  @override
  String get dailyAffirmation135 =>
      'Не мораш да носиш сè на свој грб, дури и кога ти се чини дека немаш никого.';

  @override
  String get dailyAffirmation136 =>
      'Има луѓе што градат живот покрај тебе, а не само гледаат однадвор.';

  @override
  String get dailyAffirmation137 =>
      'Твоите корени носат сила од генерации — таа сила е и твоја.';

  @override
  String get dailyAffirmation138 =>
      'Твојот јазик, твоите обичаи, приказната на твоето семејство — вредат да се чуваат живи.';

  @override
  String get dailyAffirmation139 =>
      'Тоа што ја прави твојата заедница поинаква е токму тоа што ја прави вредна да ѝ припаѓаш.';

  @override
  String get dailyAffirmation140 =>
      'Никому не му должиш извинување за тоа од каде доаѓаш.';

  @override
  String get dailyAffirmation141 =>
      'Твоето наследство не е задача за средување. Тоа е причина за гордост.';

  @override
  String get dailyAffirmation142 =>
      'Твојата култура не е проблем за решавање. Таа е дел од твојата сила.';

  @override
  String get dailyAffirmation143 =>
      'Да се гордееш со тоа што си не значи да го гледаш светот со розови очила.';

  @override
  String get dailyAffirmation144 =>
      'Твојот идентитет не е товар што го носиш. Тој е темел на кој стоиш.';

  @override
  String get dailyAffirmation145 =>
      'Она што ти е предадено, заслужува да го предадеш понатаму.';

  @override
  String get dailyAffirmation146 =>
      'Во ред е ако денес ти е празно. Не мораш да глумиш дека си добро.';

  @override
  String get dailyAffirmation147 =>
      'Во ред е да ти е преку глава од тоа постојано да се објаснуваш.';

  @override
  String get dailyAffirmation148 =>
      'Тагата не значи слабост. Значи дека забележуваш нешто вистинско.';

  @override
  String get dailyAffirmation149 =>
      'Не мораш да имаш надеж баш секој ден. Некои денови е доволно само да ги поминеш.';

  @override
  String get dailyAffirmation150 =>
      'Во ред е да се лутиш на работи што никогаш не биле фер.';

  @override
  String get dailyAffirmation151 =>
      'Да плачеш за нешто вистинско не значи дека се распаѓаш.';

  @override
  String get dailyAffirmation152 =>
      'Не мораш да докажуваш зошто нешто боли. Боли. Тоа е доволна причина.';

  @override
  String get dailyAffirmation153 =>
      'Некои денови летвата е „успеав да се облечам“. Почитувај ја летвата.';

  @override
  String get dailyAffirmation154 =>
      'Имаш преживеано 100% од понеделниците. Без ниту еден пораз.';

  @override
  String get dailyAffirmation155 =>
      'Ничиј живот не е навистина како на фотографиите. Ни твојот не мора да биде.';

  @override
  String get dailyAffirmation156 =>
      'Возрасниот живот е 10% мудрост, 90% преправање дека знаеш како работи принтерот.';

  @override
  String get dailyAffirmation157 =>
      'Едни грицки те делат од малку подобра верзија на себе. Ајде, земи си.';

  @override
  String get dailyAffirmation158 =>
      'Самодоверба е да влезеш некаде како да имаш тапија на местото.';

  @override
  String get dailyAffirmation159 =>
      'Понекогаш е сосема во ред да ги преспиеш чувствата. Трпеливи се, ќе те почекаат.';

  @override
  String get dailyAffirmation160 =>
      'Не мораш да го сакаш утрото. Доволно е да го преживееш.';

  @override
  String get dailyAffirmation161 =>
      'Прекумерното размислување сигурно троши и калории. Десертот е заслужен.';

  @override
  String get dailyAffirmation162 =>
      'За некои одлуки најдобро е да фрлиш паричка, па да ти олесни како и да се заврти.';

  @override
  String get dailyAffirmation163 =>
      'Статистички гледано, ти оди одлично — споредено со ракун во контејнер.';

  @override
  String get dailyAffirmation164 =>
      'Длабокото дишење се смета за цела велнес-рутина. Практично цветаш.';

  @override
  String get dailyAffirmation165 =>
      'Да беше денешниот ден групен проект, ќе имаше направено повеќе од пола екипа.';

  @override
  String get dailyAffirmation166 =>
      'Никому не му преживуваат цвеќињата од прва. Подобро ти оди отколку што мислиш.';

  @override
  String get dailyAffirmation167 =>
      'Технички, досега имаш преживеано секој „најлош ден во животот“.';

  @override
  String get dailyAffirmation168 =>
      'Умората е само начинот на кој телото ти аплаудира затоа што постоеше цел ден.';

  @override
  String get dailyAffirmation169 =>
      'Не му треба на секој ден пресврт во дејството. На некои денови им требаат само грицки и дремка.';

  @override
  String get dailyAffirmation170 =>
      'Смееш да бидеш „во изградба“ и сепак да бидеш цел човек уште денес.';

  @override
  String get dailyAffirmation171 =>
      'Одложувањето на страшните работи е само твојот мозок што ти е добар другар.';

  @override
  String get dailyAffirmation172 =>
      'Животот не доаѓа со упатство, па искрено — импровизираш прекрасно.';

  @override
  String get dailyAffirmation173 =>
      'Денес ти си главниот лик, дури и ако целото дејство е само перење алишта.';

  @override
  String get dailyAffirmation174 =>
      'Во ред е да не ти е сè средено во животот. Никому не му е — само некои имаат подобро осветлување.';

  @override
  String get dailyAffirmation175 =>
      'Денешниот ден го имаш поминато без упатство за употреба. Тоа е практично суперсила.';

  @override
  String get dailyAffirmation176 =>
      'Малите победи се бројат — дури и „конечно одговорив на онаа порака“.';

  @override
  String get dailyAffirmation177 =>
      'Не мораш да го победиш денот. Да го преживееш со грицки е сосема легитимна стратегија.';

  @override
  String get dailyAffirmation178 =>
      'Некои денови си лав. Некои денови си лав што сака само ќебе. И двете се во ред.';

  @override
  String get dailyAffirmation179 =>
      'Смееш да се смееш на хаосот. Обично тоа е најздравата реакција.';

  @override
  String get dailyAffirmation180 =>
      'Твоето идно јас ќе ти биде благодарно за дремката што ти претстои.';

  @override
  String get dailyAffirmation181 =>
      'Заслужуваш љубов што не бара прво да се промениш.';

  @override
  String get dailyAffirmation182 =>
      'Заслужуваш одмор, дури и во деновите кога не е „заработен“.';

  @override
  String get dailyAffirmation183 =>
      'Заслужуваш свој простор во светот, точно со тоа што си.';

  @override
  String get dailyAffirmation184 =>
      'Заслужуваш да те избираат, а не само да те трпат.';

  @override
  String get dailyAffirmation185 =>
      'Заслужуваш добрина — вклучително и од себеси.';

  @override
  String get dailyAffirmation186 =>
      'Заслужуваш убави работи — дури и оние што не ги имаш ни побарано.';

  @override
  String get dailyAffirmation187 =>
      'Заслужуваш луѓе што се тука кога навистина треба.';

  @override
  String get dailyAffirmation188 =>
      'Заслужуваш живот што го чувствуваш како свој.';

  @override
  String get dailyAffirmation189 => 'Заслужуваш да ти веруваат кога зборуваш.';

  @override
  String get dailyAffirmation190 => 'Заслужуваш благост, дури и во суров свет.';

  @override
  String get dailyAffirmation191 =>
      'Заслужуваш радост што не мора да се објаснува.';

  @override
  String get dailyAffirmation192 => 'Заслужуваш безбедност, каде и да си.';

  @override
  String get dailyAffirmation193 =>
      'Заслужуваш да те сакаат — без прво да го „заработуваш“ тоа.';

  @override
  String get dailyAffirmation194 =>
      'Заслужуваш стол на масата, а не само ќоше во собата.';

  @override
  String get dailyAffirmation195 =>
      'Заслужуваш соништа што се твои, а не позајмени од друг.';

  @override
  String get dailyAffirmation196 => 'Заслужуваш трпение, особено своето.';

  @override
  String get dailyAffirmation197 =>
      'Заслужуваш да те разбираат, а не само да те поднесуваат.';

  @override
  String get dailyAffirmation198 =>
      'Заслужуваш да ти се случуваат убави работи, а не само да преживуваш.';

  @override
  String get dailyAffirmation199 =>
      'Заслужуваш да те слават, а не само да те прифаќаат.';

  @override
  String get dailyAffirmation200 =>
      'Заслужуваш, точно со она што си денес — заедно со сето недовршено.';

  @override
  String get dailyAffirmation201 =>
      'Заслужуваш иднина што не ги повторува твоите најтешки денови.';

  @override
  String get dailyAffirmation202 =>
      'Заслужуваш да се гордееш со себе — без никакви услови.';

  @override
  String get dailyAffirmation203 =>
      'Заслужуваш луѓе покрај кои не мораш да се смалуваш.';

  @override
  String get dailyAffirmation204 =>
      'Заслужуваш сопствена почит — пред сè и засекогаш.';

  @override
  String get dailyAffirmation205 =>
      'Заслужуваш нежност во деновите кога чувствуваш дека најмалку ја заслужуваш.';

  @override
  String get dailyAffirmation206 =>
      'Заслужуваш да бидеш нечија омилена личност.';

  @override
  String get dailyAffirmation207 => 'Заслужуваш живот со повеќе леснотија.';

  @override
  String get dailyAffirmation208 =>
      'Заслужуваш — не поради она што го правиш, туку затоа што постоиш.';

  @override
  String get dailyAffirmation209 =>
      'Заслужуваш да те посакуваат, а не само да им требаш.';

  @override
  String get dailyAffirmation210 => 'Заслужуваш повторно да си веруваш.';

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
