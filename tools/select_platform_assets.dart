import 'dart:io';

const _commonAssets = [
  'assets/icons/',
  'assets/avatars/',
  'assets/images/',
  'assets/monster_clips/00_colored_moving_background/',
];

const _clipFolders = [
  '00_intro',
  '01_hello',
  '02_loop_animations',
  '03_body_scan',
  '04_guided_meditation',
  '05_location_in_the_body',
  '06_will_you_join',
  '07_outside_the_body',
  '08_forehead_contact',
  '09_slow_breathing',
  '10_weight_of_the_head',
  '11_breathing/with_balloon_timer',
  '11_breathing/without_balloon_timer',
  '12_abdominal_awareness',
  '13_heart_center',
  '14_ball_squeezing',
  '15_finger_meditation',
  '16_hand_massage',
  '17_shoulder_drop',
  '18_back_opening',
  '19_releasing_burden',
  '20_relaxing_facial_muscles',
  '21_jaw_drop',
  '22_smile_to_yourself',
  '23_eft_tapping_points',
  '24_rising_on_tiptoes',
  '25_feedback',
  '26_outro',
];

const _trailingAssets = [
  'assets/music/',
  'assets/data/care_corner/',
  'assets/images/flags/',
  'assets/fonts/',
];

void main(List<String> args) {
  if (args.length != 1 || !const ['android', 'ios'].contains(args.single)) {
    stderr.writeln(
      'Usage: dart tools/select_platform_assets.dart <android|ios>',
    );
    exitCode = 64;
    return;
  }

  final platform = args.single;
  final pubspec = File('pubspec.yaml');
  final source = pubspec.readAsStringSync();
  final start = source.indexOf('  assets:\n');
  final end = source.indexOf('  fonts:\n', start);

  if (start == -1 || end == -1) {
    stderr.writeln('Could not find the flutter assets block in pubspec.yaml.');
    exitCode = 1;
    return;
  }

  final assets = [
    ..._commonAssets,
    for (final folder in _clipFolders)
      'assets/monster_clips/$folder/$platform/',
    ..._trailingAssets,
  ];
  final block = StringBuffer('  assets:\n');
  for (final asset in assets) {
    block.writeln('    - $asset');
  }

  final updated = source.replaceRange(start, end, block.toString());
  if (updated == source) {
    stdout.writeln('pubspec.yaml already uses $platform assets.');
    return;
  }

  pubspec.writeAsStringSync(updated);
  stdout.writeln('pubspec.yaml now uses $platform monster clip assets.');
}
