import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/models/care_corner_data.dart';
import 'package:when_scars_become_art/widgets/app_top_bar.dart';
import 'package:when_scars_become_art/widgets/external_link_warning.dart';

class EducationDetailPage extends StatefulWidget {
  const EducationDetailPage({
    super.key,
    required this.item,
    required this.country,
    required this.countryLocale,
  });

  final EducationItem item;
  final String country;
  final Locale countryLocale;

  @override
  State<EducationDetailPage> createState() => _EducationDetailPageState();
}

class _EducationDetailPageState extends State<EducationDetailPage> {
  static const _purpleDark = Color(0xFF4A3662);
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final snap = await FirebaseDatabase.instance
        .ref('users/${user.uid}/library/resources')
        .orderByChild('title')
        .equalTo(widget.item.title)
        .once(DatabaseEventType.value);
    if (!mounted) return;
    if (snap.snapshot.value != null) {
      final values = snap.snapshot.value as Map;
      final match = values.values.any(
        (v) => v is Map && v['section'] == 'education',
      );
      if (match) setState(() => _saved = true);
    }
  }

  Future<void> _toggleBookmark() async {
    if (_saved) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final ref = FirebaseDatabase.instance
        .ref('users/${user.uid}/library/resources')
        .push();
    await ref.set({
      'title': widget.item.title,
      'section': 'education',
      'country': widget.country,
      if (widget.item.description != null) 'description': widget.item.description,
      if (widget.item.referenceUrl != null) 'referenceUrl': widget.item.referenceUrl,
      'savedAt': DateTime.now().toIso8601String(),
    });
    if (!mounted) return;
    setState(() => _saved = true);
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.savedToResources)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final countryL10n = lookupAppLocalizations(widget.countryLocale);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final breadcrumb =
        '${widget.country} > ${countryL10n.careCornerEducationTitle} > ${widget.item.title}';

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1A1624)
          : const Color(0xFFF5F0FA),
      appBar: const AppTopBar(showUserAction: false),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: _purpleDark,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.white,
                  ),
                  tooltip: l10n.careCornerBackLabel,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    breadcrumb,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _saved ? Icons.bookmark : Icons.bookmark_outline,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: _toggleBookmark,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF2E2940),
                  ),
                ),
                if (widget.item.description != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    widget.item.description!,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
                for (final video in widget.item.videos) ...[
                  const SizedBox(height: 20),
                  if (widget.item.videos.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        video.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF4A3662),
                        ),
                      ),
                    ),
                  _buildVideoWidget(context, video, isDark),
                ],
                if (widget.item.referenceUrl != null) ...[
                  const SizedBox(height: 20),
                  _ReferenceLink(
                    label: widget.item.referenceLabel,
                    url: widget.item.referenceUrl!,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoWidget(BuildContext context, VideoLink video, bool isDark) {
    final videoId = extractYouTubeId(video.url);
    if (videoId != null) {
      return _YouTubeThumbnail(videoId: videoId, videoUrl: video.url);
    }
    return _VideoLinkCard(video: video, isDark: isDark);
  }
}

class _YouTubeThumbnail extends StatelessWidget {
  const _YouTubeThumbnail({required this.videoId, required this.videoUrl});

  final String videoId;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: Colors.black,
                child: const Center(
                  child: Icon(
                    Icons.videocam_off,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
            ),
            Container(color: Colors.black26),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => openExternalLink(context, videoUrl),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoLinkCard extends StatelessWidget {
  const _VideoLinkCard({required this.video, required this.isDark});

  final VideoLink video;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openExternalLink(context, video.url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2236) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white12 : const Color(0xFFD4C4E8),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.play_circle_fill,
              color: isDark ? Colors.white54 : const Color(0xFF6B4F8A),
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 18,
              color: isDark ? Colors.white38 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferenceLink extends StatelessWidget {
  const _ReferenceLink({required this.url, required this.isDark, this.label});

  final String? label;
  final String url;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openExternalLink(context, url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2236) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white12 : const Color(0xFFD4C4E8),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.menu_book,
              color: isDark ? Colors.white54 : const Color(0xFF6B4F8A),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label ?? 'Reference',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 18,
              color: isDark ? Colors.white38 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
