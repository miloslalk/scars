import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'care_corner_page.dart';
import 'package:flutter/services.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import '../widgets/app_top_bar.dart';
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

  List<Widget> _buildPages(String displayName) {
    return [
      _HomeContent(displayName: displayName),
      _BodyAwarenessContent(),
      const CareCornerPage(),
      _MySpaceContent(),
      _MessagesContent(),
      _HelpContent(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
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

  Widget _buildScaffold({required String displayName, String? avatarUrl}) {
    final l10n = AppLocalizations.of(context)!;
    final initial = displayName.trim().isNotEmpty
        ? displayName.trim().substring(0, 1).toUpperCase()
        : null;

    return Scaffold(
      appBar: AppTopBar(
        userInitial: initial,
        userName: displayName,
        userAvatarUrl: avatarUrl,
        onSettingsTap: _openSettings,
        onLogoutTap: _logout,
      ),
      body: _buildPages(displayName)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: l10n.homeLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            label: 'Body awareness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park_outlined),
            label: 'Care Corner',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'My Space'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: l10n.helpLabel,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return _buildScaffold(displayName: widget.username);
    }
    final profileStream = FirebaseDatabase.instance
        .ref('users/${user.uid}')
        .onValue;
    return StreamBuilder<DatabaseEvent>(
      stream: profileStream,
      builder: (context, snapshot) {
        final value = snapshot.data?.snapshot.value;
        String? avatarUrl;
        String? fullName;
        if (value is Map) {
          final data = Map<String, dynamic>.from(value);
          final avatarValue = data['avatarUrl'];
          final nameValue = data['fullName'];
          avatarUrl = avatarValue is String ? avatarValue : null;
          fullName = nameValue is String ? nameValue : null;
        }
        final displayName = (fullName != null && fullName.trim().isNotEmpty)
            ? fullName.trim()
            : widget.username;
        return _buildScaffold(displayName: displayName, avatarUrl: avatarUrl);
      },
    );
  }
}
