part of '../home_page.dart';

class _SettingsContent extends StatefulWidget {
  const _SettingsContent({
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  final ImagePicker _picker = ImagePicker();
  bool _isAvatarBusy = false;

  String _languageLabel(Locale locale, AppLocalizations l10n) {
    if (locale.languageCode == 'en') {
      return l10n.languageEnglish;
    }
    if (locale.languageCode == 'sr' && locale.scriptCode == 'Latn') {
      return l10n.languageSerbianLatin;
    }
    if (locale.languageCode == 'mk') {
      return l10n.languageMacedonian;
    }
    if (locale.languageCode == 'de') {
      return l10n.languageGerman;
    }
    if (locale.languageCode == 'el') {
      return l10n.languageGreek;
    }
    if (locale.languageCode == 'ro') {
      return l10n.languageRomanian;
    }
    if (locale.languageCode == 'ar') {
      return l10n.languageArabic;
    }
    if (locale.languageCode == 'rom') {
      return l10n.languageRomani;
    }
    if (locale.languageCode == 'tr') {
      return l10n.languageTurkish;
    }
    return locale.languageCode;
  }

  Future<void> _pickAvatar(ImageSource source) async {
    if (_isAvatarBusy) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isAvatarBusy = true;
    });

    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 512,
      );
      if (picked == null) return;

