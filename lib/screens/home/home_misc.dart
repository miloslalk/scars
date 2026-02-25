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
  bool _isDeletingAccount = false;
  bool _dailyNotificationsEnabled = true;
  bool _inactiveNotificationsEnabled = true;
  int _dailyNotificationHour = 9;
  int _dailyNotificationMinute = 0;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreferences();
  }

  Future<void> _loadNotificationPreferences() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final snap = await FirebaseDatabase.instance
        .ref('users/$uid/notificationPrefs')
        .get();
    final value = snap.value;
    if (value is! Map || !mounted) return;
    final data = Map<String, dynamic>.from(value);
    final dailyEnabled = data['dailyEnabled'];
    final inactiveEnabled = data['inactiveEnabled'];
    final hour = data['dailyHour'];
    final minute = data['dailyMinute'];
    setState(() {
      if (dailyEnabled is bool) _dailyNotificationsEnabled = dailyEnabled;
      if (inactiveEnabled is bool) {
        _inactiveNotificationsEnabled = inactiveEnabled;
      }
      if (hour is int && hour >= 0 && hour <= 23) {
        _dailyNotificationHour = hour;
      }
      if (minute is int && minute >= 0 && minute <= 59) {
        _dailyNotificationMinute = minute;
      }
    });
  }

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

  Future<bool> _reauthenticatePasswordUser(
    User user, {
    String title = 'Confirm password',
  }) async {
    final email = user.email?.trim();
    if (email == null || email.isEmpty) return false;

    final controller = TextEditingController();
    bool obscure = true;
    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
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
    if (password == null || password.trim().isEmpty) return false;

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password.trim(),
    );
    await user.reauthenticateWithCredential(credential);
    return true;
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

  Future<void> _updateEmail(
    String email,
    String? username, {
    bool allowReauthRetry = true,
  }) async {
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
      if (error.code == 'requires-recent-login' && allowReauthRetry) {
        try {
          final reauthed = await _reauthenticatePasswordUser(
            user,
            title: 'Re-authenticate to update email',
          );
          if (!reauthed) return;
          await _updateEmail(email, username, allowReauthRetry: false);
          return;
        } on FirebaseAuthException {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Re-authentication failed.')),
          );
          return;
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Re-authentication failed.')),
          );
          return;
        }
      }
      final message = 'Failed to update email.';
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

  Future<void> _updatePassword(
    String value, {
    bool allowReauthRetry = true,
  }) async {
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
      if (error.code == 'requires-recent-login' && allowReauthRetry) {
        try {
          final reauthed = await _reauthenticatePasswordUser(
            user,
            title: 'Re-authenticate to update password',
          );
          if (!reauthed) return;
          await _updatePassword(value, allowReauthRetry: false);
          return;
        } on FirebaseAuthException {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Re-authentication failed.')),
          );
          return;
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Re-authentication failed.')),
          );
          return;
        }
      }
      final message = 'Failed to update password.';
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

  String _safeKey(String value) {
    if (value.isEmpty) return 'user';
    final buffer = StringBuffer();
    for (final codeUnit in value.codeUnits) {
      final isValid =
          (codeUnit >= 48 && codeUnit <= 57) ||
          (codeUnit >= 65 && codeUnit <= 90) ||
          (codeUnit >= 97 && codeUnit <= 122) ||
          codeUnit == 45 ||
          codeUnit == 95;
      buffer.write(isValid ? String.fromCharCode(codeUnit) : '_');
    }
    return buffer.toString();
  }

  Future<void> _deleteStoragePathRecursively(Reference ref) async {
    final listed = await ref.listAll();
    for (final item in listed.items) {
      try {
        await item.delete();
      } catch (_) {}
    }
    for (final prefix in listed.prefixes) {
      await _deleteStoragePathRecursively(prefix);
    }
  }

  Future<void> _deleteAccount() async {
    if (_isDeletingAccount) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccountDialogTitle),
        content: Text(l10n.deleteAccountDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancelLabel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.deleteAccountActionLabel),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _isDeletingAccount = true;
    });

    try {
      final providerIds = user.providerData.map((p) => p.providerId).toSet();
      if (providerIds.contains('password')) {
        final email = user.email?.trim();
        if (email == null || email.isEmpty) {
          throw FirebaseAuthException(code: 'requires-recent-login');
        }
        final passwordController = TextEditingController();
        bool obscure = true;
        final password = await showDialog<String>(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(l10n.confirmPasswordLabel),
                  content: TextField(
                    controller: passwordController,
                    obscureText: obscure,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: l10n.passwordLabel,
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
                      child: Text(l10n.cancelLabel),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pop(context, passwordController.text),
                      child: Text(l10n.confirmLabel),
                    ),
                  ],
                );
              },
            );
          },
        );
        if (password == null || password.trim().isEmpty) {
          return;
        }
        final credential = EmailAuthProvider.credential(
          email: email,
          password: password.trim(),
        );
        await user.reauthenticateWithCredential(credential);
      }

      final userRef = FirebaseDatabase.instance.ref('users/${user.uid}');
      final profileSnap = await userRef.get();
      String? username;
      if (profileSnap.exists && profileSnap.value is Map) {
        final map = Map<String, dynamic>.from(profileSnap.value as Map);
        final value = map['username'];
        if (value is String && value.trim().isNotEmpty) {
          username = value.trim();
        }
      }

      try {
        await _deleteStoragePathRecursively(
          FirebaseStorage.instance.ref('users/${user.uid}'),
        );
      } catch (_) {}

      await userRef.remove();
      if (username != null) {
        await FirebaseDatabase.instance
            .ref('usernames/${_safeKey(username)}')
            .remove();
      }

      await user.delete();
      await FirebaseAuth.instance.signOut();

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
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      final message = error.code == 'requires-recent-login'
          ? l10n.deleteAccountRequiresRecentLogin
          : l10n.deleteAccountFailed;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.deleteAccountFailed)));
    } finally {
      if (mounted) {
        setState(() {
          _isDeletingAccount = false;
        });
      }
    }
  }

  String _notificationSummary({
    required bool dailyEnabled,
    required bool inactiveEnabled,
    required int dailyHour,
    required int dailyMinute,
  }) {
    if (!dailyEnabled && !inactiveEnabled) {
      return 'Notifications are turned off.';
    }
    final hh = dailyHour.toString().padLeft(2, '0');
    final mm = dailyMinute.toString().padLeft(2, '0');
    if (dailyEnabled && inactiveEnabled) {
      return 'Daily at $hh:$mm and 7-day inactivity reminders.';
    }
    if (dailyEnabled) {
      return 'Daily reminder at $hh:$mm.';
    }
    return 'Only 7-day inactivity reminders.';
  }

  Future<void> _saveNotificationPreferences({
    required bool dailyEnabled,
    required bool inactiveEnabled,
    required int dailyHour,
    required int dailyMinute,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final now = DateTime.now().toIso8601String();
    final userRef = FirebaseDatabase.instance.ref('users/${user.uid}');

    await userRef.child('notificationPrefs').set({
      'dailyEnabled': dailyEnabled,
      'inactiveEnabled': inactiveEnabled,
      'dailyHour': dailyHour,
      'dailyMinute': dailyMinute,
      'updatedAt': now,
    });

    final devicesSnap = await userRef.child('devices').get();
    final devices = devicesSnap.value;
    if (devices is Map) {
      final updates = <String, Object?>{};
      for (final key in devices.keys) {
        updates['devices/$key/dailyEnabled'] = dailyEnabled;
        updates['devices/$key/inactiveEnabled'] = inactiveEnabled;
        updates['devices/$key/dailyHour'] = dailyHour;
        updates['devices/$key/dailyMinute'] = dailyMinute;
        updates['devices/$key/updatedAt'] = now;
      }
      if (updates.isNotEmpty) {
        await userRef.update(updates);
      }
    }
  }

  Future<void> _openNotificationSettings({
    required bool dailyEnabled,
    required bool inactiveEnabled,
    required int dailyHour,
    required int dailyMinute,
  }) async {
    final result = await showModalBottomSheet<_NotificationPrefsDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        var draft = _NotificationPrefsDraft(
          dailyEnabled: dailyEnabled,
          inactiveEnabled: inactiveEnabled,
          dailyHour: dailyHour,
          dailyMinute: dailyMinute,
        );
        return StatefulBuilder(
          builder: (context, setState) {
            final timeLabel =
                '${draft.dailyHour.toString().padLeft(2, '0')}:${draft.dailyMinute.toString().padLeft(2, '0')}';
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Daily reminder'),
                    subtitle: const Text('Send a daily morning push.'),
                    value: draft.dailyEnabled,
                    onChanged: (value) {
                      setState(() {
                        draft = draft.copyWith(dailyEnabled: value);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Reminder time'),
                    subtitle: Text(timeLabel),
                    trailing: const Icon(Icons.schedule),
                    enabled: draft.dailyEnabled,
                    onTap: !draft.dailyEnabled
                        ? null
                        : () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: draft.dailyHour,
                                minute: draft.dailyMinute,
                              ),
                            );
                            if (picked == null) return;
                            setState(() {
                              draft = draft.copyWith(
                                dailyHour: picked.hour,
                                dailyMinute: picked.minute,
                              );
                            });
                          },
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Inactive reminder'),
                    subtitle: const Text('Send a reminder after 7 days away.'),
                    value: draft.inactiveEnabled,
                    onChanged: (value) {
                      setState(() {
                        draft = draft.copyWith(inactiveEnabled: value);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, draft),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (result == null) return;
    try {
      await _saveNotificationPreferences(
        dailyEnabled: result.dailyEnabled,
        inactiveEnabled: result.inactiveEnabled,
        dailyHour: result.dailyHour,
        dailyMinute: result.dailyMinute,
      );
      setState(() {
        _dailyNotificationsEnabled = result.dailyEnabled;
        _inactiveNotificationsEnabled = result.inactiveEnabled;
        _dailyNotificationHour = result.dailyHour;
        _dailyNotificationMinute = result.dailyMinute;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification preferences saved.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save notification preferences.'),
        ),
      );
    }
  }

  Widget _sectionLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _settingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool danger = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.96)
        : Colors.white.withValues(alpha: 0.9);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.06);
    final baseTextColor = isDark ? colorScheme.onSurface : Colors.black87;
    final iconBg = danger
        ? const Color(0xFFFFE7E7)
        : colorScheme.primary.withValues(alpha: 0.12);
    final iconColor = danger ? const Color(0xFFB42318) : colorScheme.primary;
    final textColor = danger ? const Color(0xFFB42318) : baseTextColor;
    final subtitleColor = danger
        ? const Color(0xFFB42318).withValues(alpha: 0.8)
        : baseTextColor.withValues(alpha: 0.8);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor.withValues(
                            alpha: onTap == null ? 0.7 : 1,
                          ),
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle, style: TextStyle(color: subtitleColor)),
                      ],
                    ],
                  ),
                ),
                if (trailing != null)
                  IconTheme(
                    data: IconThemeData(
                      color: danger
                          ? const Color(0xFFB42318).withValues(alpha: 0.9)
                          : baseTextColor.withValues(alpha: 0.7),
                    ),
                    child: trailing,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final profileStream = user == null
        ? null
        : FirebaseDatabase.instance.ref('users/${user.uid}').onValue;

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.96)
        : Colors.white.withValues(alpha: 0.9);
    final panelBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.06);
    final panelTextColor = isDark ? colorScheme.onSurface : Colors.black87;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withValues(alpha: 0.18),
                colorScheme.secondary.withValues(alpha: 0.12),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.tune, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsPreferencesTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(l10n.settingsPreferencesBody),
                  ],
                ),
              ),
            ],
          ),
        ),
        _sectionLabel(context, 'Account'),
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
                _settingsTile(
                  context: context,
                  icon: Icons.account_circle_outlined,
                  title: 'Profile photo',
                  subtitle: 'Add or remove your avatar.',
                  onTap: _openAvatarSheet,
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
                _settingsTile(
                  context: context,
                  icon: Icons.badge_outlined,
                  title: 'Display name',
                  subtitle: displayName,
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => _editDisplayName(displayName),
                ),
                _settingsTile(
                  context: context,
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: email ?? user?.email ?? 'Unknown',
                  trailing: Icon(
                    canUpdate ? Icons.edit_outlined : Icons.lock_outline,
                  ),
                  onTap: canUpdate
                      ? () => _editEmail(email ?? user?.email, username)
                      : null,
                ),
                _settingsTile(
                  context: context,
                  icon: Icons.lock_outline,
                  title: 'Password',
                  subtitle: canUpdate
                      ? 'Update your password.'
                      : 'Managed by your sign-in provider.',
                  trailing: Icon(
                    canUpdate ? Icons.edit_outlined : Icons.lock_outline,
                  ),
                  onTap: canUpdate ? _editPassword : null,
                ),
                _settingsTile(
                  context: context,
                  icon: Icons.delete_forever_outlined,
                  title: l10n.deleteAccountActionLabel,
                  subtitle: l10n.deleteAccountSettingsSubtitle,
                  danger: true,
                  trailing: _isDeletingAccount
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: _isDeletingAccount ? null : _deleteAccount,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        _sectionLabel(context, 'App'),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: panelBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: panelTextColor,
                ),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: widget.themeModeNotifier,
                builder: (context, mode, _) {
                  return DropdownButtonFormField<ThemeMode>(
                    initialValue: mode,
                    style: TextStyle(color: panelTextColor),
                    dropdownColor: panelColor,
                    iconEnabledColor: panelTextColor.withValues(alpha: 0.8),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: panelTextColor.withValues(alpha: 0.25),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
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
        _settingsTile(
          context: context,
          icon: Icons.notifications_outlined,
          title: l10n.settingsNotificationsTitle,
          subtitle: _notificationSummary(
            dailyEnabled: _dailyNotificationsEnabled,
            inactiveEnabled: _inactiveNotificationsEnabled,
            dailyHour: _dailyNotificationHour,
            dailyMinute: _dailyNotificationMinute,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _openNotificationSettings(
            dailyEnabled: _dailyNotificationsEnabled,
            inactiveEnabled: _inactiveNotificationsEnabled,
            dailyHour: _dailyNotificationHour,
            dailyMinute: _dailyNotificationMinute,
          ),
        ),
        const SizedBox(height: 8),
        _sectionLabel(context, l10n.settingsLanguageTitle),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: panelBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settingsLanguageBody,
                style: TextStyle(color: panelTextColor),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<Locale?>(
                valueListenable: widget.localeNotifier,
                builder: (context, locale, _) {
                  return DropdownButtonFormField<Locale?>(
                    initialValue: locale,
                    style: TextStyle(color: panelTextColor),
                    dropdownColor: panelColor,
                    iconEnabledColor: panelTextColor.withValues(alpha: 0.8),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: panelTextColor.withValues(alpha: 0.25),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
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
      ],
    );
  }
}

class _NotificationPrefsDraft {
  const _NotificationPrefsDraft({
    required this.dailyEnabled,
    required this.inactiveEnabled,
    required this.dailyHour,
    required this.dailyMinute,
  });

  final bool dailyEnabled;
  final bool inactiveEnabled;
  final int dailyHour;
  final int dailyMinute;

  _NotificationPrefsDraft copyWith({
    bool? dailyEnabled,
    bool? inactiveEnabled,
    int? dailyHour,
    int? dailyMinute,
  }) {
    return _NotificationPrefsDraft(
      dailyEnabled: dailyEnabled ?? this.dailyEnabled,
      inactiveEnabled: inactiveEnabled ?? this.inactiveEnabled,
      dailyHour: dailyHour ?? this.dailyHour,
      dailyMinute: dailyMinute ?? this.dailyMinute,
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
  const _BodyAwarenessContent({this.onCompleted, this.onSkipped});

  final Future<void> Function()? onCompleted;
  final Future<void> Function()? onSkipped;

  @override
  State<_BodyAwarenessContent> createState() => _BodyAwarenessContentState();
}

class _BodyAwarenessContentState extends State<_BodyAwarenessContent> {
  final Map<String, _BodyAwarenessPoint> _pointsBySide = {};
  final Map<String, String> _regionsBySide = {};
  String _selectedSide = 'front';
  Color _selectedColor = const Color(0xFFF2A55A);
  bool _isSaving = false;
  bool _isOpeningMonster = false;
  _BodyRegionMask? _bodyRegionMask;

  _BodyAwarenessPoint? get _point => _pointsBySide[_selectedSide];
  String? get _selectedRegion => _regionsBySide[_selectedSide];

  @override
  void initState() {
    super.initState();
    _initBodyRegionMask();
  }

  Future<void> _initBodyRegionMask() async {
    final mask = await _BodyRegionMask.load();
    if (!mounted || mask == null) return;
    setState(() {
      _bodyRegionMask = mask;
    });
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

  String _selectedActivityKey() {
    return MonsterManifestService.mapRegionToActivity(
      _selectedRegion ?? 'outside',
    );
  }

  bool _requiresJoinPrompt(String? region) {
    return region != null && region != 'outside';
  }

  Future<bool> _confirmJoinExercise() async {
    final shouldJoin = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cookie Monster'),
          content: const Text('Join me, would you?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Skip'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Join'),
            ),
          ],
        );
      },
    );
    return shouldJoin ?? false;
  }

  Future<bool> _confirmOutsidePrompt() async {
    final choice = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Skip'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Reflect'),
            ),
          ],
        );
      },
    );
    return choice ?? false;
  }

  Future<String?> _askExperienceFeedback() async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('How was this experience for you?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop('positive'),
              child: const Text('Positive: dance'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop('neutral'),
              child: const Text('Neutral: meeeehhhhhh'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop('negative'),
              child: const Text('Negative: fall down'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _recordExperienceFeedback(
    String uid,
    DateTime now,
    String? feedback,
  ) async {
    if (feedback == null || feedback.isEmpty) return;
    await FirebaseDatabase.instance
        .ref('users/$uid/body_awareness/${_dateKey(now)}/feedback')
        .set({'value': feedback, 'createdAt': now.toIso8601String()});
  }

  Future<void> _playSelectedMonster({
    String? overrideActivityKey,
    bool requireSelection = true,
  }) async {
    if (_isOpeningMonster) return;
    final region = _selectedRegion;
    if (requireSelection && region == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a body area first.')),
      );
      return;
    }

    setState(() {
      _isOpeningMonster = true;
    });

    try {
      final activityKey = overrideActivityKey ?? _selectedActivityKey();
      final plan = await MonsterManifestService.instance.resolvePlaybackPlan(
        activityKey,
        platform: Theme.of(context).platform,
      );
      if (plan == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No clip found for "$activityKey".')),
        );
        return;
      }

      final urls = await _resolvePlaybackUrls(plan);
      if (!mounted) return;
      await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          fullscreenDialog: false,
          builder: (context) => _MonsterPlaybackPage(
            activityKey: activityKey,
            plan: plan,
            urls: urls,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load monster clip: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isOpeningMonster = false;
        });
      }
    }
  }

  Future<_MonsterPlaybackUrls> _resolvePlaybackUrls(
    MonsterPlaybackPlan plan,
  ) async {
    if (plan.type == MonsterPlaybackType.single) {
      final singlePath = plan.singlePath;
      if (singlePath == null) {
        throw StateError(
          'Single clip path is missing for ${plan.activityKey}.',
        );
      }
      final singleUrl = await MonsterManifestService.instance
          .downloadUrlForStoragePath(singlePath);
      return _MonsterPlaybackUrls(single: singleUrl);
    }

    final introPath = plan.introPath;
    final loopPath = plan.loopPath;
    final outroPath = plan.outroPath;
    if (introPath == null || loopPath == null || outroPath == null) {
      throw StateError(
        'Triple clip paths are missing for ${plan.activityKey}.',
      );
    }
    final intro = await MonsterManifestService.instance
        .downloadUrlForStoragePath(introPath);
    final loop = await MonsterManifestService.instance
        .downloadUrlForStoragePath(loopPath);
    final outro = await MonsterManifestService.instance
        .downloadUrlForStoragePath(outroPath);
    return _MonsterPlaybackUrls(intro: intro, loop: loop, outro: outro);
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
            'activityKey': MonsterManifestService.mapRegionToActivity(
              _selectedRegion ?? 'outside',
            ),
            'createdAt': now.toIso8601String(),
          });
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness_history/${_dateKey(now)}')
          .push()
          .set({
            'x': point.x,
            'y': point.y,
            'color': point.color.toARGB32(),
            'region': _selectedRegion ?? 'outside',
            'side': _selectedSide,
            'activityKey': MonsterManifestService.mapRegionToActivity(
              _selectedRegion ?? 'outside',
            ),
            'createdAt': now.toIso8601String(),
          });
      if (!mounted) return;
      if (_requiresJoinPrompt(_selectedRegion)) {
        final shouldJoin = await _confirmJoinExercise();
        if (!mounted) return;
        if (shouldJoin) {
          await _playSelectedMonster(
            overrideActivityKey: '06_will_you_join',
            requireSelection: false,
          );
          if (!mounted) return;
          await _playSelectedMonster();
        }
      }
      if (!mounted) return;
      final feedback = await _askExperienceFeedback();
      if (!mounted) return;
      await _recordExperienceFeedback(user.uid, now, feedback);
      if (widget.onCompleted != null) {
        await widget.onCompleted!.call();
      }
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

  Future<void> _skipStep() async {
    if (widget.onSkipped != null) {
      await widget.onSkipped!.call();
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Step skipped.')));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final compactHeight = media.size.height < 520;
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 1000
                ? 36.0
                : 20.0;
            final verticalPadding = constraints.maxHeight >= 700 ? 24.0 : 12.0;
            Widget bodyMap = Stack(
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
                              if (region == 'outside') {
                                _confirmOutsidePrompt().then((reflect) async {
                                  if (!mounted) return;
                                  if (!reflect) {
                                    await _skipStep();
                                  }
                                });
                                return;
                              }
                              final activityKey =
                                  MonsterManifestService.mapRegionToActivity(
                                    region,
                                  );
                              debugPrint(
                                'Body awareness tap: $region -> $activityKey',
                              );
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
            );

            Widget actions = LayoutBuilder(
              builder: (context, actionConstraints) {
                final wideActions = actionConstraints.maxWidth >= 540;
                if (wideActions) {
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: (_isSaving || _isOpeningMonster)
                              ? null
                              : _skipStep,
                          child: const Text('Skip'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (_isSaving || _isOpeningMonster)
                              ? null
                              : _save,
                          child: Text(
                            (_isSaving || _isOpeningMonster)
                                ? 'Loading...'
                                : 'Save',
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Wrap(
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      width: actionConstraints.maxWidth,
                      child: OutlinedButton(
                        onPressed: (_isSaving || _isOpeningMonster)
                            ? null
                            : _skipStep,
                        child: const Text('Skip'),
                      ),
                    ),
                    SizedBox(
                      width: actionConstraints.maxWidth,
                      child: ElevatedButton(
                        onPressed: (_isSaving || _isOpeningMonster)
                            ? null
                            : _save,
                        child: Text(
                          (_isSaving || _isOpeningMonster)
                              ? 'Loading...'
                              : 'Save',
                        ),
                      ),
                    ),
                  ],
                );
              },
            );

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Where does this feeling seem to rest in your body?\n'
                    'Please touch that spot and select a color that feels true '
                    'to the sensation.',
                    style: TextStyle(
                      color: textColor,
                      fontSize: compactHeight ? 14 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: compactHeight ? 8 : 16),
                  Expanded(child: bodyMap),
                  SizedBox(height: isLandscape ? 8 : 16),
                  actions,
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (_isSaving || _isOpeningMonster)
                          ? null
                          : _skipStep,
                      child: const Text('Skip to quote'),
                    ),
                  ),
                ],
              ),
            );
          },
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

