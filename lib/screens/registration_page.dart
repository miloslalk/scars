import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:when_scars_become_art/gen_l10n/app_localizations.dart';
import '../widgets/app_top_bar.dart';
import 'terms_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool? _usernameAvailable;
  bool _checkingUsername = false;
  Timer? _usernameDebounce;

  @override
  void dispose() {
    _usernameDebounce?.cancel();
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_acceptTerms) {
      _showSnackBar('Please accept terms and services.');
      return;
    }
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final username = _usernameController.text.trim();
      final usersRef = FirebaseDatabase.instance.ref('users');
      final usernamesRef = FirebaseDatabase.instance.ref('usernames');
      final usernameKey = _safeKey(username);

      final existing = await usernamesRef.child(usernameKey).get();
      if (existing.exists) {
        _showSnackBar('Username already exists.');
        return;
      }

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          )
          .timeout(const Duration(seconds: 10));

      final uid = credential.user?.uid;
      if (uid == null) {
        _showSnackBar('Registration failed.');
        return;
      }
      await credential.user?.updateDisplayName(username);
      await credential.user?.getIdToken(true);
      await credential.user?.sendEmailVerification();

      final expiresAt = DateTime.now().add(const Duration(days: 5));
      await usersRef.child(uid).set({
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'username': username,
        'createdAt': DateTime.now().toIso8601String(),
        'verification': {
          'sentAt': DateTime.now().toIso8601String(),
          'expiresAt': expiresAt.toIso8601String(),
        },
      });

      await usernamesRef.child(usernameKey).set({
        'uid': uid,
        'email': _emailController.text.trim(),
      });

      if (!mounted) return;
      _showSnackBar(
        'Verification email sent to ${_emailController.text.trim()}.',
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      _showSnackBar('Registration failed: ${error.code}');
    } on TimeoutException {
      _showSnackBar('Registration timed out. Check emulator.');
    } catch (error) {
      debugPrint('Registration failed: $error');
      _showSnackBar('Registration failed: $error');
    } finally {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _checkUsernameAvailability(String value) {
    _usernameDebounce?.cancel();
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length < 6) {
      setState(() {
        _usernameAvailable = null;
        _checkingUsername = false;
      });
      return;
    }
    setState(() {
      _checkingUsername = true;
    });
    _usernameDebounce = Timer(const Duration(milliseconds: 400), () async {
      final key = _safeKey(trimmed);
      try {
        final snapshot = await FirebaseDatabase.instance
            .ref('usernames')
            .child(key)
            .get();
        if (!mounted) return;
        setState(() {
          _usernameAvailable = !snapshot.exists;
          _checkingUsername = false;
        });
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _usernameAvailable = null;
          _checkingUsername = false;
        });
      }
    });
  }

  bool _meetsPasswordRule(String password, RegExp pattern) {
    return pattern.hasMatch(password);
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final password = _passwordController.text;
    final hasUppercase = _meetsPasswordRule(password, RegExp(r'[A-Z]'));
    final hasNumber = _meetsPasswordRule(password, RegExp(r'\d'));
    final hasSpecial =
        _meetsPasswordRule(password, RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final hasLength = password.length >= 8;

    return Scaffold(
      appBar: const AppTopBar(showUserAction: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.registrationTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.registrationSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(labelText: l10n.fullNameLabel),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.fieldRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: l10n.emailLabel),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      final trimmed = value?.trim() ?? '';
                      if (trimmed.isEmpty) {
                        return l10n.fieldRequired;
                      }
                      if (!trimmed.contains('@')) {
                        return l10n.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      _checkUsernameAvailability(value);
                      _formKey.currentState?.validate();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.fieldRequired;
                      }
                      if (value.trim().length < 6) {
                        return 'At least 6 characters.';
                      }
                      if (_usernameAvailable == false) {
                        return 'Username already exists.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.usernameLabel,
                      suffixIcon: _checkingUsername
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : _usernameAvailable == null
                              ? null
                              : Icon(
                                  _usernameAvailable! ? Icons.check : Icons.close,
                                  color: _usernameAvailable!
                                      ? Colors.green
                                      : Colors.red,
                                ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldRequired;
                      }
                      if (value.length < 8 ||
                          !hasUppercase ||
                          !hasNumber ||
                          !hasSpecial) {
                        return 'Password is too weak.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.passwordLabel,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PasswordRule(
                          label: 'At least 8 characters',
                          isMet: hasLength,
                        ),
                        _PasswordRule(
                          label: 'At least 1 uppercase letter',
                          isMet: hasUppercase,
                        ),
                        _PasswordRule(
                          label: 'At least 1 number',
                          isMet: hasNumber,
                        ),
                        _PasswordRule(
                          label: 'At least 1 special character',
                          isMet: hasSpecial,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldRequired;
                      }
                      if (value != _passwordController.text) {
                        return l10n.passwordsDoNotMatch;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.confirmPasswordLabel,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text('I accept '),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'terms and services',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.registerButton),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.alreadyHaveAccount),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.loginButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRule extends StatelessWidget {
  const _PasswordRule({
    required this.label,
    required this.isMet,
  });

  final String label;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isMet ? Colors.green : Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
