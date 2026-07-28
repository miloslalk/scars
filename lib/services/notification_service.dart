import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../utils/safe_key.dart';

/// Root messenger so foreground pushes can be surfaced without a BuildContext.
final GlobalKey<ScaffoldMessengerState> appScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // No-op: ensures FCM delivers background notifications on iOS.
  // Firebase must have a registered handler even if it does nothing.
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  StreamSubscription<String>? _tokenRefreshSubscription;
  String? _lastRegisteredUid;
  String? _lastRegisteredTokenKey;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermissions();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle notification taps when app is in background.
    FirebaseMessaging.onMessageOpenedApp.listen((_) {});

    // iOS presents foreground notifications natively (options above); Android
    // shows nothing in the foreground, so surface the message in-app.
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isIOS) return;
      final notification = message.notification;
      if (notification == null) return;
      final text = [notification.title, notification.body]
          .whereType<String>()
          .map((part) => part.trim())
          .where((part) => part.isNotEmpty)
          .join(' — ');
      if (text.isEmpty) return;
      appScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(text)),
      );
    });

    _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((_) async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      await registerDevice(uid);
    });

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      try {
        await registerDevice(uid);
      } catch (_) {
        // Will retry on token refresh.
      }
    }
  }

  Future<void> _requestPermissions() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> onLogin(String uid) async {
    await FirebaseDatabase.instance
        .ref('users/$uid/lastLoginAt')
        .set(DateTime.now().toUtc().toIso8601String());
    await registerDevice(uid);
  }

  /// Removes this device's registration so a signed-out account (or the next
  /// account on this phone) stops receiving its pushes. Call before signOut.
  Future<void> onLogout(String uid) async {
    try {
      final token = await _messaging.getToken();
      if (token != null && token.trim().isNotEmpty) {
        await FirebaseDatabase.instance
            .ref('users/$uid/devices/${safeKey(token)}')
            .remove();
      }
    } catch (_) {
      // Best-effort: sign-out must proceed even if deregistration fails.
    }
    _lastRegisteredUid = null;
    _lastRegisteredTokenKey = null;
  }

  Future<void> registerDevice(String uid) async {
    if (Platform.isIOS) {
      String? apnsToken;
      for (var attempt = 0; attempt < 3; attempt++) {
        apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) break;
        await Future<void>.delayed(const Duration(seconds: 2));
      }
      if (apnsToken == null) return;
    }
    final token = await _messaging.getToken();
    if (token == null || token.trim().isEmpty) return;

    final now = DateTime.now();
    String? timezoneName;
    try {
      final detected = await FlutterTimezone.getLocalTimezone();
      if (detected.trim().isNotEmpty) {
        timezoneName = detected.trim();
      }
    } catch (_) {
      // Fall through — timezone is optional.
    }
    final prefsSnapshot = await FirebaseDatabase.instance
        .ref('users/$uid/notificationPrefs')
        .get();
    final rawPrefs = prefsSnapshot.value;
    Map<String, dynamic>? prefs;
    if (rawPrefs is Map) {
      prefs = Map<String, dynamic>.from(rawPrefs);
    }

    final tokenKey = safeKey(token);
    final ref = FirebaseDatabase.instance.ref('users/$uid/devices/$tokenKey');
    final existing = await ref.get();

    final prefDailyEnabled = prefs?['dailyEnabled'];
    final prefInactiveEnabled = prefs?['inactiveEnabled'];
    final prefDailyHour = prefs?['dailyHour'];
    final prefDailyMinute = prefs?['dailyMinute'];

    final update = <String, dynamic>{
      'token': token,
      'platform': Platform.isIOS ? 'ios' : 'android',
      if (timezoneName != null) 'timezoneName': timezoneName,
      'utcOffsetMinutes': now.timeZoneOffset.inMinutes,
      'updatedAt': now.toUtc().toIso8601String(),
      if (!existing.child('dailyEnabled').exists)
        'dailyEnabled': prefDailyEnabled is bool ? prefDailyEnabled : true,
      if (!existing.child('inactiveEnabled').exists)
        'inactiveEnabled': prefInactiveEnabled is bool
            ? prefInactiveEnabled
            : true,
      if (!existing.child('dailyHour').exists)
        'dailyHour': prefDailyHour is int ? prefDailyHour : 9,
      if (!existing.child('dailyMinute').exists)
        'dailyMinute': prefDailyMinute is int ? prefDailyMinute : 0,
    };

    await ref.update(update);

    // If FCM rotated the token mid-session, drop the entry for the old one so
    // the schedulers don't keep sending to both.
    if (_lastRegisteredUid == uid &&
        _lastRegisteredTokenKey != null &&
        _lastRegisteredTokenKey != tokenKey) {
      try {
        await FirebaseDatabase.instance
            .ref('users/$uid/devices/$_lastRegisteredTokenKey')
            .remove();
      } catch (_) {
        // Stale entry will be pruned server-side when FCM rejects it.
      }
    }
    _lastRegisteredUid = uid;
    _lastRegisteredTokenKey = tokenKey;
  }
}