      final file = File(picked.path);
      final ref = FirebaseStorage.instance.ref(
        'users/${user.uid}/avatars/avatar.jpg',
      );
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/avatarUrl')
          .set(url);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Avatar updated.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update avatar.')));
    } finally {
      if (mounted) {
        setState(() {
          _isAvatarBusy = false;
        });
      }
    }
  }

  Future<void> _removeAvatar() async {
    if (_isAvatarBusy) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isAvatarBusy = true;
    });

    try {
      final ref = FirebaseStorage.instance.ref(
        'users/${user.uid}/avatars/avatar.jpg',
      );
      await ref.delete();
    } catch (_) {}

    try {
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/avatarUrl')
          .remove();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Avatar removed.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to remove avatar.')));
    } finally {
      if (mounted) {
        setState(() {
          _isAvatarBusy = false;
        });
      }
    }
  }

  Future<void> _updateDisplayName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    try {
      await user.updateDisplayName(trimmed);
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/fullName')
          .set(trimmed);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name updated.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update name.')));
    }
  }

  Future<void> _editDisplayName(String? currentName) async {
    final controller = TextEditingController(text: currentName ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit name'),
          content: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Full name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result == null) return;
    await _updateDisplayName(result);
  }

  bool _canUpdateCredentials(User? user) {
    return user?.providerData.any(
          (provider) => provider.providerId == 'password',
        ) ??
        false;
  }

  String? _validatePassword(String value) {
    final trimmed = value.trim();
    if (trimmed.length < 8) return 'Password must be at least 8 characters.';
    final hasUpper = RegExp(r'[A-Z]').hasMatch(trimmed);
    final hasNumber = RegExp(r'\d').hasMatch(trimmed);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(trimmed);
    if (!hasUpper || !hasNumber || !hasSpecial) {
      return 'Use 1 uppercase, 1 number, and 1 special character.';
    }
    return null;
  }

  Future<void> _updateEmail(String email, String? username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) return;
    final currentEmail = user.email?.trim();
    if (currentEmail != null &&
        currentEmail.isNotEmpty &&
        currentEmail.toLowerCase() == trimmed.toLowerCase()) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email is unchanged.')));
      return;
    }
    try {
      await user.verifyBeforeUpdateEmail(trimmed);
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/pendingEmail')
          .set(trimmed);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent to the new address.'),
        ),
      );
    } on FirebaseAuthException catch (error) {
      final message = error.code == 'requires-recent-login'
          ? 'Please log in again to update your email.'
          : 'Failed to update email.';
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update email.')));
    }
  }

  Future<void> _editEmail(String? currentEmail, String? username) async {
    final controller = TextEditingController(text: currentEmail ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit email'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result == null) return;
    await _updateEmail(result, username);
  }

  Future<void> _updatePassword(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final validation = _validatePassword(value);
    if (validation != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validation)));
      return;
    }
    try {
      await user.updatePassword(value.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password updated.')));
    } on FirebaseAuthException catch (error) {
      final message = error.code == 'requires-recent-login'
          ? 'Please log in again to update your password.'
          : 'Failed to update password.';
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update password.')),
      );
    }
  }

  Future<void> _editPassword() async {
    final controller = TextEditingController();
    final confirmController = TextEditingController();
    bool obscure = true;
    bool obscureConfirm = true;
    String? validationMessage;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    obscureText: obscure,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        validationMessage = _validatePassword(value);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmController,
                    obscureText: obscureConfirm,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirm = !obscureConfirm;
                          });
                        },
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      validationMessage ??
                          'Min 8 chars, 1 uppercase, 1 number, 1 special.',
                      style: TextStyle(
                        fontSize: 12,
                        color: validationMessage == null
                            ? Colors.grey.shade600
                            : Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final password = controller.text;
                    final confirm = confirmController.text;
                    final validation = _validatePassword(password);
                    if (validation != null) {
                      setState(() {
                        validationMessage = validation;
                      });
                      return;
                    }
                    if (password != confirm) {
                      setState(() {
                        validationMessage = 'Passwords do not match.';
                      });
                      return;
                    }
                    Navigator.pop(context, password);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
    if (result == null) return;
    await _updatePassword(result);
  }

  Future<void> _reauthenticate() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final email = user.email?.trim();
    if (email == null || email.isEmpty) return;

    final controller = TextEditingController();
    bool obscure = true;
    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Re-authenticate'),
              content: TextField(
                controller: controller,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );

    if (password == null || password.trim().isEmpty) return;
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password.trim(),
      );
      await user.reauthenticateWithCredential(credential);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication successful.')),
      );
    } on FirebaseAuthException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication failed.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication failed.')),
      );
    }
  }

  void _openAvatarSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remove photo'),
                onTap: () {
                  Navigator.pop(context);
                  _removeAvatar();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _fallbackInitial(User? user) {
    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName.substring(0, 1).toUpperCase();
    }
    final email = user?.email?.trim();
    if (email != null && email.isNotEmpty) {
      return email.substring(0, 1).toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final profileStream = user == null
        ? null
        : FirebaseDatabase.instance.ref('users/${user.uid}').onValue;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Text(
          l10n.settingsPreferencesTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.tune),
            title: Text(l10n.settingsPreferencesTitle),
            subtitle: Text(l10n.settingsPreferencesBody),
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder<DatabaseEvent>(
          stream: profileStream,
          builder: (context, snapshot) {
            final value = snapshot.data?.snapshot.value;
            String? avatarUrl;
            String? fullName;
            String? username;
            String? email;
            if (value is Map) {
              final data = Map<String, dynamic>.from(value);
              final avatarValue = data['avatarUrl'];
              final nameValue = data['fullName'];
              final usernameValue = data['username'];
              final emailValue = data['email'];
              avatarUrl = avatarValue is String ? avatarValue : null;
              fullName = nameValue is String ? nameValue : null;
              username = usernameValue is String ? usernameValue : null;
              email = emailValue is String ? emailValue : null;
            }
            final canUpdate = _canUpdateCredentials(user);
            final displayName = (fullName != null && fullName.trim().isNotEmpty)
                ? fullName.trim()
                : (user?.displayName ?? 'User');
            return Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: _openAvatarSheet,
                    leading: const Icon(Icons.account_circle_outlined),
                    title: const Text('Profile photo'),
                    subtitle: const Text('Add or remove your avatar.'),
                    trailing: _isAvatarBusy
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blue.shade100,
                            foregroundColor: Colors.blue.shade900,
                            backgroundImage: avatarUrl != null
                                ? NetworkImage(avatarUrl)
                                : null,
                            child: avatarUrl == null
                                ? Text(_fallbackInitial(user))
                                : null,
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Display name'),
                    subtitle: Text(displayName),
                    trailing: const Icon(Icons.edit),
                    onTap: () => _editDisplayName(displayName),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.verified_user_outlined),
                    title: const Text('Re-authenticate'),
                    subtitle: Text(
                      canUpdate
                          ? 'Confirm your password to update email or password.'
                          : 'Available only for password accounts.',
                    ),
                    trailing: Icon(
                      canUpdate ? Icons.chevron_right : Icons.lock_outline,
                    ),
                    onTap: canUpdate ? _reauthenticate : null,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('Email'),
                    subtitle: Text(email ?? user?.email ?? 'Unknown'),
                    trailing: Icon(canUpdate ? Icons.edit : Icons.lock_outline),
                    onTap: canUpdate
                        ? () => _editEmail(email ?? user?.email, username)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Password'),
                    subtitle: Text(
                      canUpdate
                          ? 'Update your password.'
                          : 'Managed by your sign-in provider.',
                    ),
                    trailing: Icon(canUpdate ? Icons.edit : Icons.lock_outline),
                    onTap: canUpdate ? _editPassword : null,
                  ),
                ),
              ],
            );
          },
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme'),
                const SizedBox(height: 12),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: widget.themeModeNotifier,
                  builder: (context, mode, _) {
                    return DropdownButtonFormField<ThemeMode>(
                      initialValue: mode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Light'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Dark'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        widget.themeModeNotifier.value = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(l10n.settingsNotificationsTitle),
            subtitle: Text(l10n.settingsNotificationsBody),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.settingsLanguageTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsLanguageBody),
                const SizedBox(height: 12),
                ValueListenableBuilder<Locale?>(
                  valueListenable: widget.localeNotifier,
                  builder: (context, locale, _) {
                    return DropdownButtonFormField<Locale?>(
                      initialValue: locale,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.settingsLanguageSystem),
                        ),
                        ...widget.supportedLocales.map(
                          (supportedLocale) => DropdownMenuItem(
                            value: supportedLocale,
                            child: Text(_languageLabel(supportedLocale, l10n)),
                          ),
                        ),
                      ],
                      onChanged: (value) => widget.localeNotifier.value = value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _SettingsContent(
        localeNotifier: localeNotifier,
        supportedLocales: supportedLocales,
        themeModeNotifier: themeModeNotifier,
      ),
    );
  }
}

