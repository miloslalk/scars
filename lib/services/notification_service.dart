import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../utils/safe_key.dart';

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

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermissions();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle notification taps from terminated state.
    FirebaseMessaging.instance.getInitialMessage();

    // Handle notification taps when app is in background.
    FirebaseMessaging.onMessageOpenedApp.listen((_) {});

    // Handle foreground messages (iOS needs this for the notification
    // presentation options above to take effect reliably).
    FirebaseMessaging.onMessage.listen((_) {});

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
    final now = DateTime.now();
    await FirebaseDatabase.instance
        .ref('users/$uid/lastLoginAt')
        .set(now.toIso8601String());
    await registerDevice(uid);
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
    final userRef = FirebaseDatabase.instance.ref('users/$uid');
    final userSnapshot = await userRef.get();
    final userValue = userSnapshot.value;
    Map<String, dynamic>? prefs;
    if (userValue is Map) {
      final data = Map<String, dynamic>.from(userValue);
      final rawPrefs = data['notificationPrefs'];
      if (rawPrefs is Map) {
        prefs = Map<String, dynamic>.from(rawPrefs);
      }
    }

    final ref = FirebaseDatabase.instance.ref(
      'users/$uid/devices/${safeKey(token)}',
    );
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
      'updatedAt': now.toIso8601String(),
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
  }
}
