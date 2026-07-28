// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'When Scars (!) Become Art';

  @override
  String get loginWith => 'Şununla giriş yap:';

  @override
  String get loginWithGoogle => 'Google ile giriş yap';

  @override
  String get loginWithApple => 'Apple ile giriş yap';

  @override
  String get loginWithFacebook => 'Facebook ile giriş yap';

  @override
  String get orLoginWithUsernameAndPassword =>
      'Ya da kullanıcı adı ve şifre ile giriş yap';

  @override
  String get usernameLabel => 'Kullanıcı adı';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get loginButton => 'Giriş yap';

  @override
  String get loadingCredentials => 'Giriş bilgileri yükleniyor...';

  @override
  String get unableToLoadCredentials => 'Giriş bilgileri yüklenemedi';

  @override
  String get invalidCredentials => 'Geçersiz giriş bilgileri';

  @override
  String get homeLabel => 'Ana Sayfa';

  @override
  String get profileLabel => 'Profil';

  @override
  String get galleryLabel => 'Galeri';

  @override
  String get settingsLabel => 'Ayarlar';

  @override
  String get helpLabel => 'Yardım';

  @override
  String get profilePageTitle => 'Profil Sayfası';

  @override
  String get profilePageBody =>
      'Profil bilgilerini burada görüntüleyip düzenleyebilirsin.';

  @override
  String get galleryTitle => 'Galeri';

  @override
  String get galleryBody => 'Fotoğraf galerine burada göz at.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsBody => 'Uygulama ayarlarını burada yönet.';

  @override
  String get helpTitle => 'Yardım ve Destek';

  @override
  String get helpBody => 'Buradan yardım ve destek al.';

  @override
  String get settingsPreferencesTitle => 'Tercihler';

  @override
  String get settingsPreferencesBody => 'Uygulama deneyimini kişiselleştir.';

  @override
  String get settingsNotificationsTitle => 'Bildirimler';

  @override
  String get settingsNotificationsBody =>
      'Sana nasıl bildirim göndereceğimizi seç.';

  @override
  String get settingsLanguageTitle => 'Dil';

  @override
  String get settingsLanguageBody => 'Uygulamanın dilini seç.';

  @override
  String get settingsLanguageSystem => 'Sistem varsayılanı';

  @override
  String get languageEnglish => '🇬🇧 İngilizce';

  @override
  String get languageSerbianLatin => '🇷🇸 Sırpça (Latin)';

  @override
  String get languageMacedonian => '🇲🇰 Makedonca';

  @override
  String get languageGerman => '🇩🇪 Almanca';

  @override
  String get languageGreek => '🇬🇷 Yunanca';

  @override
  String get languageRomanian => '🇷🇴 Romence';

  @override
  String get languageArabic => '🇸🇦 Arapça';

  @override
  String get languageRomani => '🟦🟩🟨🔴 Romanca';

  @override
  String get languageTurkish => '🇹🇷 Türkçe';

  @override
  String get registrationTitle => 'Hesabını oluştur';

  @override
  String get registrationSubtitle => 'Başlamak için bilgilerini doldur.';

  @override
  String get fullNameLabel => 'Ad soyad';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get confirmPasswordLabel => 'Şifreyi onayla';

  @override
  String get registerButton => 'Kayıt ol';

  @override
  String get registerLink => 'Kayıt ol';

  @override
  String get noAccountPrompt => 'Hesabın yok mu?';

  @override
  String get alreadyHaveAccount => 'Zaten hesabın var mı?';

  @override
  String get fieldRequired => 'Bu alan zorunludur.';

  @override
  String get invalidEmail => 'Geçerli bir e-posta adresi gir.';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter olmalı.';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor.';

  @override
  String get registerSuccess => 'Kayıt tamamlandı.';

  @override
  String get mySpaceLabel => 'Alanım';

  @override
  String get messagesLabel => 'Mesajlar';

  @override
  String get logoutLabel => 'Çıkış yap';

  @override
  String get userMenuTooltip => 'Kullanıcı menüsü';

  @override
  String get userMenuAccountFallback => 'Hesap';

  @override
  String get guidedMeditationTitle => 'Rehberli Meditasyon';

  @override
  String get guidedMeditationDescription => 'Bir an dur, nefes al ve dinle.';

  @override
  String get guidedMeditationMetadataLoadFailed =>
      'Uzaktan parça bilgileri yüklenemedi. Yedek parça çalınıyor.';

  @override
  String get guidedMeditationSourceFirebase => 'Kaynak: Firebase';

  @override
  String get guidedMeditationSourceFallback => 'Kaynak: dahili yedek';

  @override
  String get skipLabel => 'Atla';

  @override
  String get pauseLabel => 'Duraklat';

  @override
  String get playLabel => 'Oynat';

  @override
  String get homeHowFeelingToday => 'Bugün kendini nasıl hissediyorsun?';

  @override
  String get startLabel => 'Başla';

  @override
  String get savingLabel => 'Kaydediliyor...';

  @override
  String get canvasNotReady => 'Tuval henüz hazır değil.';

  @override
  String saveFailedWithError(Object error) {
    return 'Kaydetme başarısız: $error';
  }

  @override
  String get bodyTransitionPrompt =>
      'Hislerini tanımlamadan önce bedenindeki fiziksel duyumlara nazikçe odaklanmak ister misin?';

  @override
  String get yesLabel => 'Yes';

  @override
  String get noLabel => 'No';

  @override
  String get continueLabel => 'Devam et';

  @override
  String get saveLabel => 'Kaydet';

  @override
  String get homeCheckAgainAnytime =>
      'Bugün istediğin zaman tekrar giriş yapabilirsin.';

  @override
  String get moodCheckLabel => 'Ruh hali kontrolü';

  @override
  String get bodyCheckLabel => 'Beden kontrolü';

  @override
  String get meditationLabel => 'Meditasyon';

  @override
  String get moodCheckFullscreenTitle => 'Ruh hali kontrolü (tam ekran)';

  @override
  String get exitFullscreenLabel => 'Tam ekrandan çık';

  @override
  String get fullscreenLabel => 'Tam ekran';

  @override
  String get skipToQuoteLabel => 'Alıntıya geç';

  @override
  String homeGreeting(Object name) {
    return 'Merhaba $name, bugün kendini nasıl hissediyorsun?';
  }

  @override
  String get todaysAffirmationLabel => 'Bugünün olumlaması';

  @override
  String get thereFallback => 'merhaba';

  @override
  String get dailyAffirmation1 => 'Asıl mucize, kendine inanmak.';

  @override
  String get dailyAffirmation2 => 'Farklılıklar dünyayı güzelleştirir.';

  @override
  String get dailyAffirmation3 => 'Yağmurun ardından gökkuşağı gelir.';

  @override
  String get dailyAffirmation4 =>
      'Herkesin aynı olmasının beklendiği yerlerde bile kendin olmana izin ver.';

  @override
  String get dailyAffirmation5 =>
      'Değerin sahip olduklarında değil, kim olduğunda saklı.';

  @override
  String get dailyAffirmation6 => 'İyi olmamak da gayet normal.';

  @override
  String get dailyAffirmation7 =>
      'Henüz görmediğin sofralarda bile seni bekleyen bir yer var.';

  @override
  String get dailyAffirmation8 =>
      'Her şeyi yapabilirsin — ama yapmak zorunda değilsin.';

  @override
  String get dailyAffirmation9 =>
      'Veda etmek canını acıtıyorsa, zamanını iyi geçirmişsin demektir.';

  @override
  String get dailyAffirmation10 => 'Seni önemseyenleri unutma.';

  @override
  String get dailyAffirmation11 =>
      'Ya her şey hayal ettiğinden daha güzel olursa?';

  @override
  String get dailyAffirmation12 => 'Sen yeterlisin';

  @override
  String get dailyAffirmation13 => 'Kendi yolumu kendim çizerim';

  @override
  String get dailyAffirmation14 => 'Bugün yeni bir gün. Parla!';

  @override
  String get dailyAffirmation15 =>
      'Umudunu asla kaybetme. Fırtınalar insanı güçlendirir ve hiçbiri sonsuza dek sürmez.';

  @override
  String get dailyAffirmation16 =>
      'Ağla. Affet. Öğren. Yoluna devam et. Gözyaşların, gelecekteki mutluluğunun tohumlarını sulasın.';

  @override
  String get dailyAffirmation17 => 'Kolay olmayabilir ama buna değecek.';

  @override
  String get dailyAffirmation18 => 'Güzel şeylere odaklanmayı unutma.';

  @override
  String get dailyAffirmation19 => 'Bu bencillik değil, kendine iyi bakmak.';

  @override
  String get dailyAffirmation20 => 'Harikasın, devam et.';

  @override
  String get dailyAffirmation21 => 'Kendine inan. Mucizeler yaratabilirsin';

  @override
  String get dailyAffirmation22 => 'Hayatın akışı içinde bu da geçecek.';

  @override
  String get dailyAffirmation23 =>
      'Karşılaştığım her zorluk, daha da güçlenmem için bir fırsat.';

  @override
  String get dailyAffirmation24 =>
      'Kalbimdeki soruları kucaklıyorum; cevaplar zamanı gelince gelecek.';

  @override
  String get dailyAffirmation25 => 'Mükemmel olmak zorunda değilsin.';

  @override
  String get dailyAffirmation26 =>
      'Mükemmellik bir ütopya. Olsa olsa pusula işi görür.';

  @override
  String get dailyAffirmation27 =>
      'Hayallerimi bulmak için ayakta duruyor ve mücadele ediyorum.';

  @override
  String get dailyAffirmation28 => 'Geleceğine başkaları karar vermesin.';

  @override
  String get dailyAffirmation29 =>
      'Ayaklarım yere sağlam basıyor; belirsiz zamanlarda bile dayanıklıyım ve büyümeye açığım.';

  @override
  String get dailyAffirmation30 =>
      'Hayat sana anlar sunuyorsa, onları güzel anılara dönüştür.';

  @override
  String get dailyAffirmation31 => 'Eski yollar yeni kapılar açmaz.';

  @override
  String get dailyAffirmation32 => 'Hatalar, denediğinin kanıtıdır.';

  @override
  String get dailyAffirmation33 =>
      'Sadece o adımı at ve dene; bu kadarı yeter.';

  @override
  String get dailyAffirmation34 =>
      'Bir araya geldiğimizde neler başarabildiğimize bir bak.';

  @override
  String get dailyAffirmation35 =>
      'Nereye gittiğini bilmiyorsan, her yol seni oraya götürür.';

  @override
  String get dailyAffirmation36 => 'Hayat tek bir gündür — o da bugün.';

  @override
  String get dailyAffirmation37 => 'Hepimiz yıldız tozundan yapıldık.';

  @override
  String get dailyAffirmation38 => 'Tutkuyla hayal et, sorumlulukla yaşa.';

  @override
  String get dailyAffirmation39 =>
      'Her şey yoluna girecek. Hadi, bir kez daha söyle.';

  @override
  String get dailyAffirmation40 => 'Tuhaf ol, eşsiz ol, kendin ol.';

  @override
  String get dailyAffirmation41 => 'Güçlü zihinler güvenli alanlarda yeşerir.';

  @override
  String get dailyAffirmation42 =>
      'Ne de olsa her başlangıç yalnızca bir devamdır ve olayların kitabı hep ortasından açıktır.';

  @override
  String get dailyAffirmation43 =>
      'Her şeyin bir başlangıcı ve bir sonu var — şu an ne kadar karanlık görünse de son güzel olabilir.';

  @override
  String get dailyAffirmation44 => 'İhtiyaç duyacağım tek onay, kendi onayım.';

  @override
  String get dailyAffirmation45 =>
      'Kahraman aramamalıyız; iyi fikirler aramalıyız.';

  @override
  String get dailyAffirmation46 =>
      'En küçük iyilik, en büyük iyi niyetten kat kat değerlidir.';

  @override
  String get dailyAffirmation47 =>
      'Geldiğin yer, küçültüp saklayacağın bir şey değil — içinde dimdik durabileceğin bir yer.';

  @override
  String get dailyAffirmation48 =>
      'Adın, dilin, ailenin hikâyesi — hepsi senin ve hepsini gururla taşıyabilirsin.';

  @override
  String get dailyAffirmation49 =>
      'Bu dünyada yer kaplamak için kimseden izin almana gerek yok.';

  @override
  String get dailyAffirmation50 =>
      'Sen hiçbir şeyin “fazlası” değilsin. Tam kararında bir sensin.';

  @override
  String get dailyAffirmation51 =>
      'Köklerin seni geri çekmez; tam tersine, seni yükselten onlardır.';

  @override
  String get dailyAffirmation52 =>
      'Bir yere ait olmanın tek bir yolu yok. Kendi yolunu kendin yazabilirsin.';

  @override
  String get dailyAffirmation53 =>
      'Hikâyen önemli — henüz kimsenin sormadığı kısımları bile.';

  @override
  String get dailyAffirmation54 =>
      'İçinde birden fazla ev taşıyorsun; bu bir yük değil, bir zenginlik.';

  @override
  String get dailyAffirmation55 =>
      'Kim olduğunla gurur duymak için önce kimsenin onayını almana gerek yok.';

  @override
  String get dailyAffirmation56 =>
      'Buradaki yerini kazanmak zorunda değilsin. Zaten bir yerin var.';

  @override
  String get dailyAffirmation57 =>
      'Bir yerlerde sana açık bir kapı var — öyle hissettirmeyen günlerde bile.';

  @override
  String get dailyAffirmation58 =>
      'Birden fazla yerde yuva kurmaya hakkın var.';

  @override
  String get dailyAffirmation59 =>
      'Gerçekten önemli olan insanlar sana yer açar; senden küçülmeni istemez.';

  @override
  String get dailyAffirmation60 => 'Kendi hayatında misafir değilsin.';

  @override
  String get dailyAffirmation61 =>
      'Bugün nerede duruyorsan, orada durmaya sonuna kadar hakkın var.';

  @override
  String get dailyAffirmation62 =>
      'Topluluk beklemekle olmaz; bazen onu başlatan kişi sensindir.';

  @override
  String get dailyAffirmation63 =>
      'Nereden geldiğinle nerede olduğun arasında seçim yapmak zorunda değilsin.';

  @override
  String get dailyAffirmation64 => 'Yarın, bugüne benzemek zorunda değil.';

  @override
  String get dailyAffirmation65 =>
      'İleride seni henüz hayal bile etmediğin bir hayat bekliyor — ve güzel bir hayat bu.';

  @override
  String get dailyAffirmation66 => 'Zor bölümler biter. Seninki de bitecek.';

  @override
  String get dailyAffirmation67 =>
      'Kendin için daha fazlasını istemeye ve gidip onu almaya hakkın var.';

  @override
  String get dailyAffirmation68 =>
      'Gelecek taşa kazınmış değil. Hâlâ söz hakkın var.';

  @override
  String get dailyAffirmation69 => 'Küçük adımlar da ilerlemektir.';

  @override
  String get dailyAffirmation70 =>
      'Geride kalmadın. Tam olarak yolunun seni getirdiği yerdesin.';

  @override
  String get dailyAffirmation71 =>
      'Senin için yolda olanlar henüz yaşanmadı — onlara seni şaşırtma payı bırak.';

  @override
  String get dailyAffirmation72 =>
      'Hikâyenin bundan sonrasına sen karar verirsin.';

  @override
  String get dailyAffirmation73 =>
      'Bugüne kadar her zor günü atlattın. Bu şans değil — bu sensin.';

  @override
  String get dailyAffirmation74 =>
      'Yorgun olman başarısız olduğun anlamına gelmez. Çok şey taşıdığın anlamına gelir.';

  @override
  String get dailyAffirmation75 =>
      'Kırılmaz olmak zorunda değilsin. Kendi hızında devam etmen yeter.';

  @override
  String get dailyAffirmation76 =>
      'Güç, hiç zorlanmamak değil; her şeye rağmen yeniden sahaya çıkmaktır.';

  @override
  String get dailyAffirmation77 =>
      'Atlatmış olmanla gurur duyabilirsin — süreç hiç şık görünmese bile.';

  @override
  String get dailyAffirmation78 =>
      'Hikâyenin en zor bölümleri son sözü söyleyemez.';

  @override
  String get dailyAffirmation79 =>
      'İnsanların hiç görmediği şeyleri atlattın — ve bu az şey değil.';

  @override
  String get dailyAffirmation80 =>
      'İyileşmek beklediğinden uzun sürüyorsa, sorun değil.';

  @override
  String get dailyAffirmation81 =>
      'Yola devam etmek için her şeyi çözmüş olman gerekmiyor.';

  @override
  String get dailyAffirmation82 =>
      'Her gün pes etmeyip yeniden denemen, sessiz bir cesarettir.';

  @override
  String get dailyAffirmation83 =>
      'Vasat bir gün geçirmek tamamen yasal. Ruhsat gerekmiyor.';

  @override
  String get dailyAffirmation84 =>
      'Bazen hayat, günde üç kez “ne yesem?” demekten ibarettir — sonsuza dek. Sen bunu halledersin.';

  @override
  String get dailyAffirmation85 =>
      'Her gün bir başyapıt olmak zorunda değil. Bazı günler sadece yaşansın diye vardır.';

  @override
  String get dailyAffirmation86 =>
      'Grup sohbetindeki bildirim sayısı ne derse desin, gayet iyi gidiyorsun.';

  @override
  String get dailyAffirmation87 =>
      'Özgüven: nereye gittiğini gerçekten öğrenene kadar biliyormuş gibi yapmak.';

  @override
  String get dailyAffirmation88 =>
      'En kötü günlerinin %100\'ünü atlattın. Gayet sağlam bir sicil.';

  @override
  String get dailyAffirmation89 =>
      'Kimse hayatı çözmüş değil. Çözmüş gibi görünenler sadece mesajlara geç dönme konusunda daha iyi.';

  @override
  String get dailyAffirmation90 =>
      'Bugün beş yıllık plana ihtiyacın yok. Düzgün bir kahvaltı yeter.';

  @override
  String get dailyAffirmation91 =>
      'Büyümek çoğu zaman şuna benzer: öne doğru tökezlersin, adına da “ilerleme” dersin.';

  @override
  String get dailyAffirmation92 =>
      'Bazı günler kazanmak şudur: yataktan kalktın. Bu da sayılır.';

  @override
  String get dailyAffirmation93 =>
      'Her şeyi tek başına taşımak zorunda değilsin; bırak insanlar yardım etsin.';

  @override
  String get dailyAffirmation94 =>
      'Dışarıda bir yerde arkanı kollayan biri var — bunu hissetmenin zor olduğu günlerde bile.';

  @override
  String get dailyAffirmation95 =>
      'Yardım istemek zayıflık değildir. Gerçek dostluklar böyle kurulur.';

  @override
  String get dailyAffirmation96 =>
      'Çevrendeki insanların sana ihtiyacı, tam olarak senin onlara ihtiyacın kadar.';

  @override
  String get dailyAffirmation97 =>
      'Kendini görünmez hissettiğin günlerde bile daha büyük bir şeyin parçasısın.';

  @override
  String get dailyAffirmation98 =>
      'Dinlenmek için önce tamamen tükenmen gerekmiyor.';

  @override
  String get dailyAffirmation99 =>
      'Bugün üzgün olman, yarın iyi hissetmene engel değil.';

  @override
  String get dailyAffirmation100 =>
      'Kimseye sürekli pozitiflik borçlu değilsin.';

  @override
  String get dailyAffirmation101 => 'Şu an bir cevabın olmaması gayet normal.';

  @override
  String get dailyAffirmation102 =>
      'Bugün kendine bakman bencillik değil, ihtiyaç.';

  @override
  String get dailyAffirmation103 =>
      'Başkasının önyargısı, senin kim olduğunun kanıtı değildir.';

  @override
  String get dailyAffirmation104 =>
      'Sen, başkalarının senin hakkında anlattığı hikâye değilsin.';

  @override
  String get dailyAffirmation105 =>
      'Daha azını hak ettiğin düşüncesi asla doğru değil. Saygının tamamını hak ediyorsun.';

  @override
  String get dailyAffirmation106 =>
      'Değerin asla tartışmaya açık değil — sana aksini hissettiren kim olursa olsun.';

  @override
  String get dailyAffirmation107 =>
      'Görünmez değilsin. Burada biri, senin tam olarak kim olduğunu görüyor.';

  @override
  String get dailyAffirmation108 =>
      'Bazılarının seni görmezden gelmesi, herkesin görmediği anlamına gelmez.';

  @override
  String get dailyAffirmation109 =>
      'Kimsenin bunu yüksek sesle söylemediği odalarda bile önemlisin.';

  @override
  String get dailyAffirmation110 =>
      'Birileri fark etti. Hissettiğin kadar görünmez değilsin.';

  @override
  String get dailyAffirmation111 =>
      'Doğru sebeplerle fark edilmek için küçülmene gerek yok.';

  @override
  String get dailyAffirmation112 =>
      'Görülmek, kendini nasıl gördüğünle başlar — ve sen oradan başlayabilirsin.';

  @override
  String get dailyAffirmation113 =>
      'Ne “fazla”sın ne “eksik” — sen sadece olduğun gibi görülüyorsun.';

  @override
  String get dailyAffirmation114 =>
      'Seni sen yapan şeylerin kıymetini bilen insanlar var.';

  @override
  String get dailyAffirmation115 =>
      'Varlığın bir odanın havasını değiştirir — öyle hissettirmediğinde bile.';

  @override
  String get dailyAffirmation116 =>
      'Sandığından daha çok insan, sandığından daha çok yönünle tanıyor seni.';

  @override
  String get dailyAffirmation117 =>
      'Başına gelen her şeyi kontrol edemezsin. Ama onu nasıl karşılayacağın senin elinde.';

  @override
  String get dailyAffirmation118 =>
      'Bundan sonra ne olacağına karar verecek olan sensin.';

  @override
  String get dailyAffirmation119 =>
      'Zor koşullarda bile küçük seçimler hâlâ senin elinde.';

  @override
  String get dailyAffirmation120 =>
      'Kendi hayatında yolcu koltuğunda değilsin.';

  @override
  String get dailyAffirmation121 =>
      'İhtiyacın olanı istemek zayıflık değil, güçtür.';

  @override
  String get dailyAffirmation122 =>
      'Bu konuda söz hakkın var — öyle hissettirmediğinde bile.';

  @override
  String get dailyAffirmation123 =>
      'Bir sonraki bölümünü senden başka kimse yazamaz.';

  @override
  String get dailyAffirmation124 =>
      'Senin için kurulmamış sistemlerde bile seçimlerin sayılır.';

  @override
  String get dailyAffirmation125 =>
      'Bir şeylerin farklı olmasını istemeye ve bunun için çabalamaya hakkın var.';

  @override
  String get dailyAffirmation126 => 'Bugünle ne yapacağın hâlâ senin kararın.';

  @override
  String get dailyAffirmation127 =>
      'Buradaki yerini hak etmek için kim olduğunu değiştirmene gerek yok.';

  @override
  String get dailyAffirmation128 =>
      'Tam olarak olduğun haline yer açacak insanlar var.';

  @override
  String get dailyAffirmation129 =>
      'Birden fazla yere aitsin — ve bu bir çelişki değil.';

  @override
  String get dailyAffirmation130 =>
      'Gerçek bağ, hiçbir yanını saklamanı istemez.';

  @override
  String get dailyAffirmation131 =>
      'Bir yerlerde biri, senin var olmana seviniyor.';

  @override
  String get dailyAffirmation132 =>
      'Ait olmak için kendini açıklamak zorunda değilsin.';

  @override
  String get dailyAffirmation133 =>
      'Topluluğa girmek için sınav yok. Sen zaten içindesin.';

  @override
  String get dailyAffirmation134 =>
      'Başladığın yerden uzakta olman, yuvasız olduğun anlamına gelmez.';

  @override
  String get dailyAffirmation135 =>
      'Bunu tek başına yapmak zorunda değilsin — öyle hissettirse bile.';

  @override
  String get dailyAffirmation136 =>
      'Seni sadece dışarıdan izleyenler değil, hayatı seninle yan yana kuran insanlar da var.';

  @override
  String get dailyAffirmation137 =>
      'Köklerin kuşaklar boyu biriken bir gücü taşıyor — o güç sana da miras.';

  @override
  String get dailyAffirmation138 =>
      'Dilin, geleneklerin, ailenin hikâyesi — hepsi yaşatılmaya değer.';

  @override
  String get dailyAffirmation139 =>
      'Topluluğunu farklı kılan şey, tam da ona ait olmayı değerli kılan şeydir.';

  @override
  String get dailyAffirmation140 =>
      'Geldiğin yer için kimseye özür borçlu değilsin.';

  @override
  String get dailyAffirmation141 =>
      'Mirasın idare edilecek bir şey değil, gurur duyulacak bir şeydir.';

  @override
  String get dailyAffirmation142 =>
      'Kültürün çözülmesi gereken bir sorun değil, gücünün bir parçasıdır.';

  @override
  String get dailyAffirmation143 =>
      'Kim olduğunla gurur duymak, dünyayı toz pembe görmek demek değildir.';

  @override
  String get dailyAffirmation144 =>
      'Kimliğin sırtında taşıdığın bir yük değil, üzerinde durduğun sağlam bir zemindir.';

  @override
  String get dailyAffirmation145 =>
      'Sana emanet edilenler, ileriye taşınmayı hak ediyor.';

  @override
  String get dailyAffirmation146 =>
      'Bugün içinde bir boşluk varsa sorun değil. İyiymiş gibi rol yapmak zorunda değilsin.';

  @override
  String get dailyAffirmation147 => 'Kendini anlatmaktan yorulmaya hakkın var.';

  @override
  String get dailyAffirmation148 =>
      'Üzülmek zayıf olduğunu göstermez. Gerçek bir şeye kulak verdiğini gösterir.';

  @override
  String get dailyAffirmation149 =>
      'Her gün umutlu olmak zorunda değilsin. Bazı günler, günü bitirebilmek bile yeterli.';

  @override
  String get dailyAffirmation150 =>
      'Hiçbir zaman adil olmamış şeylere öfkelenmek gayet normal.';

  @override
  String get dailyAffirmation151 =>
      'Gerçek bir şeye ağlamak, dağılmakla aynı şey değil.';

  @override
  String get dailyAffirmation152 =>
      'Bir şeyin neden canını yaktığını kanıtlamak zorunda değilsin. Yaktı işte. Bu yeterli bir sebep.';

  @override
  String get dailyAffirmation153 =>
      'Bazı günler çıta sadece “giyinebildin” olur. O çıtaya saygı duy.';

  @override
  String get dailyAffirmation154 =>
      'Pazartesilerinin %100\'ünü atlattın. Namağlupsun.';

  @override
  String get dailyAffirmation155 =>
      'Kimsenin hayatı fotoğraflarındaki gibi değil. Seninkinin de öyle olması gerekmiyor.';

  @override
  String get dailyAffirmation156 =>
      'Yetişkinlik: %10 bilgelik, %90 yazıcının nasıl çalıştığını biliyormuş gibi yapmak.';

  @override
  String get dailyAffirmation157 =>
      'Kendini birazcık daha iyi biri gibi hissetmene tek bir atıştırmalık kaldı. Git al onu.';

  @override
  String get dailyAffirmation158 =>
      'Özgüven: bir yere, kirasını sen ödüyormuşsun gibi girmek.';

  @override
  String get dailyAffirmation159 =>
      'Bazen duyguların üstüne kestirmek de serbest. Duygular sabırlıdır, bekler.';

  @override
  String get dailyAffirmation160 =>
      'Sabah insanı olmak zorunda değilsin. Sabahı sağ atlatman yeter.';

  @override
  String get dailyAffirmation161 =>
      'Fazla düşünmek de kalori yakıyordur… muhtemelen. Tatlıyı hak ettin.';

  @override
  String get dailyAffirmation162 =>
      'Bazı kararların en iyisi yazı turayla verilir — hangisi gelirse gelsin, için rahatlar.';

  @override
  String get dailyAffirmation163 =>
      'İstatistiksel olarak harika gidiyorsun — en azından çöp kutusundaki bir rakundan iyi durumdasın.';

  @override
  String get dailyAffirmation164 =>
      'Derin nefes almak başlı başına bir öz bakım rutini sayılır. Resmen çiçek gibisin.';

  @override
  String get dailyAffirmation165 =>
      'Bugün bir grup ödevi olsaydı, çoğu kişiden fazlasını yapmış olurdun.';

  @override
  String get dailyAffirmation166 =>
      'Kimsenin bitkisi ilk denemede hayatta kalmaz. Sandığından iyi gidiyorsun.';

  @override
  String get dailyAffirmation167 =>
      'Teknik olarak, şimdiye kadarki her “hayatımın en kötü günü”nü sağ atlattın.';

  @override
  String get dailyAffirmation168 =>
      'Yorgunluk, bedeninin bütün gün var olduğun için seni alkışlamasıdır.';

  @override
  String get dailyAffirmation169 =>
      'Her gün ters köşe olmak zorunda değil. Bazı günlere atıştırmalık ve bir şekerleme yeter.';

  @override
  String get dailyAffirmation170 =>
      'Yapım aşamasında olabilirsin ve yine de bugün bütün bir insansın.';

  @override
  String get dailyAffirmation171 =>
      'Korkutucu bir işi ertelemek, aslında beyninin sana iyi arkadaşlık etmesidir.';

  @override
  String get dailyAffirmation172 =>
      'Hayat kullanma kılavuzuyla gelmiyor. Açıkçası, doğaçlamayı harika götürüyorsun.';

  @override
  String get dailyAffirmation173 =>
      'Bugün başrol sensin — senaryo sadece çamaşır yıkamak olsa bile.';

  @override
  String get dailyAffirmation174 =>
      'Hayatını toparlayamamış olman normal. Kimse toparlayamadı; onların sadece ışığı daha iyi.';

  @override
  String get dailyAffirmation175 =>
      'Bugünü kullanım kılavuzu olmadan idare ettin — bu resmen bir süper güç.';

  @override
  String get dailyAffirmation176 =>
      'Küçük zaferler de zaferdir — “o mesaja sonunda cevap verdim” bile.';

  @override
  String get dailyAffirmation177 =>
      'Günü kazanmak zorunda değilsin. Atıştırmalıklarla atlatmak da gayet meşru bir strateji.';

  @override
  String get dailyAffirmation178 =>
      'Bazı günler aslansın. Bazı günlerse sadece battaniye isteyen bir aslan. İkisi de gayet normal.';

  @override
  String get dailyAffirmation179 =>
      'Kaosa gülmek serbest. Çoğu zaman en aklı başında tepki budur.';

  @override
  String get dailyAffirmation180 =>
      'Gelecekteki sen, birazdan yapacağın şekerleme için sana teşekkür edecek.';

  @override
  String get dailyAffirmation181 =>
      'Önce değişmeni istemeyen bir sevgiyi hak ediyorsun.';

  @override
  String get dailyAffirmation182 =>
      'Dinlenmeyi hak ediyorsun — bunu “kazanmadığın” günlerde bile.';

  @override
  String get dailyAffirmation183 =>
      'Tam da olduğun halinle yer kaplamayı hak ediyorsun.';

  @override
  String get dailyAffirmation184 =>
      'Sadece katlanılmayı değil, seçilmeyi hak ediyorsun.';

  @override
  String get dailyAffirmation185 =>
      'Şefkati hak ediyorsun — kendi şefkatin de dahil.';

  @override
  String get dailyAffirmation186 =>
      'Güzel şeyleri hak ediyorsun — istemeyi akıl etmediklerini bile.';

  @override
  String get dailyAffirmation187 =>
      'Senin için gerçekten orada olan insanları hak ediyorsun.';

  @override
  String get dailyAffirmation188 =>
      'Sana ait hissettiren bir hayatı hak ediyorsun.';

  @override
  String get dailyAffirmation189 =>
      'Konuştuğunda sana inanılmasını hak ediyorsun.';

  @override
  String get dailyAffirmation190 =>
      'Yumuşaklığı hak ediyorsun — sert bir dünyada bile.';

  @override
  String get dailyAffirmation191 =>
      'Hiçbir açıklama gerektirmeyen bir sevinci hak ediyorsun.';

  @override
  String get dailyAffirmation192 =>
      'Nerede olursan ol, güvende olmayı hak ediyorsun.';

  @override
  String get dailyAffirmation193 =>
      'Önce kazanmana gerek olmadan sevilmeyi hak ediyorsun.';

  @override
  String get dailyAffirmation194 =>
      'Odada bir köşeyi değil, masada bir sandalyeyi hak ediyorsun.';

  @override
  String get dailyAffirmation195 =>
      'Kimseden ödünç alınmamış, tamamen sana ait hayalleri hak ediyorsun.';

  @override
  String get dailyAffirmation196 =>
      'Sabrı hak ediyorsun — en başta kendi sabrını.';

  @override
  String get dailyAffirmation197 =>
      'Sadece hoş görülmeyi değil, anlaşılmayı hak ediyorsun.';

  @override
  String get dailyAffirmation198 =>
      'Sadece ayakta kalmayı değil, başına güzel şeyler gelmesini hak ediyorsun.';

  @override
  String get dailyAffirmation199 =>
      'Sadece kabul edilmeyi değil, kutlanmayı hak ediyorsun.';

  @override
  String get dailyAffirmation200 =>
      'Bugün, tam da olduğun halinle değerlisin — eksik kalmış yanlarınla bile.';

  @override
  String get dailyAffirmation201 =>
      'En zor günlerini tekrarlamayan bir geleceği hak ediyorsun.';

  @override
  String get dailyAffirmation202 =>
      'Kendinle gurur duymayı hak ediyorsun — hiçbir şarta bağlı olmadan.';

  @override
  String get dailyAffirmation203 =>
      'Seni küçülmek zorunda bırakmayan insanları hak ediyorsun.';

  @override
  String get dailyAffirmation204 =>
      'Herkesten önce ve her zaman, kendi saygını hak ediyorsun.';

  @override
  String get dailyAffirmation205 =>
      'En az hak ettiğini hissettiğin günlerde bile nazik davranılmayı hak ediyorsun.';

  @override
  String get dailyAffirmation206 =>
      'Birinin en sevdiği insan olmayı hak ediyorsun.';

  @override
  String get dailyAffirmation207 => 'Daha rahat akan bir hayatı hak ediyorsun.';

  @override
  String get dailyAffirmation208 =>
      'Yaptıkların için değil, sırf var olduğun için değerlisin.';

  @override
  String get dailyAffirmation209 =>
      'Sadece ihtiyaç duyulmayı değil, istenmeyi hak ediyorsun.';

  @override
  String get dailyAffirmation210 => 'Kendine yeniden güvenmeyi hak ediyorsun.';

  @override
  String get pleaseLogInAgain => 'Lütfen tekrar giriş yap.';

  @override
  String get unableToCaptureDrawing => 'Çizim yakalanamadı.';

  @override
  String get unableToExportDrawing => 'Çizim dışa aktarılamadı.';

  @override
  String get drawingSaved => 'Çizim kaydedildi.';

  @override
  String failedToSaveWithCode(Object code) {
    return 'Kaydetme başarısız: $code';
  }

  @override
  String get failedToSaveDrawing => 'Çizim kaydedilemedi.';

  @override
  String get toolsLabel => 'Araçlar';

  @override
  String get useThisColorLabel => 'Bu rengi kullan';

  @override
  String get textSizeLabel => 'Yazı boyutu';

  @override
  String get eraserSizeLabel => 'Silgi boyutu';

  @override
  String get brushSizeLabel => 'Fırça boyutu';

  @override
  String get fontLabel => 'Yazı tipi';

  @override
  String get addTextTitle => 'Yazı ekle';

  @override
  String get writeUpToTwoLinesHint => 'En fazla 2 satır yaz';

  @override
  String get cancelLabel => 'İptal';

  @override
  String get addLabel => 'Ekle';

  @override
  String get undoLabel => 'Geri al';

  @override
  String get clearLabel => 'Temizle';

  @override
  String get moreToolsLabel => 'Daha fazla araç';

  @override
  String get verificationExpiredDeleted =>
      'Doğrulama süresi doldu. Hesap silindi.';

  @override
  String verifyEmailUntil(Object email, Object expiryText) {
    return 'Lütfen $email adresini $expiryText tarihine kadar doğrula.';
  }

  @override
  String verifyEmail(Object email) {
    return 'Lütfen $email adresini doğrula.';
  }

  @override
  String get googleSignInFailed => 'Google ile giriş başarısız.';

  @override
  String get appleSignInFailed => 'Apple ile giriş başarısız oldu.';

  @override
  String get userFallbackName => 'Kullanıcı';

  @override
  String get resetPasswordTitle => 'Şifreyi sıfırla';

  @override
  String get enterValidEmail => 'Geçerli bir e-posta gir.';

  @override
  String get sendLinkLabel => 'Bağlantıyı gönder';

  @override
  String passwordResetSent(Object email) {
    return 'Şifre sıfırlama e-postası $email adresine gönderildi.';
  }

  @override
  String get unableToSendPasswordReset =>
      'Şifre sıfırlama e-postası gönderilemedi.';

  @override
  String get signingInLabel => 'Giriş yapılıyor...';

  @override
  String get forgotPasswordLabel => 'Şifreni mi unuttun?';

  @override
  String get acceptTermsRequired => 'Lütfen şartları ve hizmetleri kabul et.';

  @override
  String get usernameAlreadyExists => 'Bu kullanıcı adı zaten var.';

  @override
  String get registrationFailed => 'Kayıt başarısız.';

  @override
  String verificationEmailSent(Object email) {
    return 'Doğrulama e-postası $email adresine gönderildi.';
  }

  @override
  String registrationFailedWithCode(Object code) {
    return 'Kayıt başarısız: $code';
  }

  @override
  String get registrationTimedOut =>
      'Kayıt zaman aşımına uğradı. Emülatörü kontrol et.';

  @override
  String registrationFailedWithError(Object error) {
    return 'Kayıt başarısız: $error';
  }

  @override
  String get atLeast6Characters => 'En az 6 karakter.';

  @override
  String get passwordTooWeak => 'Şifre çok zayıf.';

  @override
  String get passwordRuleAtLeast8 => 'En az 8 karakter';

  @override
  String get passwordRuleUppercase => 'En az 1 büyük harf';

  @override
  String get passwordRuleNumber => 'En az 1 rakam';

  @override
  String get passwordRuleSpecial => 'En az 1 özel karakter';

  @override
  String get iAcceptPrefix => 'Kabul ediyorum:';

  @override
  String get termsAndServicesLabel => 'şartlar ve hizmetler';

  @override
  String get oneBalloonPerDayMessage =>
      'Günde sadece bir balon patlatabilirsin. Yarın tekrar gel.';

  @override
  String get languageEnglishLabel => 'İngilizce';

  @override
  String get messageTitle => 'Mesaj';

  @override
  String get closeLabel => 'Kapat';

  @override
  String get savedToMySpace => 'Alanım\'a kaydedildi.';

  @override
  String get alreadyOpenedTodayMessage =>
      'Bugünkü mesajını zaten açtın. Yeni bir balon için yarın tekrar gel.';

  @override
  String get mySpaceIntro =>
      'Takvim, günlük ve kayıtlı kütüphanen — hepsi tek bir yerde.';

  @override
  String get calendarLabel => 'Takvim';

  @override
  String get journalLabel => 'Günlük';

  @override
  String get libraryLabel => 'Kütüphane';

  @override
  String get mySpaceCalendarSubtitle => 'Ruh hali, beden, alıntı, not';

  @override
  String get mySpaceJournalSubtitle => 'Girişler ve sorular';

  @override
  String get mySpaceLibrarySubtitle => 'Kayıtlı kaynaklar';

  @override
  String get deleteDrawingTitle => 'Çizimi sil?';

  @override
  String get deleteDrawingBody => 'Bu işlem geri alınamaz.';

  @override
  String get deleteLabel => 'Sil';

  @override
  String get failedToDeleteDrawing => 'Çizim silinemedi.';

  @override
  String get noDrawingsForDay => 'Bu güne ait kayıtlı çizim yok.';

  @override
  String get noBodyMapForDay => 'Bu güne ait kayıtlı beden haritası yok.';

  @override
  String get noFrontMapForDay => 'Bu güne ait kayıtlı ön beden haritası yok.';

  @override
  String get noBackMapForDay => 'Bu güne ait kayıtlı arka beden haritası yok.';

  @override
  String get showBackLabel => 'Arkayı göster';

  @override
  String get showFrontLabel => 'Önü göster';

  @override
  String get previewUnavailable => 'Önizleme kullanılamıyor';

  @override
  String get deleteDrawingTooltip => 'Çizimi sil';

  @override
  String get dayOverviewTitle => 'Gün özeti';

  @override
  String selectedDateLabel(Object dateLabel) {
    return 'Seçilen tarih: $dateLabel';
  }

  @override
  String get moodLabel => 'Ruh hali';

  @override
  String get bodyLabel => 'Beden';

  @override
  String get quoteLabel => 'Alıntı';

  @override
  String get noteLabel => 'Not';

  @override
  String get noQuoteForDay => 'Bu güne ait kayıtlı alıntı yok.';

  @override
  String get dailyMessageLabel => 'Günlük Mesaj';

  @override
  String get noDailyMessageForDay => 'Bu gün için kayıtlı mesaj yok.';

  @override
  String get noNoteForDay => 'Bu güne ait kayıtlı not yok.';

  @override
  String get doneLabel => 'Tamam';

  @override
  String get failedToSaveJournalEntry => 'Günlük girişi kaydedilemedi.';

  @override
  String get mySpaceJournalTitle => 'Alanım Günlüğü';

  @override
  String get noJournalEntriesYet => 'Henüz günlük girişi yok.';

  @override
  String get entryCannotBeEmpty => 'Giriş boş olamaz.';

  @override
  String get newEntryTitle => 'Yeni Giriş';

  @override
  String get promptsLabel => 'Sorular';

  @override
  String get startWritingHint => 'Yazmaya başla...';

  @override
  String get mySpaceLibraryTitle => 'Alanım Kütüphanesi';

  @override
  String get savedResourcesTitle => 'Kayıtlı Kaynaklar';

  @override
  String get guidedBreathingVideo => 'Rehberli nefes videosu';

  @override
  String get calmingAudio => 'Sakinleştirici ses';

  @override
  String get savedMessagesTitle => 'Kayıtlı Mesajlar';

  @override
  String get loadingLabel => 'Yükleniyor...';

  @override
  String get noSavedMessagesYet => 'Henüz kayıtlı mesaj yok.';

  @override
  String get contactsLabel => 'Kişiler';

  @override
  String get therapistLabel => 'Terapist';

  @override
  String get trustedFriendLabel => 'Güvendiğin arkadaş';

  @override
  String get promptComfortToday => 'Bugün sana rahatlık veren bir şey neydi?';

  @override
  String get promptBodyMorning => 'Bedenin bu sabah nasıl hissediyordu?';

  @override
  String get promptThreeGrateful => 'Minnettar olduğun üç şey say.';

  @override
  String get promptEmotionColor => 'Duyguların bir renk olsaydı, ne olurdu?';

  @override
  String get promptFutureSelf => 'Gelecekteki kendine kısa bir not yaz.';

  @override
  String get deleteAccountDialogTitle => 'Hesabı sil?';

  @override
  String get deleteAccountDialogBody =>
      'Bu işlem hesabını ve uygulama verilerini kalıcı olarak siler. Geri alınamaz.';

  @override
  String get deleteAccountActionLabel => 'Hesabı sil';

  @override
  String get confirmLabel => 'Onayla';

  @override
  String get deleteAccountRequiresRecentLogin =>
      'Lütfen tekrar giriş yap, ardından hesap silmeyi yeniden dene.';

  @override
  String get deleteAccountFailed => 'Hesap silinemedi.';

  @override
  String get deleteAccountSettingsSubtitle =>
      'Hesabını ve uygulama verilerini kalıcı olarak sil.';

  @override
  String get careCornerTabLabel => 'Bakım Köşesi';

  @override
  String get careCornerWellbeingTitle => 'İyi Oluş';

  @override
  String get careCornerSupportTitle => 'Destek ve Hizmetler';

  @override
  String get careCornerEducationTitle => 'Eğitim';

  @override
  String get careCornerHubSuffixWellbeing => 'İyi Oluş Merkezi';

  @override
  String get careCornerHubSuffixSupport => 'Destek Merkezi';

  @override
  String get careCornerHubSuffixEducation => 'Eğitim Merkezi';

  @override
  String get careCornerBackToHubLabel => 'Merkeze dön';

  @override
  String get careCornerBackLabel => 'Geri';

  @override
  String get careCornerFurtherReadingTitle =>
      'Daha Fazla Okuma ve Derinlemesine İnceleme';

  @override
  String get careCornerFreeBadge => 'ÜCRETSİZ';

  @override
  String get careCornerResourceNotice =>
      'Kaynak ayrıntıları ve yerel iletişim bilgileri ülke ve konuya göre düzenlenir.';

  @override
  String get careCornerLocalSupportCenterTitle => 'Yerel destek merkezi';

  @override
  String get careCornerContactInfoDescription => 'İletişim bilgileri';

  @override
  String get careCornerActionCall => 'ARA';

  @override
  String get careCornerActionCallNow => 'ŞİMDİ ARA';

  @override
  String get careCornerActionSecureChat => 'GÜVENLİ SOHBET';

  @override
  String get careCornerActionVisitWebsite => 'WEB SİTESİNİ ZİYARET ET';

  @override
  String get careCornerActionEmail => 'E-POSTA';

  @override
  String get careCornerActionScheduleCall => 'ARAMA PLANLA';

  @override
  String get careCornerActionBookAppointment => 'RANDEVU AL';

  @override
  String get careCornerTopicBreathing => 'Nefes Egzersizleri';

  @override
  String get careCornerTopicMeditation => 'Rehberli Meditasyon';

  @override
  String get careCornerTopicMusic => 'Müzik Seansları';

  @override
  String get careCornerTopicJournaling => 'Günlük Tutma Soruları';

  @override
  String get careCornerTopicSelfCare => 'Öz-Bakım Rutinleri';

  @override
  String get careCornerTopicColorTheory => 'Renk Teorisi Videoları';

  @override
  String get careCornerTopicViolenceProtection => 'Şiddet ve Koruma';

  @override
  String get careCornerTopicLegalHelp => 'Hukuki Yardım';

  @override
  String get careCornerTopicHealthcare => 'Sağlık Hizmetlerine Erişim';

  @override
  String get careCornerTopicSupportGroups => 'Destek Grupları';

  @override
  String get careCornerTopicEmergency => 'Acil Hizmetler';

  @override
  String get careCornerTopicLocalNgos => 'Yerel STK\'lar';

  @override
  String get careCornerTopicDiscrimination => 'Ayrımcılık';

  @override
  String get careCornerTopicRacism => 'Irkçılık';

  @override
  String get careCornerTopicAntigypsyism => 'Antiziganizm';

  @override
  String get careCornerTopicHateSpeech => 'Çevrimiçi Nefret Söylemi';

  @override
  String get careCornerTopicXenophobia => 'Yabancı Düşmanlığı';

  @override
  String get careCornerTopicMyRights => 'Haklarım';

  @override
  String get careCornerFurtherReadingIdentity => 'Kimlik ve Aidiyet';

  @override
  String get careCornerFurtherReadingDiscriminationSupport =>
      'Ayrımcılık Desteği';

  @override
  String get careCornerFurtherReadingSeekHelp => 'Ne Zaman Yardım Almalı';

  @override
  String get careCornerCountryRomania => 'Romanya';

  @override
  String get careCornerCountrySerbia => 'Sırbistan';

  @override
  String get careCornerCountryGreece => 'Yunanistan';

  @override
  String get careCornerCountryNorthMacedonia => 'Kuzey Makedonya';

  @override
  String get careCornerCountryGermany => 'Almanya';

  @override
  String get careCornerCountryTurkey => 'Türkiye';

  @override
  String get careCornerCountryEuropeanUnion => 'Avrupa Birliği';

  @override
  String get termsTitle => 'Kullanım Koşulları';

  @override
  String termsEffectiveDate(Object date) {
    return 'Yürürlük tarihi: $date';
  }

  @override
  String termsIntro(Object appName) {
    return 'Bu Koşullar, $appName kullanımını düzenler. Bir hesap oluşturarak veya uygulamayı kullanarak bu Koşulları kabul etmiş olursun.';
  }

  @override
  String get termsSection1Title => '1. Uygunluk ve Hesaplar';

  @override
  String get termsSection1Bullet1 =>
      'Doğru kayıt bilgileri sağlamalı ve giriş bilgilerini güvende tutmalısın.';

  @override
  String get termsSection1Bullet2 =>
      'Hesabın altında gerçekleşen etkinliklerden sorumlusun.';

  @override
  String get termsSection1Bullet3 =>
      'Başka bir kişinin kimliğine bürünemez veya platformu kötüye kullanamazsın.';

  @override
  String get termsSection1Bullet4 =>
      '16 yaşın altındaki kullanıcılar, uygulamayı yalnızca ebeveyn veya yasal vasinin onayıyla ve yalnızca yürürlükteki yasaların izin verdiği yerlerde kullanabilir.';

  @override
  String get termsSection2Title => '2. Uygulamanın Sunduğu';

  @override
  String get termsSection2Bullet1 =>
      'Ruh hali çizimi kontrolleri, beden farkındalığı araçları, rehberli yansıtma içerikleri, mesajlar ve günlük/kütüphane özellikleri.';

  @override
  String get termsSection2Bullet2 =>
      'Uygulama duygusal iyi oluşu ve öz-yansıtmayı destekler.';

  @override
  String get termsSection2Bullet3 =>
      'Uygulama bir kriz hizmeti değildir ve tıbbi, psikiyatrik veya acil bakımın yerine geçmez.';

  @override
  String get termsSection3Title => '3. Sağlık ve Güvenlik Uyarısı';

  @override
  String get termsSection3Bullet1 =>
      'Uygulamadaki hiçbir içerik tıbbi tavsiye, teşhis veya tedavi değildir.';

  @override
  String get termsSection3Bullet2 =>
      'Tehlikedeysen veya bir acil durum yaşıyorsan, derhal yerel acil hizmetlerle iletişime geç.';

  @override
  String get termsSection3Bullet3 =>
      'Bir egzersiz rahatsızlığa neden oluyorsa, dur ve profesyonel destek al.';

  @override
  String get termsSection4Title => '4. Kullanıcı İçeriği';

  @override
  String get termsSection4Bullet1 =>
      'Oluşturduğun içeriğin (örn. çizimler, beden haritaları, notlar, günlük girişleri) sahipliği sende kalır.';

  @override
  String termsSection4Bullet2(Object companyName) {
    return '$companyName şirketine, yalnızca hizmeti işletmek ve geliştirmek amacıyla içeriğini saklamak/işlemek için sınırlı bir lisans veriyorsun.';
  }

  @override
  String get termsSection4Bullet3 =>
      'Hukuka aykırı, taciz edici veya ihlal eden materyaller yükleyemezsin.';

  @override
  String get termsSection5Title => '5. Kabul Edilebilir Kullanım';

  @override
  String get termsSection5Bullet1 =>
      'Yetkisiz erişime kalkışma, tersine mühendislik yapma, hizmetleri aksatma veya aşırı yükleme girişiminde bulunma.';

  @override
  String get termsSection5Bullet2 =>
      'Uygulamayı başkalarını taciz etmek, tehdit etmek veya istismar etmek için kullanma.';

  @override
  String get termsSection5Bullet3 =>
      'Hesap, kullanım veya güvenlik kısıtlamalarını aşmaya çalışma.';

  @override
  String get termsSection6Title => '6. Veri ve Gizlilik';

  @override
  String get termsSection6Bullet1 =>
      'Uygulama özellikleri için gerekli olan hesap/profil verilerini ve etkinlik verilerini işliyoruz (örn. günlük kontroller, mesajlar, kayıtlı girişler, medya oynatma).';

  @override
  String get termsSection6Bullet2 =>
      'Veriler, uygulama için yapılandırılmış Firebase hizmetleri kullanılarak saklanır.';

  @override
  String get termsSection6Bullet3 =>
      'Gizlilik haklarınız ile saklama/silme ayrıntıları Gizlilik Politikamızda açıklanmıştır.';

  @override
  String termsSection6Bullet4(Object url) {
    return 'Gizlilik Politikası: $url';
  }

  @override
  String get termsSection7Title => '7. Üçüncü Taraf Hizmetler';

  @override
  String get termsSection7Bullet1 =>
      'Kimlik doğrulama, depolama ve veritabanı özellikleri üçüncü taraf sağlayıcılara dayanır (örn. Google/Firebase).';

  @override
  String get termsSection7Bullet2 =>
      'Bu entegrasyonların kullanımı, üçüncü taraf koşullarına da tabi olabilir.';

  @override
  String get termsSection8Title => '8. Fikri Mülkiyet';

  @override
  String termsSection8Bullet1(Object companyName) {
    return 'Tüm uygulama markalaması, tasarımı ve kullanıcıya ait olmayan içerikler $companyName şirketine aittir veya ona lisanslıdır.';
  }

  @override
  String get termsSection8Bullet2 =>
      'İzin almadan uygulama materyallerini kopyalayamaz, dağıtamaz veya ticarileştiremezsin.';

  @override
  String get termsSection9Title => '9. Askıya Alma ve Sonlandırma';

  @override
  String get termsSection9Bullet1 =>
      'İhlaller, kötüye kullanım, güvenlik riskleri veya yasal yükümlülükler nedeniyle hesapları askıya alabilir veya sonlandırabiliriz.';

  @override
  String get termsSection9Bullet2 =>
      'Uygulamayı kullanmayı istediğin zaman bırakabilirsin.';

  @override
  String get termsSection10Title => '10. Garantiler ve Sorumluluk';

  @override
  String get termsSection10Bullet1 =>
      'Hizmet \"olduğu gibi\" ve \"mevcut olduğu gibi\" sunulur.';

  @override
  String termsSection10Bullet2(Object companyName) {
    return 'Yasaların izin verdiği en geniş kapsamda, $companyName zımni garantileri reddeder.';
  }

  @override
  String termsSection10Bullet3(Object companyName) {
    return 'Yasaların izin verdiği en geniş kapsamda, $companyName dolaylı, arızi veya sonuçsal zararlardan sorumlu değildir.';
  }

  @override
  String get termsSection11Title => '11. Bu Koşullardaki Değişiklikler';

  @override
  String get termsSection11Bullet1 =>
      'Bu Koşulları zaman zaman güncelleyebiliriz.';

  @override
  String get termsSection11Bullet2 =>
      'Değişiklikler önemliyse, uygulama içinden veya e-posta yoluyla makul bir bildirim sunarız.';

  @override
  String get termsSection11Bullet3 =>
      'Güncellemelerden sonra kullanmaya devam etmek, güncellenmiş Koşulları kabul ettiğin anlamına gelir.';

  @override
  String get termsSection12Title => '12. Geçerli Hukuk';

  @override
  String termsSection12Bullet1(Object country) {
    return 'Bu Koşullar, kanunlar ihtilafı kurallarına bakılmaksızın $country yasalarına tabidir.';
  }

  @override
  String get termsSection13Title => '13. İletişim';

  @override
  String termsSection13Bullet1(Object email) {
    return 'Destek veya yasal talepler için iletişim: $email';
  }

  @override
  String get termsImportantNote =>
      'Önemli: yayınlamadan önce lütfen hukuk müşavirinin incelemesini onayla.';

  @override
  String get avatarUpdated => 'Avatar güncellendi.';

  @override
  String get avatarUpdateFailed => 'Avatar güncellenemedi.';

  @override
  String get avatarRemoved => 'Avatar kaldırıldı.';

  @override
  String get avatarRemoveFailed => 'Avatar kaldırılamadı.';

  @override
  String get nameUpdated => 'İsim güncellendi.';

  @override
  String get nameUpdateFailed => 'İsim güncellenemedi.';

  @override
  String get editNameTitle => 'İsmi düzenle';

  @override
  String get passwordMustBeAtLeast8 => 'Şifre en az 8 karakter olmalı.';

  @override
  String get passwordRequirementsSummary =>
      '1 büyük harf, 1 rakam ve 1 özel karakter kullan.';

  @override
  String get emailUnchanged => 'E-posta değişmedi.';

  @override
  String get verificationEmailSentNewAddress =>
      'Doğrulama e-postası yeni adrese gönderildi.';

  @override
  String get reauthenticateToUpdateEmail =>
      'E-postayı güncellemek için yeniden kimlik doğrulaması yap';

  @override
  String get reauthenticationFailed => 'Yeniden kimlik doğrulama başarısız.';

  @override
  String get emailUpdateFailed => 'E-posta güncellenemedi.';

  @override
  String get editEmailTitle => 'E-postayı düzenle';

  @override
  String get passwordUpdated => 'Şifre güncellendi.';

  @override
  String get reauthenticateToUpdatePassword =>
      'Şifreyi güncellemek için yeniden kimlik doğrulaması yap';

  @override
  String get passwordUpdateFailed => 'Şifre güncellenemedi.';

  @override
  String get changePasswordTitle => 'Şifreyi değiştir';

  @override
  String get newPasswordLabel => 'Yeni şifre';

  @override
  String get passwordRequirementsSummaryShort =>
      'En az 8 karakter, 1 büyük harf, 1 rakam, 1 özel karakter.';

  @override
  String get takePhotoLabel => 'Fotoğraf çek';

  @override
  String get chooseFromGalleryLabel => 'Galeriden seç';

  @override
  String get chooseAvatarLabel => 'Avatar seç';

  @override
  String get avatarPickerTitle => 'Avatarını seç';

  @override
  String get removePhotoLabel => 'Fotoğrafı kaldır';

  @override
  String get notificationsOffSummary => 'Bildirimler kapalı.';

  @override
  String notificationsDailyAndInactiveSummary(Object hour, Object minute) {
    return 'Her gün $hour:$minute ve 7 günlük etkinlik dışı hatırlatıcılar.';
  }

  @override
  String notificationsDailyOnlySummary(Object hour, Object minute) {
    return 'Günlük hatırlatıcı: $hour:$minute.';
  }

  @override
  String get notificationsInactiveOnlySummary =>
      'Yalnızca 7 günlük etkinlik dışı hatırlatıcılar.';

  @override
  String get dailyReminderTitle => 'Günlük hatırlatıcı';

  @override
  String get dailyReminderSubtitle => 'Her sabah bir bildirim gönder.';

  @override
  String get reminderTimeTitle => 'Hatırlatıcı saati';

  @override
  String get inactiveReminderTitle => 'Etkinlik dışı hatırlatıcı';

  @override
  String get inactiveReminderSubtitle =>
      '7 günden uzun süredir uzaktaysan bir hatırlatıcı gönder.';

  @override
  String get notificationPreferencesSaved => 'Bildirim tercihleri kaydedildi.';

  @override
  String get notificationPreferencesSaveFailed =>
      'Bildirim tercihleri kaydedilemedi.';

  @override
  String get accountSectionTitle => 'Hesap';

  @override
  String get profilePhotoTitle => 'Profil fotoğrafı';

  @override
  String get profilePhotoSubtitle => 'Avatarını ekle veya kaldır.';

  @override
  String get displayNameTitle => 'Görünen ad';

  @override
  String get unknownValueLabel => 'Bilinmiyor';

  @override
  String get passwordUpdateSubtitle => 'Şifreni güncelle.';

  @override
  String get passwordManagedByProviderSubtitle =>
      'Giriş sağlayıcın tarafından yönetiliyor.';

  @override
  String get appSectionTitle => 'Uygulama';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeSystemLabel => 'Sistem';

  @override
  String get themeLightLabel => 'Açık';

  @override
  String get themeDarkLabel => 'Koyu';

  @override
  String get cookieMonsterTitle => 'Kurabiye Canavarı';

  @override
  String get cookieMonsterJoinPrompt => 'Bana katılır mısın?';

  @override
  String get joinLabel => 'Katıl';

  @override
  String get cookieMonsterOutsidePrompt =>
      'Kendini rahat hissettiğin bir yer hayal ettiğinde, bedeninde hangi fiziksel duyumları fark ediyorsun?';

  @override
  String get reflectLabel => 'Düşün';

  @override
  String get experienceFeedbackTitle => 'Bu deneyim senin için nasıldı?';

  @override
  String get experienceFeedbackPositive => 'Olumlu: dans';

  @override
  String get experienceFeedbackNeutral => 'Nötr: meeeehhhhhh';

  @override
  String get experienceFeedbackNegative => 'Olumsuz: düşüş';

  @override
  String get selectBodyAreaFirst => 'Önce bir beden bölgesi seç.';

  @override
  String noClipFound(Object activityKey) {
    return '\"$activityKey\" için klip bulunamadı.';
  }

  @override
  String failedToLoadMonsterClip(Object error) {
    return 'Canavar klibi yüklenemedi: $error';
  }

  @override
  String get colorLabel => 'Renk';

  @override
  String get tapBodyToLogSensation => 'Duyumu kaydetmek için bedene dokun.';

  @override
  String failedToSaveBodyAwarenessWithCode(Object code) {
    return 'Beden farkındalığı kaydedilemedi: $code.';
  }

  @override
  String get failedToSaveBodyAwareness => 'Beden farkındalığı kaydedilemedi.';

  @override
  String get stepSkipped => 'Adım atlandı.';

  @override
  String get bodyAwarenessPrompt =>
      'Bu his bedeninde nerede duruyor gibi geliyor?\nLütfen o noktaya dokun ve duyuma uygun gelen bir renk seç.';

  @override
  String get exerciseInstructionWillYouJoin =>
      'Kısa bir egzersiz için Kurabiye Canavarı\'na katılmak ister misin?';

  @override
  String get exerciseInstructionOutsideTheBody =>
      'Kendini rahat hissettiğin bir yer hayal ettiğinde, bedeninde hangi fiziksel duyumları fark ediyorsun?';

  @override
  String get exerciseInstructionForeheadContact =>
      'Alın Teması:\nAvucunu alnına koy, birkaç saniye tut ve nefesinle birlikte rahatla.';

  @override
  String get exerciseInstructionSlowBreathing =>
      'Gözleri Kapat - Nefes Takibi:\nGözlerini kapat, burnundan yavaşça nefes al ve 4 saniyede ver (5 kez tekrarla).';

  @override
  String get exerciseInstructionWeightOfHead =>
      'Başının Ağırlığını Hisset:\nBaşını nazikçe öne eğ, boyun gerginliğini fark et ve gevşet.';

  @override
  String get exerciseInstructionBreathing478 =>
      '4-7-8 Nefes:\n4 saniye nefes al, 7 saniye tut, 8 saniyede ver (3 döngü).';

  @override
  String get exerciseInstructionAbdominalAwareness =>
      'Karın Farkındalığı:\nElini karnına koy ve her nefesle yükselip alçaldığını hisset.';

  @override
  String get exerciseInstructionHeartCenter =>
      'Kalp Merkezi Açılışı:\nGöğsünü öne çıkar, omuzlarını geri çek ve derin nefes al.';

  @override
  String get exerciseInstructionBallSqueezing =>
      'Top Sıkma:\nAvucunu yavaşça sık ve gevşet (10 tekrar).';

  @override
  String get exerciseInstructionFingerMeditation =>
      'Parmak Meditasyonu:\nBaşparmağınla her parmağına tek tek dokun, her dokunuşta nefes ver.';

  @override
  String get exerciseInstructionHandMassage =>
      'El Masajı:\nBaşparmağınla avucunun ortasına küçük dairelerle masaj yap (her el için 30 saniye).';

  @override
  String get exerciseInstructionShoulderDrop =>
      'Omuz Düşüşü:\nOmuzlarını kulaklarına doğru kaldır, sonra bırak (5 tekrar).';

  @override
  String get exerciseInstructionBackOpening =>
      'Sırt Açılışı:\nElleri arkanda kenetle, göğsünü aç ve derin bir nefes al.';

  @override
  String get exerciseInstructionReleasingBurdens =>
      'Yükleri Bırakma:\nGözlerin kapalı, omuzlarından aşağıya akan sıcak bir ışık hayal et.';

  @override
  String get exerciseInstructionRelaxingFacialMuscles =>
      'Yüz Kaslarını Gevşetme:\nGözlerini kapat, yüz kaslarını sık ve gevşet (3 tekrar).';

  @override
  String get exerciseInstructionJawDrop =>
      'Çene Düşüşü:\nAğzını hafifçe aç, çeneyi 5 saniye gevşet, sonra kapat.';

  @override
  String get exerciseInstructionSmileToYourself =>
      'Kendine Gülümse:\n30 saniye boyunca nazik bir gülümseme tut.';

  @override
  String get exerciseInstructionEftTappingPoints =>
      'EFT Vuruş Noktaları:\nHer noktaya 5-7 kez vur: kaş başı, gözün yanı, gözün altı, burnun altı, çene, köprücük kemiği, kolun altı, başın tepesi.';

  @override
  String get exerciseInstructionRisingOnTiptoes =>
      'Parmak Uçlarında Yükselme:\nNefes verirken topukları kaldır, 3-5 saniye tut, yavaşça indir ve 5-10 kez tekrarla.';

  @override
  String get singleClipUrlMissing => 'Tekli klip URL\'si eksik.';

  @override
  String get exerciseClipsMissing => 'Egzersiz klipleri eksik.';

  @override
  String get videoPlayerInitializationFailed =>
      'Video oynatıcı başlatılamadı. Lütfen uygulamayı tamamen yeniden başlat.';

  @override
  String get failedToPlayOutroClip => 'Çıkış klibi oynatılamadı.';

  @override
  String get finishExerciseLabel => 'Egzersizi bitir';

  @override
  String get startExerciseLabel => 'Egzersize başla';

  @override
  String get feedbackQuestionLabel => 'Egzersizi nasıl buldun?';

  @override
  String get feedbackVeryGood => 'Çok iyi';

  @override
  String get feedbackGood => 'İyi';

  @override
  String get feedbackMeh => 'Eh işte';

  @override
  String get feedbackNotGood => 'İyi değil';

  @override
  String get feedbackAwful => 'Berbat';

  @override
  String get feedbackDoneLabel => 'Bitti';

  @override
  String get careCornerEuNationalPrompt =>
      'For country-specific support and services, please also visit your national bubble.';

  @override
  String get euDisclaimer =>
      'Avrupa Birliği tarafından finanse edilmektedir. İfade edilen görüş ve düşünceler yalnızca yazar(lar)a ait olup Avrupa Birliği\'nin veya Avrupa Eğitim ve Kültür Yürütme Ajansı\'nın (EACEA) görüşlerini yansıtmak zorunda değildir. Avrupa Birliği veya EACEA bunlardan sorumlu tutulamaz.';

  @override
  String get externalLinkWarningTitle => 'Uygulamadan ayrılıyorsun';

  @override
  String get externalLinkWarningMessage =>
      'Harici bir web sitesini açmak üzeresin. Harici sitelerin içeriğinden sorumlu değiliz.';

  @override
  String get externalLinkCancel => 'İptal';

  @override
  String get externalLinkContinue => 'Devam et';

  @override
  String get careCornerNotAvailableMessage => 'Henüz mevcut değil';

  @override
  String get messageAlreadyOpenedToday =>
      'Bugünkü mesajını zaten açtın. Yarın tekrar gel!';

  @override
  String get libraryResourcesTitle => 'Kaynaklar';

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
