import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';

Future<void> openExternalLink(
  BuildContext context,
  String url, {
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  final l10n = AppLocalizations.of(context)!;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.externalLinkWarningTitle),
      content: Text(l10n.externalLinkWarningMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.externalLinkCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.externalLinkContinue),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

  final uri = Uri.tryParse(url);
  var launched = false;
  if (uri != null) {
    try {
      launched = await launchUrl(uri, mode: mode);
    } catch (_) {
      launched = false;
    }
  }
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.genericLoadFailed)));
  }
}
