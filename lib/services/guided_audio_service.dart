import 'package:firebase_storage/firebase_storage.dart';

class GuidedAudioTrack {
  const GuidedAudioTrack({
    required this.title,
    required this.description,
    required this.fallbackAssetPath,
    this.remoteUrl,
  });

  final String title;
  final String description;
  final String fallbackAssetPath;
  final String? remoteUrl;
}

class GuidedAudioService {
  GuidedAudioService._();

  static final GuidedAudioService instance = GuidedAudioService._();

  Future<GuidedAudioTrack> resolveTrack({
    required String localeCode,
    required String fallbackAssetPath,
    required String defaultTitle,
    required String defaultDescription,
  }) async {
    // Try locale-specific track, then English fallback.
    final url =
        await _resolveUrl(localeCode) ??
        (localeCode == 'en' ? null : await _resolveUrl('en'));

    return GuidedAudioTrack(
      title: defaultTitle,
      description: defaultDescription,
      fallbackAssetPath: fallbackAssetPath,
      remoteUrl: url,
    );
  }

  Future<String?> _resolveUrl(String localeCode) async {
    try {
      return await FirebaseStorage.instance
          .ref('guided-audio/tracks/$localeCode.mp3')
          .getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}
