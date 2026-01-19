import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const int _dailyId = 1001;
  static const int _inactiveId = 1002;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);
    await _plugin.initialize(initSettings);

    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    final iosPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> scheduleDailyMorning() async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = _nextInstanceOfTime(now, hour: 9, minute: 0);
    await _plugin.zonedSchedule(
      _dailyId,
      'Good morning ☀️',
      null,
      scheduled,
      _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleInactiveReminder(DateTime lastLoginLocal) async {
    final base = tz.TZDateTime.from(lastLoginLocal, tz.local);
    final scheduled = base.add(const Duration(days: 7));
    await _plugin.zonedSchedule(
      _inactiveId,
      'Counting the moments until you are back.',
      null,
      scheduled,
      _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> cancelInactiveReminder() async {
    await _plugin.cancel(_inactiveId);
  }

  Future<void> onLogin(String uid) async {
    final now = DateTime.now();
    await FirebaseDatabase.instance
        .ref('users/$uid/lastLoginAt')
        .set(now.toIso8601String());
    await scheduleDailyMorning();
    await cancelInactiveReminder();
    await scheduleInactiveReminder(now);
  }

  tz.TZDateTime _nextInstanceOfTime(
    tz.TZDateTime now, {
    required int hour,
    required int minute,
  }) {
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  NotificationDetails _defaultDetails() {
    const android = AndroidNotificationDetails(
      'default_notifications',
      'Notifications',
      channelDescription: 'App notifications',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const ios = DarwinNotificationDetails();
    return const NotificationDetails(android: android, iOS: ios);
  }
}
