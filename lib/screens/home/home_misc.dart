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

  String _languageLabel(Locale locale) {
    if (locale.languageCode == 'en') {
      return 'English';
    }
    if (locale.languageCode == 'sr' && locale.scriptCode == 'Latn') {
      return 'Srpski';
    }
    if (locale.languageCode == 'mk') {
      return 'Македонски';
    }
    if (locale.languageCode == 'de') {
      return 'Deutsch';
    }
    if (locale.languageCode == 'el') {
      return 'Ελληνικά';
    }
    if (locale.languageCode == 'ro') {
      return 'Română';
    }
    if (locale.languageCode == 'ar') {
      return 'العربية';
    }
    if (locale.languageCode == 'rom') {
      return 'Romani';
    }
    if (locale.languageCode == 'tr') {
      return 'Türkçe';
    }
    return locale.toLanguageTag();
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
                            child: Text(_languageLabel(supportedLocale)),
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
  final Map<String, _BodyAwarenessPoint> _pointsBySide = {};
  final Map<String, String> _regionsBySide = {};
  String _selectedSide = 'front';
  Color _selectedColor = const Color(0xFFF2A55A);
  bool _isSaving = false;
  _BodyRegionMask? _bodyRegionMask;

  _BodyAwarenessPoint? get _point => _pointsBySide[_selectedSide];
  String? get _selectedRegion => _regionsBySide[_selectedSide];

  @override
  void initState() {
    super.initState();
    _loadExistingForToday();
    _initBodyRegionMask();
  }

  Future<void> _loadExistingForToday() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final todayKey = _dateKey(DateTime.now());
      final snap = await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness/$todayKey')
          .get();
      if (!snap.exists || snap.value is! Map) return;
      final data = Map<String, dynamic>.from(snap.value as Map);
      final loaded = <String, _BodyAwarenessPoint>{};
      final loadedRegions = <String, String>{};
      final front = _parsePoint(data['front']);
      final back = _parsePoint(data['back']);
      if (front != null) loaded['front'] = front;
      if (back != null) loaded['back'] = back;
      final frontRegion = _parseRegion(data['front']);
      final backRegion = _parseRegion(data['back']);
      if (frontRegion != null) loadedRegions['front'] = frontRegion;
      if (backRegion != null) loadedRegions['back'] = backRegion;
      if (loaded.isEmpty) {
        final legacy = _parsePoint(data);
        if (legacy != null) {
          loaded['front'] = legacy;
        }
        final legacyRegion = _parseRegion(data);
        if (legacyRegion != null) {
          loadedRegions['front'] = legacyRegion;
        }
      }

      if (!mounted || loaded.isEmpty) return;
      setState(() {
        _pointsBySide.addAll(loaded);
        _regionsBySide.addAll(loadedRegions);
      });
    } catch (_) {}
  }

  Future<void> _initBodyRegionMask() async {
    final mask = await _BodyRegionMask.load();
    if (!mounted || mask == null) return;
    setState(() {
      _bodyRegionMask = mask;
    });
  }

  _BodyAwarenessPoint? _parsePoint(dynamic value) {
    if (value is! Map) return null;
    final data = Map<String, dynamic>.from(value);
    final x = data['x'];
    final y = data['y'];
    final colorValue = data['color'];
    if (x is num && y is num && colorValue is int) {
      return _BodyAwarenessPoint(
        x: x.toDouble(),
        y: y.toDouble(),
        color: Color(colorValue),
      );
    }
    return null;
  }

  String? _parseRegion(dynamic value) {
    if (value is! Map) return null;
    final data = Map<String, dynamic>.from(value);
    return _normalizeRegion(data['region']);
  }

  String? _normalizeRegion(dynamic value) {
    if (value is! String) return null;
    final key = value.trim().toLowerCase();
    const aliases = {
      'body': 'torso',
      'chest': 'torso',
      'stomach': 'torso',
      'hips': 'torso',
      'back': 'back',
      'left shoulder': 'shoulders',
      'right shoulder': 'shoulders',
      'left arm': 'arms',
      'right arm': 'arms',
      'left hand': 'hands',
      'right hand': 'hands',
      'left leg': 'legs',
      'right leg': 'legs',
      'left knee': 'legs',
      'right knee': 'legs',
      'left foot': 'feet',
      'right foot': 'feet',
    };
    const allowed = {
      'head',
      'neck',
      'shoulders',
      'arms',
      'hands',
      'torso',
      'back',
      'legs',
      'feet',
      'outside',
    };
    final normalized = aliases[key] ?? key;
    return allowed.contains(normalized) ? normalized : null;
  }

  void _setPoint(Offset localPosition, Size size, {required String region}) {
    final x = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final y = (localPosition.dy / size.height).clamp(0.0, 1.0);
    setState(() {
      _pointsBySide[_selectedSide] = _BodyAwarenessPoint(
        x: x,
        y: y,
        color: _selectedColor,
      );
      _regionsBySide[_selectedSide] = region;
    });
  }

  String _detectBodyRegion(Offset localPosition, Size size) {
    final exact = _bodyRegionMask?.regionAt(
      localPosition,
      size,
      side: _selectedSide,
    );
    if (exact != null) return exact;
    return 'outside';
  }

  String _dateKey(DateTime date) {
    final yyyy = date.year.toString();
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    return '$yyyy$mm$dd';
  }

  Future<void> _openColorPicker() async {
    var pendingColor = _selectedColor;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  16 + MediaQuery.of(sheetContext).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Color',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ColorPicker(
                      pickerColor: pendingColor,
                      onColorChanged: (color) => setModalState(() {
                        pendingColor = color.withValues(alpha: 1.0);
                      }),
                      paletteType: PaletteType.hsvWithHue,
                      enableAlpha: false,
                      displayThumbColor: true,
                      labelTypes: const [],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!mounted) return;
                          setState(() {
                            _selectedColor = pendingColor;
                            if (_point != null) {
                              _pointsBySide[_selectedSide] =
                                  _BodyAwarenessPoint(
                                    x: _point!.x,
                                    y: _point!.y,
                                    color: _selectedColor,
                                  );
                            }
                          });
                          Navigator.pop(sheetContext);
                        },
                        child: const Text('Use this color'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
          .ref(
            'users/${user.uid}/body_awareness/${_dateKey(now)}/$_selectedSide',
          )
          .set({
            'x': point.x,
            'y': point.y,
            'color': point.color.toARGB32(),
            'region': _selectedRegion ?? 'outside',
            'createdAt': now.toIso8601String(),
          });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Body awareness saved (${_selectedSide == 'front' ? 'Front' : 'Back'}).',
          ),
        ),
      );
    } on FirebaseException catch (error) {
      if (!mounted) return;
      final message = error.code.isNotEmpty
          ? 'Failed to save body awareness: ${error.code}.'
          : 'Failed to save body awareness.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
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
              const SizedBox(height: 8),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _BodyFlipSwitcher(
                        side: _selectedSide,
                        child: KeyedSubtree(
                          key: ValueKey(_selectedSide),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return _BodyAwarenessView(
                                point: _point,
                                interactive: _bodyRegionMask != null,
                                outlineColor: outlineColor,
                                onTap: (offset) {
                                  final region = _detectBodyRegion(
                                    offset,
                                    constraints.biggest,
                                  );
                                  debugPrint('Body awareness tap: $region');
                                  _setPoint(
                                    offset,
                                    constraints.biggest,
                                    region: region,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: _BodySideToggleButton(
                        label: 'Color',
                        icon: Icons.palette_outlined,
                        onTap: _openColorPicker,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: _BodySideToggleButton(
                        label: _selectedSide == 'front'
                            ? 'Show back'
                            : 'Show front',
                        onTap: () {
                          setState(() {
                            _selectedSide = _selectedSide == 'front'
                                ? 'back'
                                : 'front';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _bodyRegionMask == null
                    ? 'Preparing body map...'
                    : 'Selected area: ${_selectedRegion ?? 'none'}',
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.92),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
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

class _BodyRegionMask {
  const _BodyRegionMask._({
    required this.width,
    required this.height,
    required this.pixels,
  });

  static const int _svgWidth = 500;
  static const int _svgHeight = 901;
  static const Map<int, String> _colorToRegion = {
    0xFF0000: 'feet',
    0x000080: 'legs',
    0xFFE680: 'torso',
    0x00FF00: 'head',
    0x800080: 'hands',
    0x2B0000: 'arms',
    0x999999: 'shoulders',
    0xFF00FF: 'neck',
  };

  final int width;
  final int height;
  final Uint8List pixels;

  static Future<_BodyRegionMask?> load() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/images/Human_body_outline_colored.svg',
      );
      final filtered = _buildMaskSvg(raw);
      final pictureInfo = await svg.vg.loadPicture(
        svg.SvgStringLoader(filtered),
        null,
      );
      final image = await pictureInfo.picture.toImage(_svgWidth, _svgHeight);
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      pictureInfo.picture.dispose();
      image.dispose();
      if (data == null) return null;
      return _BodyRegionMask._(
        width: _svgWidth,
        height: _svgHeight,
        pixels: data.buffer.asUint8List(),
      );
    } catch (error) {
      debugPrint('Body region mask load failed: $error');
      return null;
    }
  }

  String? regionAt(Offset localPosition, Size size, {required String side}) {
    final fitted = _fittedRect(size);
    if (!fitted.contains(localPosition)) return 'outside';
    final nx = ((localPosition.dx - fitted.left) / fitted.width).clamp(
      0.0,
      1.0,
    );
    final ny = ((localPosition.dy - fitted.top) / fitted.height).clamp(
      0.0,
      1.0,
    );
    final px = (nx * (width - 1)).round();
    final py = (ny * (height - 1)).round();
    final baseRegion = _sampleRegion(px, py) ?? 'outside';
    if (baseRegion == 'torso' && side == 'back') return 'back';
    return baseRegion;
  }

  Rect _fittedRect(Size size) {
    final scale = min(size.width / _svgWidth, size.height / _svgHeight);
    final w = _svgWidth * scale;
    final h = _svgHeight * scale;
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    return Rect.fromLTWH(left, top, w, h);
  }

  String? _sampleRegion(int x, int y) {
    final score = <String, int>{};
    for (var dy = -1; dy <= 1; dy++) {
      for (var dx = -1; dx <= 1; dx++) {
        final sx = (x + dx).clamp(0, width - 1);
        final sy = (y + dy).clamp(0, height - 1);
        final idx = (sy * width + sx) * 4;
        final alpha = pixels[idx + 3];
        if (alpha < 16) continue;

        var r = pixels[idx];
        var g = pixels[idx + 1];
        var b = pixels[idx + 2];

        if (alpha < 255) {
          r = ((r * 255) / alpha).round().clamp(0, 255);
          g = ((g * 255) / alpha).round().clamp(0, 255);
          b = ((b * 255) / alpha).round().clamp(0, 255);
        }

        final region = _closestRegion(r, g, b);
        if (region == null) continue;
        score[region] = (score[region] ?? 0) + alpha;
      }
    }

    if (score.isEmpty) return null;
    return score.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  String? _closestRegion(int r, int g, int b) {
    String? bestRegion;
    var bestDistance = 1 << 30;
    for (final entry in _colorToRegion.entries) {
      final target = entry.key;
      final tr = (target >> 16) & 0xFF;
      final tg = (target >> 8) & 0xFF;
      final tb = target & 0xFF;
      final dr = r - tr;
      final dg = g - tg;
      final db = b - tb;
      final distance = dr * dr + dg * dg + db * db;
      if (distance < bestDistance) {
        bestDistance = distance;
        bestRegion = entry.value;
      }
    }
    // Allows anti-aliased edges while rejecting unrelated colors.
    if (bestDistance > 1400) return null;
    return bestRegion;
  }

  static String _buildMaskSvg(String raw) {
    const keep = {
      '#ff0000',
      '#000080',
      '#ffe680',
      '#00ff00',
      '#800080',
      '#2b0000',
      '#999999',
      '#ff00ff',
    };

    var output = raw.replaceAllMapped(RegExp(r'fill="(#[0-9a-fA-F]{6})"'), (
      match,
    ) {
      final color = match.group(1)!.toLowerCase();
      return keep.contains(color) ? 'fill="$color"' : 'fill="none"';
    });

    output = output.replaceAllMapped(
      RegExp(r'fill:#[0-9a-fA-F]{6}', caseSensitive: false),
      (match) {
        final color = match.group(0)!.substring(5).toLowerCase();
        return keep.contains(color) ? 'fill:$color' : 'fill:none';
      },
    );

    return output;
  }
}
