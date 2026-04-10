import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton()
class NotificationPermissionService {
  final FirebaseMessaging _fcm;
  final FlutterLocalNotificationsPlugin _localNotifications;

  NotificationPermissionService(this._fcm, this._localNotifications);

  /// Requests notification permissions from the user.
  /// Should only be called from the dedicated permission onboarding screen.
  Future<bool> requestPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Android 13+ explicit POST_NOTIFICATIONS permission
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;

    debugPrint(
        'NotificationPermissionService: permission granted=$granted (${settings.authorizationStatus})');
    return granted;
  }

  /// Checks whether notification permission has already been granted,
  /// without prompting the user.
  Future<bool> isPermissionGranted() async {
    final settings = await _fcm.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// Opens the OS app-settings page so the user can manually enable
  /// notifications if they previously denied the permission.
  Future<void> openSettings() => openAppSettings();
}
