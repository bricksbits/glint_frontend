import 'package:firebase_messaging/firebase_messaging.dart';

/// Top-level FCM background message handler.
///
/// Runs in a separate Isolate on Android when the app is in background/terminated
/// state. Firebase Core is already initialized by the OS before this is called.
///
/// The OS notification banner is shown natively by FCM because every Glint
/// message contains both a `notification` field (for the banner) and a `data`
/// field (for routing). Navigation on tap is handled via
/// [FirebaseMessaging.onMessageOpenedApp] or [FirebaseMessaging.getInitialMessage]
/// inside [GlintNotificationService] — not here.
///
/// IMPORTANT: Do not call any Flutter UI code or GetIt services here — this
/// function runs outside the Flutter widget tree.
@pragma('vm:entry-point')
Future<void> glintFirebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  // Nothing to do — the OS handles the banner and GlintNotificationService
  // handles the tap. Add any background-safe work (e.g. data caching) here
  // if needed in the future.
}
