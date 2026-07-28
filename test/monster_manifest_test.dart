import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:when_scars_become_art/services/monster_manifest_service.dart';

void main() {
  group('MonsterManifestService', () {
    test('every activity resolves to clip files that exist on disk', () {
      for (final key in MonsterManifestService.activityKeys) {
        for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
          final variants = MonsterManifestService.variantsFor(key);
          // null variant = the service's default choice.
          for (final variant in [null, ...variants]) {
            final plan = MonsterManifestService.instance.resolvePlaybackPlan(
              key,
              platform: platform,
              variant: variant,
            );
            expect(
              plan,
              isNotNull,
              reason: '$key ($platform, variant: $variant) must resolve',
            );
            final paths = [
              plan!.singlePath,
              plan.introPath,
              plan.loopPath,
              plan.outroPath,
            ].whereType<String>().toList();
            expect(paths, isNotEmpty);
            for (final path in paths) {
              expect(
                File(path).existsSync(),
                isTrue,
                reason: 'missing clip file: $path',
              );
            }
          }
        }
      }
    });

    test('region mapping only returns known activities', () {
      const regions = [
        'head',
        'neck',
        'chest',
        'torso',
        'back',
        'shoulders',
        'arms',
        'hands',
        'legs',
        'feet',
        'outside',
        'anything-else',
      ];
      for (final region in regions) {
        final activities = MonsterManifestService.mapRegionToActivities(region);
        expect(activities, isNotEmpty, reason: 'no activities for $region');
        for (final activity in activities) {
          expect(
            MonsterManifestService.activityKeys,
            contains(activity),
            reason: '$region maps to unknown activity $activity',
          );
        }
      }
    });
  });
}
