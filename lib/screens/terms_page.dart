import 'package:flutter/material.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';

import '../widgets/app_top_bar.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  static const _effectiveDate = 'February 21, 2026';
  static const _appName = 'When Scars (!) Become Art';
  static const _companyName = 'Amaro Foro e.V.';
  static const _supportEmail = 'info@amarodrom.de';
  static const _country = 'Germany';
  static const _privacyPolicyUrl =
      'https://whenscarsbecomeart.eu/privacy-policy-mobile/';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppTopBar(showUserAction: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.termsTitle, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    l10n.termsEffectiveDate(_effectiveDate),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.termsIntro(_appName),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  _TermsSection(
                    title: l10n.termsSection1Title,
                    bullets: [
                      l10n.termsSection1Bullet1,
                      l10n.termsSection1Bullet2,
                      l10n.termsSection1Bullet3,
                      l10n.termsSection1Bullet4,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection2Title,
                    bullets: [
                      l10n.termsSection2Bullet1,
                      l10n.termsSection2Bullet2,
                      l10n.termsSection2Bullet3,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection3Title,
                    bullets: [
                      l10n.termsSection3Bullet1,
                      l10n.termsSection3Bullet2,
                      l10n.termsSection3Bullet3,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection4Title,
                    bullets: [
                      l10n.termsSection4Bullet1,
                      l10n.termsSection4Bullet2(_companyName),
                      l10n.termsSection4Bullet3,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection5Title,
                    bullets: [
                      l10n.termsSection5Bullet1,
                      l10n.termsSection5Bullet2,
                      l10n.termsSection5Bullet3,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection6Title,
                    bullets: [
                      l10n.termsSection6Bullet1,
                      l10n.termsSection6Bullet2,
                      l10n.termsSection6Bullet3,
                      l10n.termsSection6Bullet4(_privacyPolicyUrl),
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection7Title,
                    bullets: [
                      l10n.termsSection7Bullet1,
                      l10n.termsSection7Bullet2,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection8Title,
                    bullets: [
                      l10n.termsSection8Bullet1(_companyName),
                      l10n.termsSection8Bullet2,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection9Title,
                    bullets: [
                      l10n.termsSection9Bullet1,
                      l10n.termsSection9Bullet2,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection10Title,
                    bullets: [
                      l10n.termsSection10Bullet1,
                      l10n.termsSection10Bullet2(_companyName),
                      l10n.termsSection10Bullet3(_companyName),
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection11Title,
                    bullets: [
                      l10n.termsSection11Bullet1,
                      l10n.termsSection11Bullet2,
                      l10n.termsSection11Bullet3,
                    ],
                  ),
                  _TermsSection(
                    title: l10n.termsSection12Title,
                    bullets: [l10n.termsSection12Bullet1(_country)],
                  ),
                  _TermsSection(
                    title: l10n.termsSection13Title,
                    bullets: [l10n.termsSection13Bullet1(_supportEmail)],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.termsImportantNote,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({required this.title, required this.bullets});

  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Text('• '),
                      ),
                      Expanded(child: Text(bullet)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