class _MonsterPlaybackUrls {
  const _MonsterPlaybackUrls({this.single, this.intro, this.loop, this.outro});

  final String? single;
  final String? intro;
  final String? loop;
  final String? outro;
}

class _MonsterPlaybackPage extends StatefulWidget {
  const _MonsterPlaybackPage({
    required this.activityKey,
    required this.plan,
    required this.urls,
  });

  final String activityKey;
  final MonsterPlaybackPlan plan;
  final _MonsterPlaybackUrls urls;

  @override
  State<_MonsterPlaybackPage> createState() => _MonsterPlaybackPageState();
}

class _MonsterPlaybackPageState extends State<_MonsterPlaybackPage> {
  static const Map<String, String> _exerciseInstructions = {
    '06_will_you_join':
        'Would you like to join Cookie Monster for a short exercise?',
    '07_outside_the_body':
        'When you imagine a place where you feel at ease, what physical sensations do you notice in your body?',
    '08_forehead_contact':
        'Forehead Contact:\nPlace your palm on your forehead, hold for a few seconds, and relax with your breath.',
    '09_slow_breathing':
        'Close Eyes - Breath Tracking:\nClose your eyes, inhale slowly through your nose, and exhale in 4 seconds (repeat 5 times).',
    '10_weight_of_the_head':
        'Feel the Weight of Your Head:\nGently tilt your head forward, notice neck tension, and relax it.',
    '11_breathing':
        '4-7-8 Breathing:\nInhale for 4 seconds, hold for 7, exhale for 8 (3 cycles).',
    '12_abdominal_awareness':
        'Abdominal Awareness:\nPlace your hand on your abdomen and feel it rise and fall with each breath.',
    '13_heart_center':
        'Heart Center Opening:\nMove your chest forward, pull shoulders back, and breathe deeply.',
    '14_ball_squeezing':
        'Ball Squeezing:\nSlowly squeeze and release your palm (10 repetitions).',
    '15_finger_meditation':
        'Finger Meditation:\nTouch each finger with your thumb one by one, exhaling with every touch.',
    '16_hand_massage':
        'Hand Massage:\nMassage the center of your palm with your thumb in small circles (30 seconds each hand).',
    '17_shoulder_drop':
        'Shoulder Drop:\nRaise shoulders toward ears, then release (5 repetitions).',
    '18_back_opening':
        'Back Opening:\nClasp hands behind you, open the chest, and take a deep breath.',
    '19_releasing_burden':
        'Releasing Burdens:\nWith eyes closed, imagine a warm light flowing down from your shoulders.',
    '20_relaxing_facial_muscles':
        'Relaxing Facial Muscles:\nClose eyes, tighten facial muscles, then release (3 repetitions).',
    '21_jaw_drop':
        'Jaw Drop:\nSlightly open your mouth, relax jaw for 5 seconds, then close it.',
    '22_smile_to_yourself':
        'Smile to Yourself:\nHold a gentle smile for 30 seconds.',
    '23_eft_tapping_points':
        'EFT Tapping Points:\nTap each point 5-7 times: eyebrow start, side of eye, under eye, under nose, chin, collarbone, under arm, top of head.',
    '24_rising_on_tiptoes':
        'Rising on Tiptoes:\nLift heels as you exhale, hold 3-5 seconds, lower slowly, and repeat 5-10 times.',
  };

