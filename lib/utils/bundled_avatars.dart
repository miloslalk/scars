import 'dart:math';

class BundledAvatar {
  const BundledAvatar({required this.label, required this.assetPath});

  final String label;
  final String assetPath;
}

const bundledAvatars = <BundledAvatar>[
  BundledAvatar(
    label: 'Cheerfull',
    assetPath: 'assets/avatars/1_cheerfull.png',
  ),
  BundledAvatar(label: 'Radiant', assetPath: 'assets/avatars/2_radiant.png'),
  BundledAvatar(
    label: 'Compassionate anatomical',
    assetPath: 'assets/avatars/3_compassionate anatomical.png',
  ),
  BundledAvatar(label: 'Free', assetPath: 'assets/avatars/4_free.png'),
  BundledAvatar(label: 'Curious', assetPath: 'assets/avatars/5_curious.png'),
  BundledAvatar(label: 'Nurturer', assetPath: 'assets/avatars/6_nurturer.png'),
  BundledAvatar(label: 'Observer', assetPath: 'assets/avatars/7_observer.png'),
  BundledAvatar(
    label: 'Compassionate',
    assetPath: 'assets/avatars/8_compassionate.png',
  ),
];

String randomBundledAvatarAssetPath([Random? random]) {
  final picker = random ?? Random();
  return bundledAvatars[picker.nextInt(bundledAvatars.length)].assetPath;
}
