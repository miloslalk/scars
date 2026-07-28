import 'dart:io';
// import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'package:when_scars_become_art/services/monster_manifest_service.dart';
import 'package:when_scars_become_art/services/notification_service.dart';
import 'package:when_scars_become_art/utils/bundled_avatars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:when_scars_become_art/utils/safe_key.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/external_link_warning.dart';
import 'care_corner_page.dart';
import 'landing_page.dart';
import 'music_player_page.dart';

part 'home/home_content.dart';
part 'home/home_drawing.dart';
part 'home/home_messages.dart';
part 'home/home_misc.dart';
part 'home/home_my_space.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.username,
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final String username;
  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Stream<DatabaseEvent>? _profileStream;
  bool _isBackfillingDefaultAvatar = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _profileStream = FirebaseDatabase.instance
          .ref('users/${user.uid}')
          .onValue;
    }
  }

  @override
  void dispose() {
    _profileStream = null;
    super.dispose();
  }

  List<Widget> _buildPages(String displayName) {
    return <Widget>[
      _HomeContent(displayName: displayName),
      _MySpaceContent(),
      _MessagesContent(),
      const CareCornerPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      // Must happen while still authenticated, or the rules reject it.
      await NotificationService.instance.onLogout(uid);
    }
    await FirebaseAuth.instance.signOut();
    // Reset per-account presentation so the next account on this device
    // doesn't inherit the previous one's language/theme.
    widget.themeModeNotifier.value = ThemeMode.system;
    widget.localeNotifier.value = null;
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(
          localeNotifier: widget.localeNotifier,
          supportedLocales: widget.supportedLocales,
          themeModeNotifier: widget.themeModeNotifier,
        ),
      ),
      (route) => false,
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          localeNotifier: widget.localeNotifier,
          supportedLocales: widget.supportedLocales,
          themeModeNotifier: widget.themeModeNotifier,
        ),
      ),
    );
  }

  bool _hasProfileImageValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  Future<void> _maybeBackfillDefaultAvatar({
    required String? avatarUrl,
    required String? avatarAssetPath,
    required bool avatarDefaultDismissed,
  }) async {
    if (_isBackfillingDefaultAvatar || avatarDefaultDismissed) return;
    if (_hasProfileImageValue(avatarUrl) ||
        _hasProfileImageValue(avatarAssetPath)) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _isBackfillingDefaultAvatar = true;
    try {
      final userRef = FirebaseDatabase.instance.ref('users/${user.uid}');
      final snap = await userRef.get();
      final value = snap.value;
      String? latestAvatarUrl;
      String? latestAvatarAssetPath;
      var latestAvatarDefaultDismissed = false;
      if (value is Map) {
        final data = Map<String, dynamic>.from(value);
        final avatarValue = data['avatarUrl'];
        final avatarAssetValue = data['avatarAssetPath'];
        final dismissedValue = data['avatarDefaultDismissed'];
        latestAvatarUrl = avatarValue is String ? avatarValue : null;
        latestAvatarAssetPath = avatarAssetValue is String
            ? avatarAssetValue
            : null;
        latestAvatarDefaultDismissed = dismissedValue is bool && dismissedValue;
      }
      if (latestAvatarDefaultDismissed ||
          _hasProfileImageValue(latestAvatarUrl) ||
          _hasProfileImageValue(latestAvatarAssetPath)) {
        return;
      }
      await userRef.update({'avatarAssetPath': randomBundledAvatarAssetPath()});
    } catch (_) {
      // Keep the initial fallback if the best-effort default write fails.
    } finally {
      _isBackfillingDefaultAvatar = false;
    }
  }

  Widget _buildScaffold({
    required String displayName,
    String? avatarUrl,
    String? avatarAssetPath,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final initial = displayName.trim().isNotEmpty
        ? displayName.trim().substring(0, 1).toUpperCase()
        : null;
    final pages = _buildPages(displayName);
    final safeSelectedIndex = _selectedIndex.clamp(0, pages.length - 1);
    final navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: l10n.homeLabel),
      BottomNavigationBarItem(
        icon: const Icon(Icons.lock),
        label: l10n.mySpaceLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.emoji_emotions),
        label: l10n.messagesLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite_outline),
        label: l10n.careCornerTabLabel,
      ),
    ];

    return Scaffold(
      appBar: AppTopBar(
        userInitial: initial,
        userName: displayName,
        userAvatarAssetPath: avatarAssetPath,
        userAvatarUrl: avatarUrl,
        onSettingsTap: _openSettings,
        onLogoutTap: _logout,
        actions: const [],
      ),
      body: IndexedStack(
        index: safeSelectedIndex,
        children: [
          // TickerMode stops the hidden tabs' repeating animations (balloon
          // field, star field) from burning CPU at 60fps while not visible.
          for (var i = 0; i < pages.length; i++)
            TickerMode(enabled: i == safeSelectedIndex, child: pages[i]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navItems,
        currentIndex: safeSelectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_profileStream == null) {
      return _buildScaffold(displayName: widget.username);
    }
    return StreamBuilder<DatabaseEvent>(
      stream: _profileStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildScaffold(displayName: widget.username);
        }
        final value = snapshot.data?.snapshot.value;
        String? avatarUrl;
        String? avatarAssetPath;
        String? fullName;
        var avatarDefaultDismissed = false;
        if (value is Map) {
          final data = Map<String, dynamic>.from(value);
          final avatarValue = data['avatarUrl'];
          final avatarAssetValue = data['avatarAssetPath'];
          final nameValue = data['fullName'];
          final dismissedValue = data['avatarDefaultDismissed'];
          avatarUrl = avatarValue is String ? avatarValue : null;
          avatarAssetPath = avatarAssetValue is String
              ? avatarAssetValue
              : null;
          fullName = nameValue is String ? nameValue : null;
          avatarDefaultDismissed = dismissedValue is bool && dismissedValue;
        }
        if (snapshot.hasData) {
          unawaited(
            _maybeBackfillDefaultAvatar(
              avatarUrl: avatarUrl,
              avatarAssetPath: avatarAssetPath,
              avatarDefaultDismissed: avatarDefaultDismissed,
            ),
          );
        }
        final displayName = (fullName != null && fullName.trim().isNotEmpty)
            ? fullName.trim()
            : widget.username;
        return _buildScaffold(
          displayName: displayName,
          avatarUrl: avatarUrl,
          avatarAssetPath: avatarAssetPath,
        );
      },
    );
  }
}
