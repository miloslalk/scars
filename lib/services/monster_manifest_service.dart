import 'package:flutter/foundation.dart';

enum MonsterPlaybackType { single, triple }

class MonsterPlaybackPlan {
  const MonsterPlaybackPlan.single({
    required this.activityKey,
    required this.singlePath,
  }) : type = MonsterPlaybackType.single,
       introPath = null,
       loopPath = null,
       outroPath = null;

  const MonsterPlaybackPlan.triple({
    required this.activityKey,
    required this.introPath,
    required this.loopPath,
    required this.outroPath,
  }) : type = MonsterPlaybackType.triple,
       singlePath = null;

  final String activityKey;
  final MonsterPlaybackType type;
  final String? singlePath;
  final String? introPath;
  final String? loopPath;
  final String? outroPath;
}

class MonsterManifestService {
  MonsterManifestService._();

  static final MonsterManifestService instance = MonsterManifestService._();

  static const String _base = 'assets/monster_clips';

  /// Clip definitions: activity key → (type, baseName, [variant subfolder]).
  /// Single clips: {key}/{platform}/{baseName}.ext
  /// Triple clips: {key}/{platform}/1_{baseName}.ext, 2_..., 3_...
  /// Variant clips: {key}/{variant}/{platform}/1_{baseName}.ext, ...
  static const Map<String, _ClipDef> _clips = {
    '01_hello': _ClipDef.single('01_hello', 'hello'),
    '03_body_scan': _ClipDef.single('03_body_scan', 'body_scan'),
    '05_location_in_the_body': _ClipDef.single(
      '05_location_in_the_body',
      'location_in_the_body',
    ),
    '17_shoulder_drop': _ClipDef.single('17_shoulder_drop', 'shoulder_drop'),
    '18_back_opening': _ClipDef.single('18_back_opening', 'back_opening'),
    '23_eft_tapping_points': _ClipDef.single(
      '23_eft_tapping_points',
      'eft_tapping_points',
    ),
    '02_loop_animations': _ClipDef.triple('02_loop_animations', 'loop'),
    '04_guided_meditation': _ClipDef.triple(
      '04_guided_meditation',
      'guided_meditation',
    ),
    '06_will_you_join': _ClipDef.triple('06_will_you_join', 'will_you_join'),
    '07_outside_the_body': _ClipDef.triple(
      '07_outside_the_body',
      'outside_the_body',
    ),
    '08_forehead_contact': _ClipDef.triple(
      '08_forehead_contact',
      'forehead_contact',
    ),
    '09_slow_breathing': _ClipDef.triple('09_slow_breathing', 'slow_breathing'),
    '10_weight_of_the_head': _ClipDef.triple(
      '10_weight_of_the_head',
      'weight_of_the_head',
    ),
    '11_breathing': _ClipDef.variant('11_breathing', 'breathing'),
    '12_abdominal_awareness': _ClipDef.triple(
      '12_abdominal_awareness',
      'abdominal_awareness',
    ),
    '13_heart_center': _ClipDef.triple('13_heart_center', 'heart_center'),
    '14_ball_squeezing': _ClipDef.triple('14_ball_squeezing', 'ball_squeezing'),
    '15_finger_meditation': _ClipDef.triple(
      '15_finger_meditation',
      'finger_meditation',
    ),
    '16_hand_massage': _ClipDef.triple('16_hand_massage', 'hand_massage'),
    '19_releasing_burden': _ClipDef.triple(
      '19_releasing_burden',
      'releasing_burden',
    ),
    '20_relaxing_facial_muscles': _ClipDef.triple(
      '20_relaxing_facial_muscles',
      'relaxing_facial_muscles',
    ),
    '21_jaw_drop': _ClipDef.triple('21_jaw_drop', 'jaw_drop'),
    '22_smile_to_yourself': _ClipDef.triple(
      '22_smile_to_yourself',
      'smile_to_yourself',
    ),
    '24_rising_on_tiptoes': _ClipDef.triple(
      '24_rising_on_tiptoes',
      'rising_on_tiptoes',
    ),
  };

