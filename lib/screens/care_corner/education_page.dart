import 'package:flutter/material.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/models/care_corner_data.dart';
import 'package:when_scars_become_art/screens/care_corner/education_detail_page.dart';
import 'package:when_scars_become_art/widgets/app_top_bar.dart';
import 'package:when_scars_become_art/widgets/external_link_warning.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({
    super.key,
    required this.education,
    required this.country,
    required this.countryLocale,
  });

  final CareCornerEducation education;
  final String country;
  final Locale countryLocale;

  static const _purpleDark = Color(0xFF4A3662);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final countryL10n = lookupAppLocalizations(countryLocale);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final breadcrumb =
        '${country.toUpperCase()} > ${countryL10n.careCornerEducationTitle.toUpperCase()}';

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
                  tooltip: l10n.careCornerBackToHubLabel,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    breadcrumb,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: education.items.length,
                  itemBuilder: (context, index) {
                    final item = education.items[index];
                    return _EducationCard(
                      item: item,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EducationDetailPage(
                            item: item,
                            country: country,
                            countryLocale: countryLocale,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (education.furtherReading.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _FurtherReadingSection(
                    items: education.furtherReading,
                    isDark: isDark,
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.careCornerResourceNotice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.item, required this.onTap});

  final EducationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF3D2E55)
        : const Color(0xFF6B4F8A);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.videos.isNotEmpty)
                const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white70,
                  size: 18,
                ),
              if (item.videos.isNotEmpty) const SizedBox(height: 4),
              Text(
                item.title.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FurtherReadingSection extends StatelessWidget {
  const _FurtherReadingSection({required this.items, required this.isDark});

  final List<FurtherReadingItem> items;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2236) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFD4C4E8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              l10n.careCornerFurtherReadingTitle.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.5,
                color: isDark ? Colors.white : const Color(0xFF4A3662),
              ),
            ),
          ),
          ...items.map(
            (item) => Column(
              children: [
                Divider(
                  height: 1,
                  color: isDark ? Colors.white12 : const Color(0xFFE8DDF0),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    item.url != null ? Icons.open_in_new : Icons.chevron_right,
                    color: isDark ? Colors.white38 : Colors.grey.shade400,
                  ),
                  onTap: item.url != null
                      ? () => openExternalLink(context, item.url!)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
