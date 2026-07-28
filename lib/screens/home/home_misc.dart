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
  bool _dailyNotificationsEnabled = false;
  bool _inactiveNotificationsEnabled = false;
  int _dailyNotificationHour = 9;
  int _dailyNotificationMinute = 0;
  Stream<DatabaseEvent>? _profileStream;

  @override
  void initState() {
    super.initState();
    // Created once: building the stream inside build() would resubscribe on
    // every setState and blank the profile fields while it reconnects.
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _profileStream = FirebaseDatabase.instance
          .ref('users/${user.uid}')
          .onValue;
    }
    _loadNotificationPreferences();
  }

  Future<void> _loadNotificationPreferences() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final DataSnapshot snap;
    try {
      snap = await FirebaseDatabase.instance
          .ref('users/$uid/notificationPrefs')
          .get();
    } catch (_) {
      return; // Keep the defaults; the sheet re-reads on save anyway.
    }
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
    if (locale.languageCode == 'sr') {
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
    final l10n = AppLocalizations.of(context)!;

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
      await FirebaseDatabase.instance.ref('users/${user.uid}').update({
        'avatarUrl': url,
        'avatarAssetPath': null,
        'avatarDefaultDismissed': null,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarUpdated)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarUpdateFailed)));
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
    final l10n = AppLocalizations.of(context)!;

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
      await FirebaseDatabase.instance.ref('users/${user.uid}').update({
        'avatarUrl': null,
        'avatarAssetPath': null,
        'avatarDefaultDismissed': true,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarRemoved)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarRemoveFailed)));
    } finally {
      if (mounted) {
        setState(() {
          _isAvatarBusy = false;
        });
      }
    }
  }

  Future<void> _selectBundledAvatar(String assetPath) async {
    if (_isAvatarBusy) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isAvatarBusy = true;
    });

    try {
      await FirebaseDatabase.instance.ref('users/${user.uid}').update({
        'avatarAssetPath': assetPath,
        'avatarDefaultDismissed': null,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarUpdated)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.avatarUpdateFailed)));
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
    final l10n = AppLocalizations.of(context)!;
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
      ).showSnackBar(SnackBar(content: Text(l10n.nameUpdated)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.nameUpdateFailed)));
    }
  }

  Future<void> _editDisplayName(String? currentName) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: currentName ?? '');
    try {
      final result = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.editNameTitle),
            content: TextField(
              controller: controller,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: l10n.fullNameLabel),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancelLabel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: Text(l10n.saveLabel),
              ),
            ],
          );
        },
      );
      if (result == null) return;
      await _updateDisplayName(result);
    } finally {
      controller.dispose();
    }
  }

  bool _canUpdateCredentials(User? user) {
    return user?.providerData.any(
          (provider) => provider.providerId == 'password',
        ) ??
        false;
  }

  Future<bool> _reauthenticatePasswordUser(User user, {String? title}) async {
    final l10n = AppLocalizations.of(context)!;
    final email = user.email?.trim();
    if (email == null || email.isEmpty) return false;

    final controller = TextEditingController();
    try {
      bool obscure = true;
      final password = await showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(title ?? l10n.confirmPasswordLabel),
                content: TextField(
                  controller: controller,
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
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: Text(l10n.confirmLabel),
                  ),
                ],
              );
            },
          );
        },
      );
      if (password == null || password.isEmpty) return false;

      // Passwords are stored exactly as typed at registration — never trim,
      // or accounts whose password has an edge space can't re-authenticate.
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      return true;
    } finally {
      controller.dispose();
    }
  }

  String? _validatePassword(String value) {
    final l10n = AppLocalizations.of(context)!;
    // Validate the raw value — registration and login never trim passwords.
    if (value.length < 8) return l10n.passwordMustBeAtLeast8;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(value);
    final hasNumber = RegExp(r'\d').hasMatch(value);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasUpper || !hasNumber || !hasSpecial) {
      return l10n.passwordRequirementsSummary;
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
    final l10n = AppLocalizations.of(context)!;
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) return;
    final currentEmail = user.email?.trim();
    if (currentEmail != null &&
        currentEmail.isNotEmpty &&
        currentEmail.toLowerCase() == trimmed.toLowerCase()) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.emailUnchanged)));
      return;
    }
    try {
      await user.verifyBeforeUpdateEmail(trimmed);
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/pendingEmail')
          .set(trimmed);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.verificationEmailSentNewAddress)),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'requires-recent-login' && allowReauthRetry) {
        try {
          final reauthed = await _reauthenticatePasswordUser(
            user,
            title: l10n.reauthenticateToUpdateEmail,
          );
          if (!reauthed) return;
          await _updateEmail(email, username, allowReauthRetry: false);
          return;
        } on FirebaseAuthException {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.reauthenticationFailed)));
          return;
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.reauthenticationFailed)));
          return;
        }
      }
      final message = l10n.emailUpdateFailed;
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.emailUpdateFailed)));
    }
  }

  Future<void> _editEmail(String? currentEmail, String? username) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: currentEmail ?? '');
    try {
      final result = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.editEmailTitle),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: l10n.emailLabel),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancelLabel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: Text(l10n.saveLabel),
              ),
            ],
          );
        },
      );
      if (result == null) return;
      await _updateEmail(result, username);
    } finally {
      controller.dispose();
    }
  }

  Future<void> _updatePassword(
    String value, {
    bool allowReauthRetry = true,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final l10n = AppLocalizations.of(context)!;
    final validation = _validatePassword(value);
    if (validation != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validation)));
      return;
    }
    try {
      await user.updatePassword(value);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.passwordUpdated)));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'requires-recent-login' && allowReauthRetry) {
        try {
          final reauthed = await _reauthenticatePasswordUser(
            user,
            title: l10n.reauthenticateToUpdatePassword,
          );
          if (!reauthed) return;
          await _updatePassword(value, allowReauthRetry: false);
          return;
        } on FirebaseAuthException {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.reauthenticationFailed)));
          return;
        } catch (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.reauthenticationFailed)));
          return;
        }
      }
      final message = l10n.passwordUpdateFailed;
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.passwordUpdateFailed)));
    }
  }

  Future<void> _editPassword() async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final confirmController = TextEditingController();
    try {
      bool obscure = true;
      bool obscureConfirm = true;
      String? validationMessage;
      final result = await showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(l10n.changePasswordTitle),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      obscureText: obscure,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.newPasswordLabel,
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
                        labelText: l10n.confirmPasswordLabel,
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
                            l10n.passwordRequirementsSummaryShort,
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
                    child: Text(l10n.cancelLabel),
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
                          validationMessage = l10n.passwordsDoNotMatch;
                        });
                        return;
                      }
                      Navigator.pop(context, password);
                    },
                    child: Text(l10n.saveLabel),
                  ),
                ],
              );
            },
          );
        },
      );
      if (result == null) return;
      await _updatePassword(result);
    } finally {
      controller.dispose();
      confirmController.dispose();
    }
  }

  void _openAvatarSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.face_retouching_natural),
                title: Text(l10n.chooseAvatarLabel),
                onTap: () {
                  Navigator.pop(context);
                  _openBundledAvatarSheet();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(l10n.takePhotoLabel),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.chooseFromGalleryLabel),
                onTap: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.removePhotoLabel),
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

  void _openBundledAvatarSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.avatarPickerTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bundledAvatars.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    final avatar = bundledAvatars[index];
                    return Tooltip(
                      message: avatar.label,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          Navigator.pop(context);
                          _selectBundledAvatar(avatar.assetPath);
                        },
                        child: CircleAvatar(
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundImage: AssetImage(avatar.assetPath),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
        try {
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
          if (password == null || password.isEmpty) {
            return;
          }
          final credential = EmailAuthProvider.credential(
            email: email,
            password: password,
          );
          await user.reauthenticateWithCredential(credential);
        } finally {
          passwordController.dispose();
        }
      } else if (providerIds.contains('google.com')) {
        // Re-authenticate BEFORE deleting any data; otherwise user.delete()
        // can fail with requires-recent-login after the profile is gone,
        // leaving a half-deleted account.
        await user.reauthenticateWithProvider(GoogleAuthProvider());
      } else if (providerIds.contains('apple.com')) {
        await user.reauthenticateWithProvider(AppleAuthProvider());
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

      // List separately per folder: storage.rules only grant read/list inside
      // drawings/ and avatars/, so listing users/{uid} itself is denied and
      // would silently delete nothing.
      for (final folder in ['drawings', 'avatars']) {
        try {
          await _deleteStoragePathRecursively(
            FirebaseStorage.instance.ref('users/${user.uid}/$folder'),
          );
        } catch (_) {}
      }

      await userRef.remove();
      if (username != null) {
        await FirebaseDatabase.instance
            .ref('usernames/${safeKey(username)}')
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
    required BuildContext context,
    required bool dailyEnabled,
    required bool inactiveEnabled,
    required int dailyHour,
    required int dailyMinute,
  }) {
    final l10n = AppLocalizations.of(context)!;
    if (!dailyEnabled && !inactiveEnabled) {
      return l10n.notificationsOffSummary;
    }
    final hh = dailyHour.toString().padLeft(2, '0');
    final mm = dailyMinute.toString().padLeft(2, '0');
    if (dailyEnabled && inactiveEnabled) {
      return l10n.notificationsDailyAndInactiveSummary(hh, mm);
    }
    if (dailyEnabled) {
      return l10n.notificationsDailyOnlySummary(hh, mm);
    }
    return l10n.notificationsInactiveOnlySummary;
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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.settingsNotificationsTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.dailyReminderTitle),
                    subtitle: Text(l10n.dailyReminderSubtitle),
                    value: draft.dailyEnabled,
                    onChanged: (value) {
                      setState(() {
                        draft = draft.copyWith(dailyEnabled: value);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.reminderTimeTitle),
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
                    title: Text(l10n.inactiveReminderTitle),
                    subtitle: Text(l10n.inactiveReminderSubtitle),
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
                        child: Text(l10n.cancelLabel),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, draft),
                        child: Text(l10n.saveLabel),
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
      if (!mounted) return;
      setState(() {
        _dailyNotificationsEnabled = result.dailyEnabled;
        _inactiveNotificationsEnabled = result.inactiveEnabled;
        _dailyNotificationHour = result.dailyHour;
        _dailyNotificationMinute = result.dailyMinute;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notificationPreferencesSaved)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notificationPreferencesSaveFailed)),
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
        Column(
          children: [
            Image.asset(
              'assets/icons/EN_Co-fundedbytheEU_RGB_POS-scaled.png',
              height: 48,
            ),
            const SizedBox(height: 10),
            Text(
              'Funded by the European Union. Views and opinions expressed are '
              'however those of the author(s) only and do not necessarily '
              'reflect those of the European Union or the European Education '
              'and Culture Executive Agency (EACEA). Neither the European '
              'Union nor EACEA can be held responsible for them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: panelTextColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
        _sectionLabel(context, l10n.accountSectionTitle),
        StreamBuilder<DatabaseEvent>(
          stream: _profileStream,
          builder: (context, snapshot) {
            final value = snapshot.data?.snapshot.value;
            String? avatarUrl;
            String? avatarAssetPath;
            String? fullName;
            String? username;
            String? email;
            if (value is Map) {
              final data = Map<String, dynamic>.from(value);
              final avatarValue = data['avatarUrl'];
              final avatarAssetValue = data['avatarAssetPath'];
              final nameValue = data['fullName'];
              final usernameValue = data['username'];
              final emailValue = data['email'];
              avatarUrl = avatarValue is String ? avatarValue : null;
              avatarAssetPath = avatarAssetValue is String
                  ? avatarAssetValue
                  : null;
              fullName = nameValue is String ? nameValue : null;
              username = usernameValue is String ? usernameValue : null;
              email = emailValue is String ? emailValue : null;
            }
            final canUpdate = _canUpdateCredentials(user);
            final displayName = (fullName != null && fullName.trim().isNotEmpty)
                ? fullName.trim()
                : (user?.displayName ?? l10n.userFallbackName);
            final trimmedAvatarAssetPath = avatarAssetPath?.trim();
            final trimmedAvatarUrl = avatarUrl?.trim();
            final ImageProvider? avatarImage =
                trimmedAvatarAssetPath != null &&
                    trimmedAvatarAssetPath.isNotEmpty
                ? AssetImage(trimmedAvatarAssetPath)
                : trimmedAvatarUrl != null && trimmedAvatarUrl.isNotEmpty
                ? NetworkImage(trimmedAvatarUrl)
                : null;
            return Column(
              children: [
                _settingsTile(
                  context: context,
                  icon: Icons.account_circle_outlined,
                  title: l10n.profilePhotoTitle,
                  subtitle: l10n.profilePhotoSubtitle,
                  onTap: _openAvatarSheet,
                  trailing: _isAvatarBusy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : CircleAvatar(
                          radius: 16,
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.onPrimaryContainer,
                          backgroundImage: avatarImage,
                          child: avatarImage == null
                              ? Text(_fallbackInitial(user))
                              : null,
                        ),
                ),
                _settingsTile(
                  context: context,
                  icon: Icons.badge_outlined,
                  title: l10n.displayNameTitle,
                  subtitle: displayName,
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => _editDisplayName(displayName),
                ),
                _settingsTile(
                  context: context,
                  icon: Icons.email_outlined,
                  title: l10n.emailLabel,
                  subtitle: email ?? user?.email ?? l10n.unknownValueLabel,
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
                  title: l10n.passwordLabel,
                  subtitle: canUpdate
                      ? l10n.passwordUpdateSubtitle
                      : l10n.passwordManagedByProviderSubtitle,
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
        _sectionLabel(context, l10n.appSectionTitle),
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
                l10n.themeTitle,
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
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(l10n.themeSystemLabel),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(l10n.themeLightLabel),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(l10n.themeDarkLabel),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      widget.themeModeNotifier.value = value;
                      final uid = FirebaseAuth.instance.currentUser?.uid;
                      if (uid != null) {
                        unawaited(
                          FirebaseDatabase.instance
                              .ref('users/$uid/themeMode')
                              .set(value.name)
                              .catchError((_) {}),
                        );
                      }
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
            context: context,
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
                    onChanged: (value) {
                      widget.localeNotifier.value = value;
                      final uid = FirebaseAuth.instance.currentUser?.uid;
                      if (uid != null) {
                        final ref = FirebaseDatabase.instance.ref(
                          'users/$uid/locale',
                        );
                        if (value == null) {
                          unawaited(ref.remove().catchError((_) {}));
                        } else {
                          final key = value.scriptCode != null
                              ? '${value.languageCode}_${value.scriptCode}'
                              : value.languageCode;
                          unawaited(ref.set(key).catchError((_) {}));
                        }
                      }
                    },
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
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
  _BodyRegionMask? _bodyRegionMaskFront;
  _BodyRegionMask? _bodyRegionMaskBack;

  _BodyRegionMask? get _bodyRegionMask =>
      _selectedSide == 'back' ? _bodyRegionMaskBack : _bodyRegionMaskFront;

  _BodyAwarenessPoint? get _point => _pointsBySide[_selectedSide];
  String? get _selectedRegion => _regionsBySide[_selectedSide];

  @override
  void initState() {
    super.initState();
    _initBodyRegionMask();
  }

  Future<void> _initBodyRegionMask() async {
    final results = await Future.wait([
      _BodyRegionMask.load(
        assetPath: 'assets/images/Human_body_outline_colored.svg',
        colorToRegion: _BodyRegionMask.frontColorToRegion,
      ),
      _BodyRegionMask.load(
        assetPath: 'assets/images/Human_body_outline_colored_back.svg',
        colorToRegion: _BodyRegionMask.backColorToRegion,
      ),
    ]);
    if (!mounted) return;
    setState(() {
      _bodyRegionMaskFront = results[0];
      _bodyRegionMaskBack = results[1];
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
    final exact = _bodyRegionMask?.regionAt(localPosition, size);
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
    final l10n = AppLocalizations.of(context)!;
    final shouldJoin = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.cookieMonsterTitle),
          content: Text(l10n.cookieMonsterJoinPrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.skipLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.joinLabel),
            ),
          ],
        );
      },
    );
    return shouldJoin ?? false;
  }

  Future<bool> _confirmOutsidePrompt() async {
    final l10n = AppLocalizations.of(context)!;
    final choice = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(l10n.cookieMonsterOutsidePrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.skipLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.reflectLabel),
            ),
          ],
        );
      },
    );
    return choice ?? false;
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

  _MonsterPlaybackUrls _pathsFromPlan(MonsterPlaybackPlan plan) {
    if (plan.type == MonsterPlaybackType.single) {
      return _MonsterPlaybackUrls(single: plan.singlePath);
    }
    return _MonsterPlaybackUrls(
      intro: plan.introPath,
      loop: plan.loopPath,
      outro: plan.outroPath,
    );
  }

  Future<void> _openColorPicker() async {
    final l10n = AppLocalizations.of(context)!;
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
                        Text(
                          l10n.colorLabel,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                        child: Text(l10n.useThisColorLabel),
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
    final l10n = AppLocalizations.of(context)!;
    final point = _point;
    if (point == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tapBodyToLogSensation)));
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now();
      final entryData = {
        'x': point.x,
        'y': point.y,
        'color': point.color.toARGB32(),
        'region': _selectedRegion ?? 'outside',
        'side': _selectedSide,
        'activityKey': MonsterManifestService.mapRegionToActivity(
          _selectedRegion ?? 'outside',
        ),
        'createdAt': now.toIso8601String(),
      };
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness/${_dateKey(now)}')
          .push()
          .set(entryData);
      await FirebaseDatabase.instance
          .ref('users/${user.uid}/body_awareness_history/${_dateKey(now)}')
          .push()
          .set(entryData);
      if (!mounted) return;
      if (_requiresJoinPrompt(_selectedRegion)) {
        final shouldJoin = await _confirmJoinExercise();
        if (!mounted) return;
        if (shouldJoin) {
          setState(() {
            _isOpeningMonster = true;
          });
          try {
            final joinKey = '06_will_you_join';
            final joinPlan = MonsterManifestService.instance
                .resolvePlaybackPlan(
                  joinKey,
                  platform: Theme.of(context).platform,
                );
            if (joinPlan == null || !mounted) return;
            final joinUrls = _pathsFromPlan(joinPlan);
            if (!mounted) return;

            final exerciseKey = _selectedActivityKey();
            final exercisePlan = MonsterManifestService.instance
                .resolvePlaybackPlan(
                  exerciseKey,
                  platform: Theme.of(context).platform,
                );
            _MonsterPlaybackUrls? exerciseUrls;
            if (exercisePlan != null) {
              exerciseUrls = _pathsFromPlan(exercisePlan);
            }
            if (!mounted) return;

            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => _MonsterPlaybackPage(
                  activityKey: joinKey,
                  plan: joinPlan,
                  urls: joinUrls,
                  nextActivityKey: exerciseKey,
                  nextPlan: exercisePlan,
                  nextUrls: exerciseUrls,
                ),
              ),
            );
            if (!mounted) return;
            final feedback = await Navigator.of(context, rootNavigator: true)
                .push<String>(
                  MaterialPageRoute(
                    builder: (context) => const _MonsterFeedbackPage(),
                  ),
                );
            if (!mounted) return;
            await _recordExperienceFeedback(user.uid, now, feedback);
          } catch (error) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.failedToLoadMonsterClip('$error'))),
            );
          } finally {
            if (mounted) {
              setState(() {
                _isOpeningMonster = false;
              });
            }
          }
        }
      } else if (_selectedRegion == 'outside') {
        // The "Reflect" choice at tap time already served as consent, so no
        // join prompt: play the outside-the-body reflection clip directly.
        setState(() {
          _isOpeningMonster = true;
        });
        try {
          final exerciseKey = _selectedActivityKey();
          final exercisePlan = MonsterManifestService.instance
              .resolvePlaybackPlan(
                exerciseKey,
                platform: Theme.of(context).platform,
              );
          if (exercisePlan != null && mounted) {
            final exerciseUrls = _pathsFromPlan(exercisePlan);
            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => _MonsterPlaybackPage(
                  activityKey: exerciseKey,
                  plan: exercisePlan,
                  urls: exerciseUrls,
                ),
              ),
            );
            if (mounted) {
              final feedback = await Navigator.of(context, rootNavigator: true)
                  .push<String>(
                    MaterialPageRoute(
                      builder: (context) => const _MonsterFeedbackPage(),
                    ),
                  );
              if (mounted) {
                await _recordExperienceFeedback(user.uid, now, feedback);
              }
            }
          }
        } catch (error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.failedToLoadMonsterClip('$error'))),
          );
        } finally {
          if (mounted) {
            setState(() {
              _isOpeningMonster = false;
            });
          }
        }
      }
      if (widget.onCompleted != null) {
        await widget.onCompleted!.call();
      }
    } on FirebaseException catch (error) {
      if (!mounted) return;
      final message = error.code.isNotEmpty
          ? l10n.failedToSaveBodyAwarenessWithCode(error.code)
          : l10n.failedToSaveBodyAwareness;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.failedToSaveBodyAwareness)));
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.stepSkipped)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                              final size = constraints.biggest;
                              final region = _detectBodyRegion(offset, size);
                              if (region == 'outside') {
                                _confirmOutsidePrompt().then((reflect) async {
                                  if (!mounted) return;
                                  if (reflect) {
                                    // Record the sensation so Save can log it
                                    // with the outside-the-body activity.
                                    _setPoint(offset, size, region: region);
                                  } else {
                                    await _skipStep();
                                  }
                                });
                                return;
                              }
                              _setPoint(offset, size, region: region);
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
                    label: l10n.colorLabel,
                    icon: Icons.palette_outlined,
                    onTap: _openColorPicker,
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: _BodySideToggleButton(
                    label: _selectedSide == 'front'
                        ? l10n.showBackLabel
                        : l10n.showFrontLabel,
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
                          child: Text(l10n.skipLabel),
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
                                ? l10n.loadingLabel
                                : l10n.saveLabel,
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
                        child: Text(l10n.skipLabel),
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
                              ? l10n.loadingLabel
                              : l10n.saveLabel,
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
                    l10n.bodyAwarenessPrompt,
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
    required this.colorToRegion,
  });

  static const int _svgWidth = 500;
  static const int _svgHeight = 901;

  static const Map<int, String> frontColorToRegion = {
    0xFF0000: 'feet',
    0x000080: 'legs',
    0xFFE680: 'torso',
    0x88AA00: 'chest',
    0x00FF00: 'head',
    0x800080: 'hands',
    0x2B0000: 'arms',
    0x999999: 'shoulders',
    0xFF00FF: 'neck',
  };

  static const Map<int, String> backColorToRegion = {
    0xFF0000: 'feet',
    0x000080: 'legs',
    0xFFE680: 'back',
    0x00FF00: 'head',
    0x800080: 'hands',
    0x2B0000: 'arms',
    0x999999: 'shoulders',
  };

  final int width;
  final int height;
  final Uint8List pixels;
  final Map<int, String> colorToRegion;

  static Future<_BodyRegionMask?> load({
    required String assetPath,
    required Map<int, String> colorToRegion,
  }) async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final keep = _keepColorsFrom(colorToRegion);
      final filtered = _buildMaskSvg(raw, keep);
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
        colorToRegion: colorToRegion,
      );
    } catch (_) {
      return null;
    }
  }

  String? regionAt(Offset localPosition, Size size) {
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
    return _sampleRegion(px, py) ?? 'outside';
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
    for (final entry in colorToRegion.entries) {
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

  static Set<String> _keepColorsFrom(Map<int, String> colorMap) {
    return colorMap.keys.map((c) {
      final hex = c.toRadixString(16).padLeft(6, '0');
      return '#$hex';
    }).toSet();
  }

  static String _buildMaskSvg(String raw, Set<String> keep) {
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
    this.nextActivityKey,
    this.nextPlan,
    this.nextUrls,
  });

  final String activityKey;
  final MonsterPlaybackPlan plan;
  final _MonsterPlaybackUrls urls;
  final String? nextActivityKey;
  final MonsterPlaybackPlan? nextPlan;
  final _MonsterPlaybackUrls? nextUrls;

  @override
  State<_MonsterPlaybackPage> createState() => _MonsterPlaybackPageState();
}

