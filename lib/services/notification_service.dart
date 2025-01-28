import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap here
    },
  );
}

Future<void> scheduleDailyNotification() async {
  tz.initializeTimeZones();

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID
    'Daily Reminder', // Notification Title
    'Don’t forget to record your expenses today!', // Notification Body
    _nextInstanceOfTime(17, 15), // Time for notification (e.g., 8:00 PM)
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_reminder_channel', // Channel ID
        'Daily Reminders', // Channel Name
        channelDescription: 'Daily reminders to log your expenses',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ), // Show notification even when idle
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents:
        DateTimeComponents.time, // Repeat daily at this time
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
  );
}

// Helper function to get the next instance of the desired time
tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
