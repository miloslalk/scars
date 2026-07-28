import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/models/care_corner_data.dart';
import 'package:when_scars_become_art/widgets/app_top_bar.dart';
import 'package:when_scars_become_art/widgets/external_link_warning.dart';

class OrganizationListPage extends StatelessWidget {
  const OrganizationListPage({
    super.key,
    required this.category,
    required this.country,
    required this.countryLocale,
  });

  final SupportCategory category;
  final String country;
  final Locale countryLocale;

  static const _purpleDark = Color(0xFF4A3662);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final countryL10n = lookupAppLocalizations(countryLocale);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final breadcrumb =
        '$country > ${countryL10n.careCornerSupportTitle} > ${category.title}';

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1A1624)
          : const Color(0xFFF5F0FA),
      appBar: const AppTopBar(showUserAction: false),
      body: Column(
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
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: category.organizations.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _OrganizationCard(
                  org: category.organizations[index],
                  isDark: isDark,
                  countryL10n: countryL10n,
                  country: country,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganizationCard extends StatefulWidget {
  const _OrganizationCard({
    required this.org,
    required this.isDark,
    required this.countryL10n,
    required this.country,
  });

  final Organization org;
  final bool isDark;
  final AppLocalizations countryL10n;
  final String country;

  @override
  State<_OrganizationCard> createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<_OrganizationCard> {
  bool _saved = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final snap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/library/resources')
          .orderByChild('title')
          .equalTo(widget.org.name)
          .once(DatabaseEventType.value);
      if (!mounted) return;
      if (snap.snapshot.value != null) {
        final values = snap.snapshot.value as Map;
        final match = values.values.any(
          (v) => v is Map && v['section'] == 'support',
        );
        if (match) setState(() => _saved = true);
      }
    } catch (_) {
      // Bookmark state stays unknown; cosmetic only.
    }
  }

  Future<void> _toggleBookmark() async {
    // _saving closes the double-tap window between the guard and the
    // awaited write; without it two quick taps create duplicate entries.
    if (_saved || _saving) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    _saving = true;
    try {
      final ref = FirebaseDatabase.instance
          .ref('users/${user.uid}/library/resources')
          .push();
      await ref.set({
        'title': widget.org.name,
        'section': 'support',
        'country': widget.country,
        'description': widget.org.description,
        if (widget.org.phones.isNotEmpty) 'phones': widget.org.phones,
        if (widget.org.email != null) 'email': widget.org.email,
        if (widget.org.website != null) 'website': widget.org.website,
        'isFree': widget.org.isFree,
        'savedAt': DateTime.now().toIso8601String(),
      });
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.genericSaveFailed)));
      return;
    } finally {
      _saving = false;
    }
    if (!mounted) return;
    setState(() => _saved = true);
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.savedToResources)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.countryL10n;
    final isDark = widget.isDark;
    final org = widget.org;
    final cardColor = isDark
        ? const Color(0xFF3D2E55)
        : const Color(0xFFD4C4E8);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  org.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isDark ? Colors.white : const Color(0xFF2E2940),
                  ),
                ),
              ),
              if (org.isFree)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.15)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l10n.careCornerFreeBadge,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: isDark ? Colors.white : const Color(0xFF4A3662),
                    ),
                  ),
                ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: _toggleBookmark,
                child: Icon(
                  _saved ? Icons.bookmark : Icons.bookmark_outline,
                  size: 22,
                  color: isDark ? Colors.white70 : const Color(0xFF4A3662),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            org.description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (org.phones.isNotEmpty)
                _ActionButton(
                  icon: Icons.phone,
                  label: l10n.careCornerActionCall,
                  isDark: isDark,
                  onTap: () {
                    final phone = org.phones.first.replaceAll(
                      RegExp(r'[\s\-()]'),
                      '',
                    );
                    launchUrl(
                      Uri.parse('tel:$phone'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              if (org.email != null)
                _ActionButton(
                  icon: Icons.email,
                  label: l10n.careCornerActionEmail,
                  isDark: isDark,
                  onTap: () => launchUrl(
                    Uri.parse('mailto:${org.email}'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              if (org.website != null)
                _ActionButton(
                  icon: Icons.language,
                  label: l10n.careCornerActionVisitWebsite,
                  isDark: isDark,
                  onTap: () => openExternalLink(context, org.website!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF2A2236) : Colors.white;

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isDark ? Colors.white70 : const Color(0xFF6B4F8A),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : const Color(0xFF4A3662),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
