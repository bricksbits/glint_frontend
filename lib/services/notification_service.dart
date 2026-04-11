import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Minimal foreground-notification service.
/// Background/killed-state notifications are delivered by FCM automatically
/// once the device is registered via [ChatService.registerDevice].
class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _kChannelId = 'glint_chat';
  static const _kChannelName = 'Glint Messages';

  static Future<void> initialize() async {
    // The icon name matches android:icon in the Manifest (@mipmap/launcher_icon).
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: false, // handled by firebase_messaging
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: iOS),
    );

    // Create the Android notification channel once.
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _kChannelId,
            _kChannelName,
            importance: Importance.high,
          ),
        );
  }

  /// Shows a system notification while the app is in the foreground.
  static Future<void> showMessage({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      // Use a time-based id so rapid messages don't replace each other.
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _kChannelId,
          _kChannelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
