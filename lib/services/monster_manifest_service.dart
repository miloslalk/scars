import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
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

  static const String _manifestStoragePath = 'cookie-monster/v1/manifest.json';
  Map<String, dynamic>? _cachedManifest;

  Future<Map<String, dynamic>> loadManifest({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedManifest != null) {
      return _cachedManifest!;
    }
    final bytes = await FirebaseStorage.instance
        .ref(_manifestStoragePath)
        .getData(1024 * 1024);
    if (bytes == null || bytes.isEmpty) {
      throw StateError('Monster manifest is missing or empty.');
    }
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map) {
      throw StateError('Monster manifest has invalid JSON root.');
    }
    _cachedManifest = Map<String, dynamic>.from(decoded);
    return _cachedManifest!;
  }

  Future<String?> resolveSingleClipPath(
    String clipKey, {
    required TargetPlatform platform,
    String? variant,
  }) async {
    final manifest = await loadManifest();
    final clips = manifest['clips'];
    if (clips is! Map) return null;
    final clip = clips[clipKey];
    if (clip is! Map) return null;

    final platformKey = platform == TargetPlatform.iOS ? 'ios' : 'android';
    final type = clip['type'];

    if (type == 'single') {
      final path = clip[platformKey];
      return path is String ? path : null;
    }

    if (type == 'triple') {
      final platformNode = clip[platformKey];
      if (platformNode is! Map) return null;
      final path = platformNode['intro'];
      return path is String ? path : null;
    }

    if (type == 'variant') {
      final variants = clip['variants'];
      if (variants is! Map) return null;
      final selectedVariant =
          variant ??
          (variants.containsKey('with_balloon_timer')
              ? 'with_balloon_timer'
              : variants.keys.firstOrNull?.toString());
      if (selectedVariant == null) return null;
      final variantNode = variants[selectedVariant];
      if (variantNode is! Map) return null;
      final variantType = variantNode['type'];
      if (variantType == 'triple') {
        final platformNode = variantNode[platformKey];
        if (platformNode is! Map) return null;
        final path = platformNode['intro'];
        return path is String ? path : null;
      }
    }

    return null;
  }

  Future<MonsterPlaybackPlan?> resolvePlaybackPlan(
    String activityKey, {
    required TargetPlatform platform,
    String? variant,
  }) async {
    final manifest = await loadManifest();
    final clips = manifest['clips'];
    if (clips is! Map) return null;
    final clip = clips[activityKey];
    if (clip is! Map) return null;

    final platformKey = platform == TargetPlatform.iOS ? 'ios' : 'android';
    final type = clip['type'];

    if (type == 'single') {
      final path = clip[platformKey];
      if (path is! String || path.isEmpty) return null;
      return MonsterPlaybackPlan.single(
        activityKey: activityKey,
        singlePath: path,
      );
    }

    if (type == 'triple') {
      return _triplePlanForNode(
        activityKey: activityKey,
        node: clip,
        platformKey: platformKey,
      );
    }

    if (type == 'variant') {
      final variants = clip['variants'];
      if (variants is! Map || variants.isEmpty) return null;
      final selectedVariant =
          variant ??
          (variants.containsKey('with_balloon_timer')
              ? 'with_balloon_timer'
              : variants.keys.first.toString());
      final variantNode = variants[selectedVariant];
      if (variantNode is! Map) return null;
      final variantType = variantNode['type'];
      if (variantType == 'triple') {
        return _triplePlanForNode(
          activityKey: activityKey,
          node: variantNode,
          platformKey: platformKey,
        );
      }
    }

    return null;
  }

  Future<String> downloadUrlForStoragePath(String storagePath) async {
    return FirebaseStorage.instance.ref(storagePath).getDownloadURL();
  }

  MonsterPlaybackPlan? _triplePlanForNode({
    required String activityKey,
    required Map node,
    required String platformKey,
  }) {
    final platformNode = node[platformKey];
    if (platformNode is! Map) return null;
    final intro = platformNode['intro'];
    final loop = platformNode['loop'];
    final outro = platformNode['outro'];
    if (intro is! String || loop is! String || outro is! String) return null;
    if (intro.isEmpty || loop.isEmpty || outro.isEmpty) return null;
    return MonsterPlaybackPlan.triple(
      activityKey: activityKey,
      introPath: intro,
      loopPath: loop,
      outroPath: outro,
    );
  }

  static String mapRegionToActivity(String region) {
    switch (region) {
      case 'head':
      case 'neck':
        return '08_forehead_contact';
      case 'torso':
        return '12_abdominal_awareness';
      case 'back':
      case 'shoulders':
        return '17_shoulder_drop';
      case 'arms':
      case 'hands':
        return '16_hand_massage';
      case 'legs':
      case 'feet':
        return '24_rising_on_tiptoes';
      case 'outside':
        return '07_outside_the_body';
      default:
        return '06_will_you_join';
    }
  }
}
