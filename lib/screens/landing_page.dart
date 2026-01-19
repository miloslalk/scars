import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user == null) {
        _showSnackBar(l10n.unableToLoadCredentials);
        return;
      }

      if (!user.emailVerified) {
        final profileSnapshot =
            await FirebaseDatabase.instance.ref('users/${user.uid}').get();
        if (profileSnapshot.exists && profileSnapshot.value is Map) {
          final profile = Map<String, dynamic>.from(
            profileSnapshot.value as Map,
          );
          final verification = profile['verification'];
          final expiresAt = verification is Map ? verification['expiresAt'] : null;
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
            await FirebaseDatabase.instance.ref('users/${user.uid}').remove();
            await user.delete();
            await FirebaseAuth.instance.signOut();
            _showSnackBar('Verification expired. Account deleted.');
            return;
          }
          if (expires == null) {
            final newExpires = now.add(const Duration(days: 5));
            await FirebaseDatabase.instance
                .ref('users/${user.uid}/verification')
                .set({
              'sentAt': now.toIso8601String(),
              'expiresAt': newExpires.toIso8601String(),
            });
            expires = newExpires;
          }
          final expiryText = expires.toLocal().toString().split('.').first;
          await FirebaseAuth.instance.signOut();
          _showSnackBar(
            'Please verify your email ${user.email} until $expiryText.',
          );
          return;
        }
        await FirebaseAuth.instance.signOut();
        _showSnackBar(
          'Please verify your email ${user.email}.',
        );
        return;
      }

      final displayName = loginName.contains('@')
          ? (user.displayName ?? loginName)
          : loginName;

      await NotificationService.instance.onLogin(user.uid);

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

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        _showSnackBar('Google sign-in failed.');
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

      await NotificationService.instance.onLogin(user.uid);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            username: user.displayName ?? user.email ?? 'User',
            localeNotifier: widget.localeNotifier,
            supportedLocales: widget.supportedLocales,
            themeModeNotifier: widget.themeModeNotifier,
          ),
        ),
      );
    } catch (error) {
      debugPrint('Google sign-in failed: $error');
      _showSnackBar('Google sign-in failed.');
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
      final isValid = (codeUnit >= 48 && codeUnit <= 57) ||
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _showPasswordResetDialog() async {
    final controller = TextEditingController();
    final usernameInput = _usernameController.text.trim();
    if (usernameInput.contains('@')) {
      controller.text = usernameInput;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset password'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = controller.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                _showSnackBar('Enter a valid email.');
                return;
              }
              Navigator.pop(context);
              await _sendPasswordReset(email);
            },
            child: const Text('Send link'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendPasswordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSnackBar('Password reset email sent to $email.');
    } on FirebaseAuthException catch (_) {
      _showSnackBar('Unable to send password reset email.');
    } catch (_) {
      _showSnackBar('Unable to send password reset email.');
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
              Image.asset(
                'assets/images/logo_horizontal.png',
                width: 320,
                height: 128,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _isGoogleSigningIn ? null : _loginWithGoogle,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Color(0xFFDADCE0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFDADCE0)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _isGoogleSigningIn ? 'Signing in...' : l10n.loginWithGoogle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
                  decoration: InputDecoration(labelText: l10n.usernameLabel),
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
                child: const Text('Forgot password?'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text(l10n.loginButton)),
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
