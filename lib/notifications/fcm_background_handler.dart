import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glint_frontend/notifications/background/stream_background_prefs.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Top-level FCM background message handler.
///
/// Runs in a separate Dart isolate on Android when the app is in
/// background/terminated state. Stream Chat sends data-only FCM messages
/// (no `notification` field), so the OS never shows a banner automatically —
/// we must fetch the message and display it manually via
/// [FlutterLocalNotificationsPlugin].
///
/// Credentials needed to authenticate with Stream are persisted to regular
/// SharedPreferences by [ChatRepoImpl.connectToServer] so this isolate can
/// read them without requiring the main app to be running.
///
/// IMPORTANT: Do not use GetIt or any injectable services here — this function
/// runs outside the Flutter widget tree in its own isolate.
@pragma('vm:entry-point')
Future<void> glintFirebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  if (message.data['type'] != 'message.new') return;

  WidgetsFlutterBinding.ensureInitialized();

  final creds = await StreamBackgroundPrefs.load();
  if (creds == null) return;

  final messageId = message.data['id'] as String?;
  if (messageId == null) return;

  final chatClient = StreamChatClient(creds.apiKey, logLevel: Level.WARNING);
  try {
    await chatClient.connectUser(
      User(id: creds.userId),
      creds.token,
      connectWebSocket: false,
    );

    final response = await chatClient.getMessage(messageId);
    final msg = response.message;
    final senderName = msg.user?.name ?? 'New message';
    final text = msg.text?.isNotEmpty == true ? msg.text! : 'Sent you a message';

    final notifications = FlutterLocalNotificationsPlugin();
    await notifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await notifications.show(
      messageId.hashCode,
      senderName,
      text,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'glint_matches',
          'Matches',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'notification_type=new_message',
    );
  } catch (e) {
    debugLogger("[NotificationHandler-BG-FCM]", "Exception caught ${e.toString()}");
    // Silently discard — a failed background fetch is preferable to a crash.
  } finally {
    await chatClient.disconnectUser();
  }
}