  VideoPlayerController? _monsterController;
  VideoPlayerController? _backgroundController;
  bool _isBusy = true;
  bool _showFinish = false;
  bool _finishing = false;
  bool _closed = false;

  String? get _instructionText => _exerciseInstructions[widget.activityKey];

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  @override
  void dispose() {
    _closed = true;
    _disposeController();
    super.dispose();
  }

  Future<void> _disposeController() async {
    final monster = _monsterController;
    final background = _backgroundController;
    _monsterController = null;
    _backgroundController = null;
    if (monster != null) {
      await monster.dispose();
    }
    if (background != null) {
      await background.dispose();
    }
  }

  Future<void> _ensureBackgroundVideo() async {
    if (_backgroundController != null) return;
    try {
      final bg = VideoPlayerController.asset(
        'assets/monster/colored_moving_background.mp4',
      );
      _backgroundController = bg;
      await bg.initialize();
      await bg.setLooping(true);
      await bg.play();
      if (!mounted || _closed) return;
      setState(() {});
    } catch (error) {
      debugPrint('Background video failed to initialize: $error');
    }
  }

  Future<void> _start() async {
    try {
      await _ensureBackgroundVideo();
      if (widget.plan.type == MonsterPlaybackType.single) {
        final single = widget.urls.single;
        if (single == null) {
          _closeWithError('Single clip URL is missing.');
          return;
        }
        await _playUrl(single, looping: true);
        if (!mounted || _closed) return;
        setState(() {
          _isBusy = false;
          _showFinish = true;
        });
        return;
      }
      final loop = widget.urls.loop;
      if (loop == null) {
        _closeWithError('Exercise clips are missing.');
        return;
      }
      await _playUrl(loop, looping: true);
      if (!mounted || _closed) return;
      setState(() {
        _isBusy = false;
        _showFinish = true;
      });
    } catch (error) {
      _closeWithError(
        'Video player failed to initialize. Please fully restart the app.',
      );
      debugPrint('Monster playback start failed: $error');
    }
  }

