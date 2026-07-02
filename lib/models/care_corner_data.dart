import 'package:flutter/material.dart';

class CareCornerCountryData {
  const CareCornerCountryData({
    this.isRedirectOnly = false,
    this.wellbeing,
    this.support,
    this.education,
  });

  final bool isRedirectOnly;
  final CareCornerWellbeing? wellbeing;
  final CareCornerSupport? support;
  final CareCornerEducation? education;

  factory CareCornerCountryData.fromJson(Map<String, dynamic> json) {
    return CareCornerCountryData(
      isRedirectOnly: json['isRedirectOnly'] as bool? ?? false,
      wellbeing: json['wellbeing'] != null
          ? CareCornerWellbeing.fromJson(
              json['wellbeing'] as Map<String, dynamic>,
            )
          : null,
      support: json['support'] != null
          ? CareCornerSupport.fromJson(json['support'] as Map<String, dynamic>)
          : null,
      education: json['education'] != null
          ? CareCornerEducation.fromJson(
              json['education'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class CareCornerWellbeing {
  const CareCornerWellbeing({
    required this.items,
    this.furtherReading = const [],
  });

  final List<WellbeingItem> items;
  final List<FurtherReadingItem> furtherReading;

  factory CareCornerWellbeing.fromJson(Map<String, dynamic> json) {
    return CareCornerWellbeing(
      items: (json['items'] as List<dynamic>)
          .map((e) => WellbeingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      furtherReading:
          (json['furtherReading'] as List<dynamic>?)
              ?.map(
                (e) => FurtherReadingItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}

class WellbeingItem {
  const WellbeingItem({
    required this.title,
    this.description,
    this.videoUrl,
    this.videos = const [],
    this.referenceUrl,
    this.referenceLabel,
  });

  final String title;
  final String? description;
  final String? videoUrl;
  final List<VideoLink> videos;
  final String? referenceUrl;
  final String? referenceLabel;

  factory WellbeingItem.fromJson(Map<String, dynamic> json) {
    final videoUrl = json['videoUrl'] as String?;
    final videosList =
        (json['videos'] as List<dynamic>?)
            ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [];

    return WellbeingItem(
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: videoUrl,
      videos: videosList,
      referenceUrl: json['referenceUrl'] as String?,
      referenceLabel: json['referenceLabel'] as String?,
    );
  }
}

class CareCornerSupport {
  const CareCornerSupport({required this.categories});

  final List<SupportCategory> categories;

  factory CareCornerSupport.fromJson(Map<String, dynamic> json) {
    return CareCornerSupport(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => SupportCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SupportCategory {
  const SupportCategory({
    required this.title,
    required this.iconName,
    required this.organizations,
  });

  final String title;
  final String iconName;
  final List<Organization> organizations;

  IconData get icon => _iconMap[iconName] ?? Icons.help_outline;

  factory SupportCategory.fromJson(Map<String, dynamic> json) {
    return SupportCategory(
      title: json['title'] as String,
      iconName: json['icon'] as String,
      organizations: (json['organizations'] as List<dynamic>)
          .map((e) => Organization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Organization {
  const Organization({
    required this.name,
    required this.description,
    this.website,
    this.phones = const [],
    this.email,
    this.isFree = false,
  });

  final String name;
  final String description;
  final String? website;
  final List<String> phones;
  final String? email;
  final bool isFree;

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'] as String,
      description: json['description'] as String,
      website: json['website'] as String?,
      phones:
          (json['phones'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      email: json['email'] as String?,
      isFree: json['isFree'] as bool? ?? false,
    );
  }
}

class CareCornerEducation {
  const CareCornerEducation({
    required this.items,
    this.furtherReading = const [],
  });

  final List<EducationItem> items;
  final List<FurtherReadingItem> furtherReading;

  factory CareCornerEducation.fromJson(Map<String, dynamic> json) {
    return CareCornerEducation(
      items: (json['items'] as List<dynamic>)
          .map((e) => EducationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      furtherReading:
          (json['furtherReading'] as List<dynamic>?)
              ?.map(
                (e) => FurtherReadingItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}

class EducationItem {
  const EducationItem({
    required this.title,
    this.description,
    this.videos = const [],
    this.referenceUrl,
    this.referenceLabel,
  });

  final String title;
  final String? description;
  final List<VideoLink> videos;
  final String? referenceUrl;
  final String? referenceLabel;

  factory EducationItem.fromJson(Map<String, dynamic> json) {
    return EducationItem(
      title: json['title'] as String,
      description: json['description'] as String?,
      videos:
          (json['videos'] as List<dynamic>?)
              ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      referenceUrl: json['referenceUrl'] as String?,
      referenceLabel: json['referenceLabel'] as String?,
    );
  }
}

class VideoLink {
  const VideoLink({required this.title, required this.url});

  final String title;
  final String url;

  factory VideoLink.fromJson(Map<String, dynamic> json) {
    return VideoLink(
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}

class FurtherReadingItem {
  const FurtherReadingItem({required this.title, this.url});

  final String title;
  final String? url;

  factory FurtherReadingItem.fromJson(Map<String, dynamic> json) {
    return FurtherReadingItem(
      title: json['title'] as String,
      url: json['url'] as String?,
    );
  }
}

/// Extracts a YouTube video ID from various URL formats.
String? extractYouTubeId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;

  // youtube.com/watch?v=ID
  if (uri.host.contains('youtube.com') && uri.pathSegments.contains('watch')) {
    return uri.queryParameters['v'];
  }
  // youtube.com/shorts/ID
  if (uri.host.contains('youtube.com') && uri.pathSegments.contains('shorts')) {
    final idx = uri.pathSegments.indexOf('shorts');
    if (idx + 1 < uri.pathSegments.length) {
      return uri.pathSegments[idx + 1];
    }
  }
  // youtu.be/ID
  if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.first;
  }
  return null;
}

const Map<String, IconData> _iconMap = {
  'shield': Icons.shield,
  'emergency': Icons.emergency,
  'house': Icons.house,
  'groups': Icons.groups,
  'gavel': Icons.gavel,
  'local_hospital': Icons.local_hospital,
  'block': Icons.block,
  'pan_tool': Icons.pan_tool,
  'self_improvement': Icons.self_improvement,
  'air': Icons.air,
  'music_note': Icons.music_note,
  'edit_note': Icons.edit_note,
  'palette': Icons.palette,
  'spa': Icons.spa,
  'do_not_disturb': Icons.do_not_disturb,
  'report': Icons.report,
  'no_accounts': Icons.no_accounts,
  'balance': Icons.balance,
  'phone_in_talk': Icons.phone_in_talk,
  'people': Icons.people,
  'favorite': Icons.favorite,
  'psychology': Icons.psychology,
  'health_and_safety': Icons.health_and_safety,
  'diversity_3': Icons.diversity_3,
  'support': Icons.support,
  'volunteer_activism': Icons.volunteer_activism,
  'family_restroom': Icons.family_restroom,
  'elderly': Icons.elderly,
  'child_care': Icons.child_care,
  'accessibility': Icons.accessibility,
  'public': Icons.public,
  'policy': Icons.policy,
  'security': Icons.security,
  'transgender': Icons.transgender,
  'escalator_warning': Icons.escalator_warning,
  'record_voice_over': Icons.record_voice_over,
  'medical_services': Icons.medical_services,
  'handshake': Icons.handshake,
};
