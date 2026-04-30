import 'package:shared_preferences/shared_preferences.dart';

/// Stores the minimal Stream credentials needed by the FCM background isolate
/// to authenticate and fetch message content before showing a local notification.
///
/// Uses plain [SharedPreferences] (not encrypted) because encrypted storage
/// requires the device to be unlocked, which is not guaranteed when a push
/// notification fires. Stream tokens have limited scope (Stream Chat only) and
/// are protected by Android's app sandbox, so plain storage is acceptable here.
class StreamBackgroundPrefs {
  StreamBackgroundPrefs._();

  static const String _apiKey = 'bg_stream_api_key';
  static const String _userId = 'bg_stream_user_id';
  static const String _token = 'bg_stream_token';

  static Future<void> save({
    required String apiKey,
    required String userId,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_apiKey, apiKey),
      prefs.setString(_userId, userId),
      prefs.setString(_token, token),
    ]);
  }

  static Future<({String apiKey, String userId, String token})?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString(_apiKey);
    final userId = prefs.getString(_userId);
    final token = prefs.getString(_token);
    if (apiKey == null || userId == null || token == null) return null;
    return (apiKey: apiKey, userId: userId, token: token);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_apiKey),
      prefs.remove(_userId),
      prefs.remove(_token),
    ]);
  }
}
