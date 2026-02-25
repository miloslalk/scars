import 'package:flutter/material.dart';

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
                  Text(
                    'Terms of Service',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Effective date: $_effectiveDate',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'These Terms govern your use of $_appName. By creating an account or using the app, you agree to these Terms.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  const _TermsSection(
                    title: '1. Eligibility and Accounts',
                    bullets: [
                      'You must provide accurate registration details and keep your credentials secure.',
                      'You are responsible for activity under your account.',
                      'You may not impersonate another person or misuse the platform.',
                      'Users under 16 may use the app only with parent or legal guardian consent, and only where permitted by applicable law.',
                    ],
                  ),
                  const _TermsSection(
                    title: '2. What the App Provides',
                    bullets: [
                      'Mood drawing check-ins, body awareness tools, guided reflection content, messages, and journaling/library features.',
                      'The app supports emotional wellbeing and self-reflection.',
                      'The app is not a crisis service and not a substitute for medical, psychiatric, or emergency care.',
                    ],
                  ),
                  const _TermsSection(
                    title: '3. Health and Safety Disclaimer',
                    bullets: [
                      'No content in the app is medical advice, diagnosis, or treatment.',
                      'If you are in danger or experiencing an emergency, contact local emergency services immediately.',
                      'If an exercise causes discomfort, stop and seek professional support.',
                    ],
                  ),
                  const _TermsSection(
                    title: '4. User Content',
                    bullets: [
                      'You retain ownership of content you create (e.g., drawings, body maps, notes, journal entries).',
                      'You grant $_companyName a limited license to store/process your content only to operate and improve the service.',
                      'You must not upload unlawful, abusive, or infringing material.',
                    ],
                  ),
                  const _TermsSection(
                    title: '5. Acceptable Use',
                    bullets: [
                      'Do not attempt unauthorized access, reverse engineer, disrupt, or overload services.',
                      'Do not use the app to harass, threaten, or exploit others.',
                      'Do not bypass account, usage, or security restrictions.',
                    ],
                  ),
                  const _TermsSection(
                    title: '6. Data and Privacy',
                    bullets: [
                      'We process account/profile data and activity data needed for app features (e.g., daily check-ins, messages, saved entries, media playback).',
                      'Data is stored using Firebase services configured for the app.',
                      'Your privacy rights and retention/deletion details are described in our Privacy Policy.',
                      'Privacy Policy: $_privacyPolicyUrl',
                    ],
                  ),
                  const _TermsSection(
                    title: '7. Third-Party Services',
                    bullets: [
                      'Authentication, storage, and database features rely on third-party providers (e.g., Google/Firebase).',
                      'Use of those integrations may also be subject to third-party terms.',
                    ],
                  ),
                  const _TermsSection(
                    title: '8. Intellectual Property',
                    bullets: [
                      'All app branding, design, and non-user content are owned by $_companyName or licensed to it.',
                      'You may not copy, distribute, or commercialize app materials without permission.',
                    ],
                  ),
                  const _TermsSection(
                    title: '9. Suspension and Termination',
                    bullets: [
                      'We may suspend or terminate accounts for violations, abuse, security risks, or legal obligations.',
                      'You may stop using the app at any time.',
                    ],
                  ),
                  const _TermsSection(
                    title: '10. Warranties and Liability',
                    bullets: [
                      'The service is provided "as is" and "as available".',
                      'To the fullest extent allowed by law, $_companyName disclaims implied warranties.',
                      'To the fullest extent allowed by law, $_companyName is not liable for indirect, incidental, or consequential damages.',
                    ],
                  ),
                  const _TermsSection(
                    title: '11. Changes to These Terms',
                    bullets: [
                      'We may update these Terms from time to time.',
                      'If changes are material, we will provide reasonable notice in-app or by email.',
                      'Continued use after updates means you accept the updated Terms.',
                    ],
                  ),
                  const _TermsSection(
                    title: '12. Governing Law',
                    bullets: [
                      'These Terms are governed by the laws of $_country, without regard to conflict-of-law rules.',
                    ],
                  ),
                  const _TermsSection(
                    title: '13. Contact',
                    bullets: [
                      'For support or legal requests, contact: $_supportEmail',
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Important: please confirm legal counsel review before release.',
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
