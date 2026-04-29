import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/domain/business_logic/repo/notification/notification_repo.dart';
import 'package:glint_frontend/notifications/channels/notification_channels.dart';
import 'package:glint_frontend/notifications/handler/notification_handler.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GlintNotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _fcm;
  final NotificationRepo _notificationRepo;
  final AsyncEncryptedSharedPreferenceHelper _prefs;

  GlintNotificationService(
    this._localNotifications,
    this._fcm,
    this._notificationRepo,
    this._prefs,
  );

  /// Call once from [bootstrap] after DI is configured and before [runApp].
  Future<void> initialize() async {
    await _createAndroidChannels();
    await _initLocalNotifications();
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _listenForeground();
    _listenTaps();
    await _registerFcmToken();
  }

  // ── Android channel creation ───────────────────────────────────────────────

  Future<void> _createAndroidChannels() async {
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return;
    for (final channel in GlintNotificationChannels.all) {
      await androidPlugin.createNotificationChannel(channel);
    }
  }

  // ── flutter_local_notifications init ─────────────────────────────────────

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          NotificationHandler.handleNavigation(_decodePayload(payload));
        }
      },
    );
  }

  // ── Foreground message handler ────────────────────────────────────────────

  /// When the app is open, FCM delivers silently (Android) or via the
  /// system (iOS via setForegroundNotificationPresentationOptions).
  /// We show our own banner on Android so the user sees it.
  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      final channelId = GlintNotificationChannels.channelIdForType(
          message.data['notification_type'] as String?);

      _localNotifications.show(
        message.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            GlintNotificationChannels.channelNameForId(channelId),
            icon: '@mipmap/launcher_icon',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: _encodePayload(message.data),
      );
    });
  }

  // ── Notification tap handlers ─────────────────────────────────────────────

  void _listenTaps() {
    // App was in the background when the user tapped the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationHandler.handleNavigation(message.data);
    });

    // App was terminated when the user tapped the notification
    _fcm.getInitialMessage().then((message) {
      if (message == null) return;
      // Small delay to let the navigator finish mounting after cold start.
      Future.delayed(const Duration(milliseconds: 500), () {
        NotificationHandler.handleNavigation(message.data);
      });
    });
  }

  // ── FCM token registration ────────────────────────────────────────────────

  Future<void> _registerFcmToken() async {
    try {
      final token = await _fcm.getToken();
      if (token == null) return;
      await _saveAndUploadToken(token);
      _fcm.onTokenRefresh.listen(_saveAndUploadToken);
    } catch (e) {
      debugPrint('GlintNotificationService: FCM token registration failed: $e');
    }
  }

  Future<void> _saveAndUploadToken(String token) async {
    await _prefs.saveString(SharedPreferenceKeys.deviceFcmTokenKey, token);
    await _notificationRepo.updateFcmToken(token);
  }

  // ── Payload encode/decode ─────────────────────────────────────────────────

  /// Serialises the FCM data map to a URI-encoded key=value string so it can
  /// be stored as a single [String] payload in flutter_local_notifications.
  String _encodePayload(Map<String, dynamic> data) {
    return data.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }

  /// Deserialises the payload string back to a [Map].
  Map<String, dynamic> _decodePayload(String payload) {
    final map = <String, dynamic>{};
    for (final part in payload.split('&')) {
      final idx = part.indexOf('=');
      if (idx == -1) continue;
      map[Uri.decodeComponent(part.substring(0, idx))] =
          Uri.decodeComponent(part.substring(idx + 1));
    }
    return map;
  }
}