  static const Map<String, List<String>> _variants = {
    '11_breathing': ['with_balloon_timer', 'without_balloon_timer'],
  };

  /// All defined activity keys, so tests can validate the whole catalog.
  static List<String> get activityKeys => List.unmodifiable(_clips.keys);

  /// Variants defined for [activityKey] (empty for non-variant clips).
  static List<String> variantsFor(String activityKey) =>
      List.unmodifiable(_variants[activityKey] ?? const []);

  MonsterPlaybackPlan? resolvePlaybackPlan(
    String activityKey, {
    required TargetPlatform platform,
    String? variant,
  }) {
    final def = _clips[activityKey];
    if (def == null) return null;

    final platformDir = platform == TargetPlatform.iOS ? 'ios' : 'android';
    final ext = platform == TargetPlatform.iOS ? 'mov' : 'webm';

    if (def.type == 'single') {
      return MonsterPlaybackPlan.single(
        activityKey: activityKey,
        singlePath: '$_base/${def.folder}/$platformDir/${def.baseName}.$ext',
      );
    }

    if (def.type == 'triple') {
      return MonsterPlaybackPlan.triple(
        activityKey: activityKey,
        introPath: '$_base/${def.folder}/$platformDir/1_${def.baseName}.$ext',
        loopPath: '$_base/${def.folder}/$platformDir/2_${def.baseName}.$ext',
        outroPath: '$_base/${def.folder}/$platformDir/3_${def.baseName}.$ext',
      );
    }

    if (def.type == 'variant') {
      final variants = _variants[activityKey];
      if (variants == null || variants.isEmpty) return null;
      final selectedVariant =
          variant ??
          (variants.contains('with_balloon_timer')
              ? 'with_balloon_timer'
              : variants.first);
      return MonsterPlaybackPlan.triple(
        activityKey: activityKey,
        introPath:
            '$_base/${def.folder}/$selectedVariant/$platformDir/1_${def.baseName}.$ext',
        loopPath:
            '$_base/${def.folder}/$selectedVariant/$platformDir/2_${def.baseName}.$ext',
        outroPath:
            '$_base/${def.folder}/$selectedVariant/$platformDir/3_${def.baseName}.$ext',
      );
    }

    return null;
  }

  static List<String> mapRegionToActivities(String region) {
    switch (region) {
      case 'head':
      case 'neck':
        return [
          '08_forehead_contact',
          '09_slow_breathing',
          '10_weight_of_the_head',
          '20_relaxing_facial_muscles',
          '21_jaw_drop',
          '22_smile_to_yourself',
        ];
      case 'chest':
        return ['13_heart_center'];
      case 'torso':
        return ['11_breathing', '12_abdominal_awareness'];
      case 'back':
        return ['18_back_opening', '19_releasing_burden'];
      case 'shoulders':
        return ['17_shoulder_drop'];
      case 'arms':
        return ['23_eft_tapping_points'];
      case 'hands':
        return ['14_ball_squeezing', '15_finger_meditation', '16_hand_massage'];
      case 'legs':
      case 'feet':
        return ['24_rising_on_tiptoes'];
      case 'outside':
        return ['07_outside_the_body'];
      default:
        return ['06_will_you_join'];
    }
  }

  static String mapRegionToActivity(String region) {
    final activities = mapRegionToActivities(region);
    return (activities..shuffle()).first;
  }
}

class _ClipDef {
  const _ClipDef.single(this.folder, this.baseName) : type = 'single';
  const _ClipDef.triple(this.folder, this.baseName) : type = 'triple';
  const _ClipDef.variant(this.folder, this.baseName) : type = 'variant';

  final String type;
  final String folder;
  final String baseName;
}