class _BodyAwarenessContent extends StatefulWidget {
  @override
  State<_BodyAwarenessContent> createState() => _BodyAwarenessContentState();
}

class _BodyAwarenessContentState extends State<_BodyAwarenessContent> {
  final List<Color> _palette = const [
    Color(0xFF1D5C7A),
    Color(0xFF2E8AA6),
    Color(0xFF52B0B8),
    Color(0xFF7FC6B6),
    Color(0xFFAEDB9D),
    Color(0xFFE7E27A),
    Color(0xFFF3C562),
    Color(0xFFF2A55A),
    Color(0xFFE67C5A),
    Color(0xFFD65B6E),
    Color(0xFFB14E8D),
    Color(0xFF7A4CA0),
  ];

  _BodyAwarenessPoint? _point;
  Color _selectedColor = const Color(0xFFF2A55A);
  bool _isSaving = false;

  void _setPoint(Offset localPosition, Size size) {
    final x = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final y = (localPosition.dy / size.height).clamp(0.0, 1.0);
    setState(() {
      _point = _BodyAwarenessPoint(x: x, y: y, color: _selectedColor);
    });
  }

  String _detectBodyRegion(Offset localPosition, Size size) {
    final x = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final y = (localPosition.dy / size.height).clamp(0.0, 1.0);

    if (y < 0.18 && x > 0.35 && x < 0.65) return 'Head';
    if (y >= 0.18 && y < 0.25 && x > 0.40 && x < 0.60) return 'Neck';
    if (y >= 0.25 && y < 0.35 && x <= 0.30) return 'Left shoulder';
    if (y >= 0.25 && y < 0.35 && x >= 0.70) return 'Right shoulder';
    if (y >= 0.25 && y < 0.45 && x > 0.30 && x < 0.70) return 'Chest';
    if (y >= 0.45 && y < 0.58 && x > 0.35 && x < 0.65) return 'Stomach';
    if (y >= 0.60 && y < 0.85 && x <= 0.22) return 'Left hand';
    if (y >= 0.60 && y < 0.85 && x >= 0.78) return 'Right hand';
    if (y >= 0.35 && y < 0.60 && x <= 0.30) return 'Left arm';
    if (y >= 0.35 && y < 0.60 && x >= 0.70) return 'Right arm';
    if (y >= 0.58 && y < 0.78 && x > 0.35 && x < 0.65) return 'Hips';
    if (y >= 0.70 && y < 0.80 && x > 0.30 && x < 0.45) return 'Left knee';
    if (y >= 0.70 && y < 0.80 && x > 0.55 && x < 0.70) return 'Right knee';
    if (y >= 0.80 && y < 0.92 && x > 0.30 && x < 0.45) return 'Left leg';
    if (y >= 0.80 && y < 0.92 && x > 0.55 && x < 0.70) return 'Right leg';
    if (y >= 0.92 && x < 0.50) return 'Left foot';
    if (y >= 0.92 && x >= 0.50) return 'Right foot';
    return 'Body';
  }

  String _dateKey(DateTime date) {
    final yyyy = date.year.toString();
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final point = _point;
    if (point == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap the body to log a sensation.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now();
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness/${_dateKey(now)}')
          .set({
            'x': point.x,
            'y': point.y,
            'color': point.color.toARGB32(),
            'createdAt': now.toIso8601String(),
          });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Body awareness saved.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save body awareness.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [Color(0xFF2E2940), Color(0xFF1A1624)]
        : const [Color(0xFF745CA3), Color(0xFFBBA6D6)];
    final textColor = isDark ? const Color(0xFFF2EEF8) : Colors.white;
    final panelColor = isDark
        ? const Color(0xFF2E2940)
        : Colors.white.withValues(alpha: 0.9);
    final outlineColor = isDark ? const Color(0xFFD9CFEA) : Colors.white;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Where does this feeling seem in rest in your body?\n'
                'Please touch that spot and select a color that feels true '
                'to the sensation.',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _BodyAwarenessView(
                      point: _point,
                      interactive: true,
                      outlineColor: outlineColor,
                      onTap: (offset) {
                        final region = _detectBodyRegion(
                          offset,
                          constraints.biggest,
                        );
                        debugPrint('Body awareness tap: $region');
                        _setPoint(offset, constraints.biggest);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: panelColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _palette.map((color) {
                      final selected = color == _selectedColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                            if (_point != null) {
                              _point = _BodyAwarenessPoint(
                                x: _point!.x,
                                y: _point!.y,
                                color: _selectedColor,
                              );
                            }
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF6B539D)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Saving...' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