class _MonsterPlaybackPageState extends State<_MonsterPlaybackPage> {
  VideoPlayerController? _monsterController;
  VideoPlayerController? _backgroundController;
  VoidCallback? _monsterEndListener;
  bool _isBusy = true;
  bool _showFinish = false;
  bool _finishing = false;
  bool _closed = false;

  late String _currentActivityKey = widget.activityKey;
  late MonsterPlaybackPlan _currentPlan = widget.plan;
  late _MonsterPlaybackUrls _currentUrls = widget.urls;
  bool _nextConsumed = false;

  String? _instructionText(AppLocalizations l10n) {
    switch (_currentActivityKey) {
      case '01_hello':
        return l10n.homeHowFeelingToday;
      case '06_will_you_join':
        return l10n.exerciseInstructionWillYouJoin;
      case '07_outside_the_body':
        return l10n.exerciseInstructionOutsideTheBody;
      case '08_forehead_contact':
        return l10n.exerciseInstructionForeheadContact;
      case '09_slow_breathing':
        return l10n.exerciseInstructionSlowBreathing;
      case '10_weight_of_the_head':
        return l10n.exerciseInstructionWeightOfHead;
      case '11_breathing':
        return l10n.exerciseInstructionBreathing478;
      case '12_abdominal_awareness':
        return l10n.exerciseInstructionAbdominalAwareness;
      case '13_heart_center':
        return l10n.exerciseInstructionHeartCenter;
      case '14_ball_squeezing':
        return l10n.exerciseInstructionBallSqueezing;
      case '15_finger_meditation':
        return l10n.exerciseInstructionFingerMeditation;
      case '16_hand_massage':
        return l10n.exerciseInstructionHandMassage;
      case '17_shoulder_drop':
        return l10n.exerciseInstructionShoulderDrop;
      case '18_back_opening':
        return l10n.exerciseInstructionBackOpening;
      case '19_releasing_burden':
        return l10n.exerciseInstructionReleasingBurdens;
      case '20_relaxing_facial_muscles':
        return l10n.exerciseInstructionRelaxingFacialMuscles;
      case '21_jaw_drop':
        return l10n.exerciseInstructionJawDrop;
      case '22_smile_to_yourself':
        return l10n.exerciseInstructionSmileToYourself;
      case '23_eft_tapping_points':
        return l10n.exerciseInstructionEftTappingPoints;
      case '24_rising_on_tiptoes':
        return l10n.exerciseInstructionRisingOnTiptoes;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _closed) return;
      unawaited(_start());
    });
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
    final listener = _monsterEndListener;
    _monsterController = null;
    _backgroundController = null;
    _monsterEndListener = null;
    if (monster != null) {
      if (listener != null) monster.removeListener(listener);
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
        'assets/monster_clips/00_colored_moving_background/colored_moving_background.mp4',
      );
      _backgroundController = bg;
      await bg.initialize();
      await bg.setLooping(true);
      await bg.play();
      if (!mounted || _closed) return;
      setState(() {});
    } catch (_) {}
  }

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Start background video in parallel — don't block the monster clip.
      unawaited(_ensureBackgroundVideo());

      if (_currentPlan.type == MonsterPlaybackType.single) {
        final single = _currentUrls.single;
        if (single == null) {
          _closeWithError(l10n.singleClipUrlMissing);
          return;
        }
        final isHello = _currentActivityKey == '01_hello';
        await _playUrl(
          single,
          looping: !isHello,
          onEnded: isHello
              ? () async {
                  _afterFinish();
                }
              : null,
        );
        if (!mounted || _closed) return;
        setState(() {
          _isBusy = false;
          _showFinish = !isHello;
        });
        return;
      }
      final loop = _currentUrls.loop;
      if (loop == null) {
        _closeWithError(l10n.exerciseClipsMissing);
        return;
      }

      // Triple clips play intro once, then the loop until the user finishes
      // (the outro plays from _finishExercise). Fall back to the loop alone
      // if the intro asset is missing.
      final intro = _currentUrls.intro;
      var introStarted = false;
      if (intro != null) {
        try {
          await _playUrl(
            intro,
            looping: false,
            onEnded: () async {
              if (!mounted || _closed) return;
              try {
                await _playUrl(loop, looping: true);
                if (!mounted || _closed) return;
                setState(() {
                  _showFinish = true;
                });
              } catch (_) {
                if (!mounted || _closed) return;
                _closeWithError(l10n.videoPlayerInitializationFailed);
              }
            },
          );
          introStarted = true;
        } catch (_) {
          introStarted = false;
        }
      }
      if (!introStarted) {
        await _playUrl(loop, looping: true);
      }
      if (!mounted || _closed) return;
      setState(() {
        _isBusy = false;
        _showFinish = !introStarted;
      });
    } catch (error) {
      _closeWithError(l10n.videoPlayerInitializationFailed);
    }
  }

  Future<void> _playUrl(
    String url, {
    required bool looping,
    Future<void> Function()? onEnded,
  }) async {
    final previous = _monsterController;
    final oldListener = _monsterEndListener;
    _monsterController = null;
    _monsterEndListener = null;
    if (previous != null) {
      if (oldListener != null) previous.removeListener(oldListener);
      await previous.dispose();
    }
    final controller = VideoPlayerController.asset(
      url,
      viewType: Platform.isIOS
          ? VideoViewType.platformView
          : VideoViewType.textureView,
    );
    _monsterController = controller;
    await controller.initialize();
    await controller.setLooping(looping);
    if (onEnded != null) {
      var endedCalled = false;
      _monsterEndListener = () {
        if (!controller.value.isInitialized) return;
        if (_closed) return;
        if (controller.value.isPlaying) return;
        if (endedCalled) return;
        if (controller.value.position >= controller.value.duration) {
          endedCalled = true;
          onEnded();
        }
      };
      controller.addListener(_monsterEndListener!);
    }
    await controller.play();
    if (!mounted || _closed) return;
    setState(() {});
  }

  void _afterFinish() {
    if (!mounted || _closed) return;
    final nextPlan = widget.nextPlan;
    final nextUrls = widget.nextUrls;
    final nextKey = widget.nextActivityKey;
    if (!_nextConsumed &&
        nextPlan != null &&
        nextUrls != null &&
        nextKey != null) {
      _nextConsumed = true;
      setState(() {
        _currentActivityKey = nextKey;
        _currentPlan = nextPlan;
        _currentUrls = nextUrls;
        _isBusy = true;
        _showFinish = false;
        _finishing = false;
      });
      unawaited(_start());
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _finishExercise() async {
    final l10n = AppLocalizations.of(context)!;
    if (_finishing) return;
    _finishing = true;
    final outro = _currentUrls.outro;
    if (outro == null) {
      _afterFinish();
      return;
    }
    try {
      await _playUrl(
        outro,
        looping: false,
        onEnded: () async {
          _afterFinish();
        },
      );
      if (!mounted || _closed) return;
      setState(() {
        _isBusy = false;
        _showFinish = false;
      });
    } catch (error) {
      _finishing = false;
      _closeWithError(l10n.failedToPlayOutroClip);
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
    final l10n = AppLocalizations.of(context)!;
    final monster = _monsterController;
    final background = _backgroundController;
    final instructionText = _instructionText(l10n);
    final monsterReady = monster?.value.isInitialized ?? false;
    final backgroundReady = background?.value.isInitialized ?? false;
    final isHello = _currentActivityKey == '01_hello';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Layer 1: Background video
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
            // Layer 2: Instruction text (behind monster)
            if ((_showFinish || isHello) && instructionText != null)
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: isHello
                      ? null
                      : BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(12),
                        ),
                  child: Text(
                    instructionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlaypenSans',
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: isHello ? 29.0 : 24.0,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            // Layer 3: Monster video (on top of text)
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
            // Layer 4: Button at bottom (on top of everything)
            if (_showFinish && !isHello)
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: Center(
                  child: ElevatedButton(
                    onPressed: _isBusy ? null : _finishExercise,
                    child: Text(
                      _currentActivityKey == '06_will_you_join'
                          ? l10n.startExerciseLabel
                          : l10n.finishExerciseLabel,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MonsterFeedbackPage extends StatefulWidget {
  const _MonsterFeedbackPage();

  @override
  State<_MonsterFeedbackPage> createState() => _MonsterFeedbackPageState();
}

class _MonsterFeedbackPageState extends State<_MonsterFeedbackPage> {
  VideoPlayerController? _monsterController;
  VideoPlayerController? _backgroundController;
  VoidCallback? _monsterEndListener;
  int _monsterGeneration = 0;
  bool _isBusy = true;
  bool _showButtons = false;
  bool _showDone = false;
  bool _closed = false;
  String? _selectedFeedback;

  static const _feedbackClips = <String, String>{
    'very_good': '2_very_good',
    'good': '3_good',
    'meh': '4_meh',
    'not_good': '5_not_good',
    'awful': '6_awful',
  };

  String _assetPath(String clipName) {
    final platformKey = Platform.isIOS ? 'ios' : 'android';
    final ext = Platform.isIOS ? 'mov' : 'webm';
    return 'assets/monster_clips/25_feedback/$platformKey/$clipName.$ext';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _closed) return;
      unawaited(_start());
    });
  }

  @override
  void dispose() {
    _closed = true;
    _disposeControllers();
    super.dispose();
  }

  Future<void> _disposeControllers() async {
    final monster = _monsterController;
    final background = _backgroundController;
    final listener = _monsterEndListener;
    _monsterController = null;
    _backgroundController = null;
    _monsterEndListener = null;
    if (monster != null) {
      if (listener != null) monster.removeListener(listener);
      await monster.dispose();
    }
    if (background != null) await background.dispose();
  }

  Future<void> _ensureBackgroundVideo() async {
    if (_backgroundController != null) return;
    try {
      final bg = VideoPlayerController.asset(
        'assets/monster_clips/00_colored_moving_background/colored_moving_background.mp4',
      );
      _backgroundController = bg;
      await bg.initialize();
      await bg.setLooping(true);
      await bg.play();
      if (!mounted || _closed) return;
      setState(() {});
    } catch (_) {}
  }

  Future<void> _start() async {
    try {
      unawaited(_ensureBackgroundVideo());
      final path = _assetPath('1_feedback');
      if (!mounted || _closed) return;
      await _playUrl(path, looping: true);
      if (!mounted || _closed) return;
      setState(() {
        _isBusy = false;
        _showButtons = true;
      });
    } catch (_) {
      if (mounted && !_closed) {
        setState(() {
          _isBusy = false;
          _showButtons = true;
        });
      }
    }
  }

  Future<void> _playUrl(
    String url, {
    required bool looping,
    Future<void> Function()? onEnded,
  }) async {
    final previous = _monsterController;
    final oldListener = _monsterEndListener;
    _monsterController = null;
    _monsterEndListener = null;
    if (previous != null) {
      if (oldListener != null) previous.removeListener(oldListener);
      await previous.dispose();
    }
    final controller = VideoPlayerController.asset(
      url,
      viewType: Platform.isIOS
          ? VideoViewType.platformView
          : VideoViewType.textureView,
    );
    _monsterController = controller;
    _monsterGeneration++;
    await controller.initialize();
    await controller.setLooping(looping);
    if (onEnded != null) {
      var endedCalled = false;
      _monsterEndListener = () {
        if (!controller.value.isInitialized) return;
        if (_closed) return;
        if (controller.value.isPlaying) return;
        if (endedCalled) return;
        if (controller.value.position >= controller.value.duration) {
          endedCalled = true;
          onEnded();
        }
      };
      controller.addListener(_monsterEndListener!);
    }
    await controller.play();
    if (!mounted || _closed) return;
    setState(() {});
  }

  Future<void> _selectFeedback(String feedback) async {
    if (_selectedFeedback != null) return;
    setState(() {
      _selectedFeedback = feedback;
      _showButtons = false;
      _isBusy = true;
    });
    try {
      final clipName = _feedbackClips[feedback];
      if (clipName == null) {
        setState(() {
          _showDone = true;
          _isBusy = false;
        });
        return;
      }
      final path = _assetPath(clipName);
      if (!mounted || _closed) return;
      await _playUrl(
        path,
        looping: false,
        onEnded: () async {
          if (!mounted || _closed) return;
          setState(() {
            _showDone = true;
          });
        },
      );
      if (!mounted || _closed) return;
      // _playUrl resolves when playback STARTS — Done must wait for onEnded,
      // or the button covers the reaction clip while it is still playing.
      setState(() {
        _isBusy = false;
      });
    } catch (_) {
      if (mounted && !_closed) {
        setState(() {
          _isBusy = false;
          _showDone = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final monster = _monsterController;
    final background = _backgroundController;
    final monsterReady = monster?.value.isInitialized ?? false;
    final backgroundReady = background?.value.isInitialized ?? false;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Layer 1: Background video
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
            // Layer 2: Question text (behind monster)
            if (_showButtons)
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.feedbackQuestionLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'PlaypenSans',
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            // Layer 3: Monster video (on top of text)
            Positioned.fill(
              child: monsterReady
                  ? FittedBox(
                      key: ValueKey(_monsterGeneration),
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: monster!.value.size.width,
                        height: monster.value.size.height,
                        child: VideoPlayer(monster),
                      ),
                    )
                  : _isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
            ),
            // Layer 4: Feedback buttons at bottom
            if (_showButtons)
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _feedbackButton(l10n.feedbackVeryGood, 'very_good'),
                    _feedbackButton(l10n.feedbackGood, 'good'),
                    _feedbackButton(l10n.feedbackMeh, 'meh'),
                    _feedbackButton(l10n.feedbackNotGood, 'not_good'),
                    _feedbackButton(l10n.feedbackAwful, 'awful'),
                  ],
                ),
              ),
            if (_showDone)
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop(_selectedFeedback);
                      }
                    },
                    child: Text(l10n.feedbackDoneLabel),
                  ),
                ),
              ),
            if (_isBusy && _selectedFeedback != null)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _feedbackButton(String label, String value) {
    return ElevatedButton(
      onPressed: () => _selectFeedback(value),
      child: Text(label),
    );
  }
}
