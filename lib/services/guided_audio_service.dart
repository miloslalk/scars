import 'package:firebase_database/firebase_database.dart';

class GuidedAudioTrack {
  const GuidedAudioTrack({
    required this.title,
    required this.description,
    required this.fallbackAssetPath,
    this.storagePath,
  });

  final String title;
  final String description;
  final String fallbackAssetPath;
  final String? storagePath;
}

class GuidedAudioService {
  GuidedAudioService._();

  static final GuidedAudioService instance = GuidedAudioService._();

  Future<GuidedAudioTrack> resolveTrack({
    required String localeCode,
    required String fallbackAssetPath,
  }) async {
    final fromLocale = await _readTrackMap(localeCode);
    final fromEnglish = localeCode == 'en' ? null : await _readTrackMap('en');
    final map = fromLocale ?? fromEnglish;
    if (map == null) {
      return _defaultTrack(fallbackAssetPath);
    }

    final enabled = map['enabled'];
    if (enabled is bool && !enabled) {
      return _defaultTrack(fallbackAssetPath);
    }

    final title = (map['title'] as String?)?.trim();
    final description = (map['description'] as String?)?.trim();
    final storagePath = (map['storagePath'] as String?)?.trim();
    final fallback = (map['fallbackAssetPath'] as String?)?.trim();

    return GuidedAudioTrack(
      title: (title == null || title.isEmpty) ? 'Guided Meditation' : title,
      description: (description == null || description.isEmpty)
          ? 'Take a moment to breathe and listen.'
          : description,
      fallbackAssetPath: (fallback == null || fallback.isEmpty)
          ? fallbackAssetPath
          : fallback,
      storagePath: (storagePath == null || storagePath.isEmpty)
          ? null
          : storagePath,
    );
  }

  Future<Map<String, dynamic>?> _readTrackMap(String localeCode) async {
    try {
      final snapshot = await FirebaseDatabase.instance
          .ref('guided_audio/tracks/$localeCode')
          .get();
      if (!snapshot.exists || snapshot.value is! Map) return null;
      return Map<String, dynamic>.from(snapshot.value as Map);
    } catch (_) {
      return null;
    }
  }

  GuidedAudioTrack _defaultTrack(String fallbackAssetPath) {
    return GuidedAudioTrack(
      title: 'Guided Meditation',
      description: 'Take a moment to breathe and listen.',
      fallbackAssetPath: fallbackAssetPath,
      storagePath: null,
    );
  }
}
