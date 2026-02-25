import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:when_scars_become_art/services/notification_service.dart';

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
  bool _isLoggingIn = false;
  bool _isGoogleSigningIn = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
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
        usernameKey = _safeKey(loginName);
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

      if (kReleaseMode && !refreshedUser.emailVerified) {
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
              final key = _safeKey(storedUsername);
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
                  'sentAt': now.toIso8601String(),
                  'expiresAt': newExpires.toIso8601String(),
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
              'verifiedAt': DateTime.now().toIso8601String(),
              'status': 'verified',
            });
      }

      final displayName = loginName.contains('@')
          ? (refreshedUser.displayName ?? loginName)
          : loginName;

      try {
        await NotificationService.instance.onLogin(refreshedUser.uid);
      } catch (error) {
        debugPrint('Post-login notification setup failed: $error');
      }

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            username: displayName,
            localeNotifier: widget.localeNotifier,
            supportedLocales: widget.supportedLocales,
            themeModeNotifier: widget.themeModeNotifier,
          ),
        ),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found' || error.code == 'wrong-password') {
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
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
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
          'createdAt': DateTime.now().toIso8601String(),
        });
        await usernamesRef.child(_safeKey(username)).set({
          'uid': user.uid,
          'email': email,
        });
      }

      try {
        await NotificationService.instance.onLogin(user.uid);
      } catch (error) {
        debugPrint('Post-login notification setup failed: $error');
      }

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            username: user.displayName ?? user.email ?? l10n.userFallbackName,
            localeNotifier: widget.localeNotifier,
            supportedLocales: widget.supportedLocales,
            themeModeNotifier: widget.themeModeNotifier,
          ),
        ),
      );
    } catch (error) {
      debugPrint('Google sign-in failed: $error');
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
    final cleanBase = _safeKey(base);
    for (var i = 0; i < 50; i++) {
      final candidate = i == 0 ? cleanBase : '${cleanBase}_$i';
      final snap = await usernamesRef.child(candidate).get();
      if (!snap.exists) {
        return candidate;
      }
    }
    return '${cleanBase}_${DateTime.now().millisecondsSinceEpoch}';
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

  void _openRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }

  void _showSnackBar(String message) {
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
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(l10n.orLoginWithUsernameAndPassword),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: l10n.usernameLabel,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
