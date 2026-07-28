import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:when_scars_become_art/services/notification_service.dart';
import 'package:when_scars_become_art/utils/bundled_avatars.dart';
import 'package:when_scars_become_art/utils/safe_key.dart';

import 'home_page.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import 'registration_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
    required this.localeNotifier,
    required this.supportedLocales,
    required this.themeModeNotifier,
  });

  final ValueNotifier<Locale?> localeNotifier;
  final List<Locale> supportedLocales;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn(
    serverClientId:
        '537131372504-s9jffblg6jio1h6ve21d403deeblbok6.apps.googleusercontent.com',
  );
  bool _isLoggingIn = false;
  bool _isGoogleSigningIn = false;
  bool _isAppleSigningIn = false;
  bool _obscurePassword = true;
  bool _navigatedToHome = false;

  /// Codes that mean the session itself is dead; anything else (e.g. a
  /// network failure) must not destroy a valid persisted session.
  static const _sessionFatalCodes = {
    'user-not-found',
    'user-disabled',
    'user-token-expired',
    'invalid-user-token',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryAutoLogin());
  }

  Future<void> _tryAutoLogin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Reload to ensure the token is still valid
    try {
      await user.reload();
    } on FirebaseAuthException catch (error) {
      if (_sessionFatalCodes.contains(error.code)) {
        await FirebaseAuth.instance.signOut();
        return;
      }
      // Transient failure (offline, server hiccup) — keep the session.
    } catch (_) {
      // Same: never sign the user out over an unknown transient failure.
    }

    final refreshedUser = FirebaseAuth.instance.currentUser;
    if (refreshedUser == null) return;

    // Email/password accounts must be verified before entering the app.
    // Without this check a freshly registered (still signed-in) user would
    // bypass verification entirely by restarting the app.
    final isPasswordUser = refreshedUser.providerData.any(
      (provider) => provider.providerId == 'password',
    );
    if (isPasswordUser && !refreshedUser.emailVerified) {
      await FirebaseAuth.instance.signOut();
      return;
    }

    var username = refreshedUser.displayName ?? refreshedUser.email ?? '';
    try {
      final snap = await FirebaseDatabase.instance
          .ref('users/${refreshedUser.uid}')
          .get();
      final stored = (snap.value as Map?)?['username'];
      if (stored is String && stored.trim().isNotEmpty) {
        username = stored;
      }
    } catch (_) {
      // Offline: fall back to the auth display name and continue.
    }

    await _reconcileEmail(refreshedUser);

    // Keep lastLoginAt fresh so the inactivity push doesn't fire for users
    // who open the app daily via a persisted session.
    try {
      await NotificationService.instance.onLogin(refreshedUser.uid);
    } catch (_) {}

    // Restore saved locale
    await _restoreLocale(refreshedUser.uid);

    _goHome(username);
  }

  /// After a verified email change (`verifyBeforeUpdateEmail`) only Firebase
  /// Auth knows the new address; sync it back to the profile and the
  /// usernames index, otherwise login-by-username keeps resolving the old
  /// email and fails forever.
  Future<void> _reconcileEmail(User user) async {
    final email = user.email;
    if (email == null || email.isEmpty) return;
    try {
      final ref = FirebaseDatabase.instance.ref('users/${user.uid}');
      final snap = await ref.get();
      if (snap.value is! Map) return;
      final profile = Map<String, dynamic>.from(snap.value as Map);
      if (profile['email'] == email) {
        if (profile['pendingEmail'] != null) {
          await ref.child('pendingEmail').remove();
        }
        return;
      }
      await ref.update({'email': email});
      await ref.child('pendingEmail').remove();
      final username = profile['username'];
      if (username is String && username.trim().isNotEmpty) {
        await FirebaseDatabase.instance
            .ref('usernames/${safeKey(username)}/email')
            .set(email);
      }
    } catch (_) {
      // Best-effort; retried on the next login.
    }
  }

  void _goHome(String username) {
    if (!mounted || _navigatedToHome) return;
    _navigatedToHome = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          username: username,
          localeNotifier: widget.localeNotifier,
          supportedLocales: widget.supportedLocales,
          themeModeNotifier: widget.themeModeNotifier,
        ),
      ),
    );
  }

  Future<void> _restoreLocale(String uid) async {
    try {
      final snap = await FirebaseDatabase.instance
          .ref('users/$uid/locale')
          .get();
      final stored = snap.value;
      if (stored is String && stored.isNotEmpty) {
        if (stored.contains('_')) {
          final parts = stored.split('_');
          widget.localeNotifier.value = Locale.fromSubtags(
            languageCode: parts[0],
            scriptCode: parts[1],
          );
        } else {
          widget.localeNotifier.value = Locale(stored);
        }
      }
    } catch (_) {
      // Locale restore is cosmetic — never block login on it.
    }
    try {
      final themeSnap = await FirebaseDatabase.instance
          .ref('users/$uid/themeMode')
          .get();
      final storedTheme = themeSnap.value;
      if (storedTheme is String) {
        widget.themeModeNotifier.value = ThemeMode.values.firstWhere(
          (mode) => mode.name == storedTheme,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (_) {
      // Theme restore is cosmetic too.
    }
  }

  Future<void> _login() async {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoggingIn) return;

    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.trim().isEmpty || password.isEmpty) {
      _showSnackBar(l10n.invalidCredentials);
      return;
    }

    setState(() {
      _isLoggingIn = true;
    });

    try {
      final loginName = username.trim();
      String email = loginName;
      String? usernameKey;

      if (!loginName.contains('@')) {
        usernameKey = safeKey(loginName);
        final usernameSnapshot = await FirebaseDatabase.instance
            .ref('usernames')
            .child(usernameKey)
            .get();
        if (!usernameSnapshot.exists) {
          _showSnackBar(l10n.invalidCredentials);
          return;
        }
        final data = usernameSnapshot.value;
        if (data is! Map || data['email'] is! String) {
          _showSnackBar(l10n.unableToLoadCredentials);
          return;
        }
        email = data['email'] as String;
      }

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        _showSnackBar(l10n.unableToLoadCredentials);
        return;
      }
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;
      if (refreshedUser == null) {
        _showSnackBar(l10n.unableToLoadCredentials);
        return;
      }

      if (!refreshedUser.emailVerified) {
        final profileSnapshot = await FirebaseDatabase.instance
            .ref('users/${refreshedUser.uid}')
            .get();
        if (profileSnapshot.exists && profileSnapshot.value is Map) {
          final profile = Map<String, dynamic>.from(
            profileSnapshot.value as Map,
          );
          final verification = profile['verification'];
          final expiresAt = verification is Map
              ? verification['expiresAt']
              : null;
          DateTime? expires;
          if (expiresAt is String) {
            expires = DateTime.tryParse(expiresAt);
          }
          final now = DateTime.now();
          if (expires != null && now.isAfter(expires)) {
            final storedUsername = profile['username'];
            if (storedUsername is String) {
              final key = safeKey(storedUsername);
              await FirebaseDatabase.instance.ref('usernames/$key').remove();
            }
            await FirebaseDatabase.instance
                .ref('users/${refreshedUser.uid}')
                .remove();
            await refreshedUser.delete();
            await FirebaseAuth.instance.signOut();
            _showSnackBar(l10n.verificationExpiredDeleted);
            return;
          }
          if (expires == null) {
            final newExpires = now.add(const Duration(days: 5));
            await FirebaseDatabase.instance
                .ref('users/${refreshedUser.uid}/verification')
                .set({
                  'sentAt': now.toUtc().toIso8601String(),
                  'expiresAt': newExpires.toUtc().toIso8601String(),
                  'status': 'pending',
                });
            expires = newExpires;
          }
          final expiryText = expires.toLocal().toString().split('.').first;
          await FirebaseAuth.instance.signOut();
          _showSnackBar(
            l10n.verifyEmailUntil(refreshedUser.email ?? '', expiryText),
          );
          return;
        }
        await FirebaseAuth.instance.signOut();
        _showSnackBar(l10n.verifyEmail(refreshedUser.email ?? ''));
        return;
      }
      if (refreshedUser.emailVerified) {
        await FirebaseDatabase.instance
            .ref('users/${refreshedUser.uid}/verification')
            .update({
              'verifiedAt': DateTime.now().toUtc().toIso8601String(),
              'status': 'verified',
            });
      }

      final displayName = loginName.contains('@')
          ? (refreshedUser.displayName ?? loginName)
          : loginName;

      await _reconcileEmail(refreshedUser);

      try {
        await NotificationService.instance.onLogin(refreshedUser.uid);
      } catch (_) {}

      await _restoreLocale(refreshedUser.uid);

      _goHome(displayName);
    } on FirebaseAuthException catch (error) {
      // 'invalid-credential' is what projects with email-enumeration
      // protection return for a wrong password.
      const credentialCodes = {
        'user-not-found',
        'wrong-password',
        'invalid-credential',
        'invalid-email',
      };
      if (credentialCodes.contains(error.code)) {
        _showSnackBar(l10n.invalidCredentials);
      } else {
        _showSnackBar(l10n.unableToLoadCredentials);
      }
    } catch (_) {
      _showSnackBar(l10n.unableToLoadCredentials);
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingIn = false;
        });
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    if (_isGoogleSigningIn) return;
    setState(() {
      _isGoogleSigningIn = true;
    });
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in flow
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      if (user == null) {
        _showSnackBar(l10n.googleSignInFailed);
        return;
      }

      final usersRef = FirebaseDatabase.instance.ref('users');
      final usernamesRef = FirebaseDatabase.instance.ref('usernames');
      final profileSnap = await usersRef.child(user.uid).get();
      if (!profileSnap.exists) {
        final email = user.email ?? '';
        final username = await _reserveUsername(
          usernamesRef,
          _defaultUsername(email),
        );
        await user.updateDisplayName(username);
        await usersRef.child(user.uid).set({
          'fullName': user.displayName ?? '',
          'email': email,
          'username': username,
          'avatarAssetPath': randomBundledAvatarAssetPath(),
          'createdAt': DateTime.now().toUtc().toIso8601String(),
        });
        await usernamesRef.child(safeKey(username)).set({
          'uid': user.uid,
          'email': email,
        });
      }

      await _reconcileEmail(user);

      try {
        await NotificationService.instance.onLogin(user.uid);
      } catch (_) {}

      await _restoreLocale(user.uid);

      _goHome(user.displayName ?? user.email ?? l10n.userFallbackName);
    } catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      _showSnackBar(l10n.googleSignInFailed);
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSigningIn = false;
        });
      }
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _loginWithApple() async {
    if (_isAppleSigningIn) return;
    setState(() {
      _isAppleSigningIn = true;
    });
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );
      final user = userCredential.user;
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      if (user == null) {
        _showSnackBar(l10n.appleSignInFailed);
        return;
      }

      // Apple only provides name on first sign-in
      final fullName = [
        appleCredential.givenName,
        appleCredential.familyName,
      ].where((s) => s != null && s.isNotEmpty).join(' ');
      if (fullName.isNotEmpty &&
          (user.displayName == null || user.displayName!.isEmpty)) {
        await user.updateDisplayName(fullName);
      }

      final usersRef = FirebaseDatabase.instance.ref('users');
      final usernamesRef = FirebaseDatabase.instance.ref('usernames');
      final profileSnap = await usersRef.child(user.uid).get();
      if (!profileSnap.exists) {
        final email = user.email ?? appleCredential.email ?? '';
        final username = await _reserveUsername(
          usernamesRef,
          _defaultUsername(email),
        );
        if (user.displayName == null || user.displayName!.isEmpty) {
          await user.updateDisplayName(username);
        }
        await usersRef.child(user.uid).set({
          'fullName': fullName.isNotEmpty ? fullName : '',
          'email': email,
          'username': username,
          'avatarAssetPath': randomBundledAvatarAssetPath(),
          'createdAt': DateTime.now().toUtc().toIso8601String(),
        });
        await usernamesRef.child(safeKey(username)).set({
          'uid': user.uid,
          'email': email,
        });
      }

      await _reconcileEmail(user);

      try {
        await NotificationService.instance.onLogin(user.uid);
      } catch (_) {}

      await _restoreLocale(user.uid);

      _goHome(user.displayName ?? user.email ?? l10n.userFallbackName);
    } on SignInWithAppleAuthorizationException {
      // User cancelled — do nothing
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      _showSnackBar(l10n.appleSignInFailed);
    } finally {
      if (mounted) {
        setState(() {
          _isAppleSigningIn = false;
        });
      }
    }
  }

  String _defaultUsername(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) {
      return 'user';
    }
    return trimmed.split('@').first;
  }

  Future<String> _reserveUsername(
    DatabaseReference usernamesRef,
    String base,
  ) async {
    final cleanBase = safeKey(base);
    for (var i = 0; i < 50; i++) {
      final candidate = i == 0 ? cleanBase : '${cleanBase}_$i';
      final snap = await usernamesRef.child(candidate).get();
      if (!snap.exists) {
        return candidate;
      }
    }
    return '${cleanBase}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void _openRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showPasswordResetDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final usernameInput = _usernameController.text.trim();
    if (usernameInput.contains('@')) {
      controller.text = usernameInput;
    }

    try {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.resetPasswordTitle),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: l10n.emailLabel),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancelLabel),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = controller.text.trim();
                if (email.isEmpty || !email.contains('@')) {
                  _showSnackBar(l10n.enterValidEmail);
                  return;
                }
                Navigator.pop(context);
                await _sendPasswordReset(email);
              },
              child: Text(l10n.sendLinkLabel),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _sendPasswordReset(String email) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSnackBar(l10n.passwordResetSent(email));
    } on FirebaseAuthException catch (_) {
      _showSnackBar(l10n.unableToSendPasswordReset);
    } catch (_) {
      _showSnackBar(l10n.unableToSendPasswordReset);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 32),
                  SizedBox(
                    width: (constraints.maxWidth * 0.58).clamp(240.0, 360.0),
                    child: const AspectRatio(
                      aspectRatio: 14440 / 6892,
                      child: Image(
                        image: AssetImage('assets/images/logo_horizontal.png'),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: _isGoogleSigningIn ? null : _loginWithGoogle,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1F1F1F),
                      side: const BorderSide(color: Color(0xFF747775)),
                      minimumSize: const Size(240, 40),
                      maximumSize: const Size(400, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            'assets/images/google_g_logo.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _isGoogleSigningIn
                              ? l10n.signingInLabel
                              : l10n.loginWithGoogle,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (defaultTargetPlatform == TargetPlatform.iOS)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: OutlinedButton(
                        onPressed: _isAppleSigningIn ? null : _loginWithApple,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black),
                          minimumSize: const Size(240, 40),
                          maximumSize: const Size(400, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.apple,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _isAppleSigningIn
                                  ? l10n.signingInLabel
                                  : l10n.loginWithApple,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(l10n.orLoginWithUsernameAndPassword),
                  SizedBox(height: 10),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.8).clamp(
                      240.0,
                      500.0,
                    ),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: l10n.usernameLabel,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.8).clamp(
                      240.0,
                      500.0,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.passwordLabel,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: _showPasswordResetDialog,
                    child: Text(l10n.forgotPasswordLabel),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(l10n.loginButton),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.noAccountPrompt),
                      TextButton(
                        onPressed: _openRegistration,
                        child: Text(l10n.registerLink),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/icons/EN_Co-fundedbytheEU_RGB_POS-scaled.png',
                    height: 40,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Funded by the European Union. Views and opinions expressed are '
                      'however those of the author(s) only and do not necessarily '
                      'reflect those of the European Union or the European Education '
                      'and Culture Executive Agency (EACEA). Neither the European '
                      'Union nor EACEA can be held responsible for them.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