  Future<void> _playUrl(
    String url, {
    required bool looping,
    Future<void> Function()? onEnded,
  }) async {
    final previous = _monsterController;
    _monsterController = null;
    if (previous != null) {
      await previous.dispose();
    }
    final viewType = Platform.isIOS
        ? VideoViewType.platformView
        : VideoViewType.textureView;
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(url),
      viewType: viewType,
    );
    _monsterController = controller;
    await controller.initialize();
    await controller.setLooping(looping);
    if (onEnded != null) {
      var endedCalled = false;
      controller.addListener(() {
        if (!controller.value.isInitialized) return;
        if (_closed) return;
        if (controller.value.isPlaying) return;
        if (endedCalled) return;
        if (controller.value.position >= controller.value.duration) {
          endedCalled = true;
          onEnded();
        }
      });
    }
    await controller.play();
    if (!mounted || _closed) return;
    setState(() {});
  }

  Future<void> _finishExercise() async {
    if (_finishing) return;
    _finishing = true;
    final outro = widget.urls.outro;
    if (outro == null) {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      return;
    }
    try {
      await _playUrl(
        outro,
        looping: false,
        onEnded: () async {
          if (!mounted || _closed) return;
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      );
      if (!mounted || _closed) return;
      setState(() {
        _isBusy = false;
        _showFinish = false;
      });
    } catch (error) {
      _finishing = false;
      _closeWithError('Failed to play outro clip.');
      debugPrint('Monster playback outro failed: $error');
    }
  }

  void _closeWithError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final monster = _monsterController;
    final background = _backgroundController;
    final monsterReady = monster?.value.isInitialized ?? false;
    final backgroundReady = background?.value.isInitialized ?? false;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: backgroundReady
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: background!.value.size.width,
                        height: background.value.size.height,
                        child: VideoPlayer(background),
                      ),
                    )
                  : const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFF1A1624)),
                    ),
            ),
            Positioned.fill(
              child: monsterReady
                  ? FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: monster!.value.size.width,
                        height: monster.value.size.height,
                        child: VideoPlayer(monster),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            if (_showFinish)
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_instructionText != null) ...[
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxHeight: 220),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _instructionText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    ElevatedButton(
                      onPressed: _isBusy ? null : _finishExercise,
                      child: const Text('Finish exercise'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
