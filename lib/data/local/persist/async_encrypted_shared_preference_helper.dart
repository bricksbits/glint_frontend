import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:injectable/injectable.dart';

@injectable
class AsyncEncryptedSharedPreferenceHelper {
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  AsyncEncryptedSharedPreferenceHelper(this.sharedPreferencesAsync);

  Future<void> saveString(
    String key,
    String value,
  ) async {
    await sharedPreferencesAsync.setString(key, value);
  }

  Future<String> getString(
    String key,
  ) async {
    final value =
        await sharedPreferencesAsync.getString(key, defaultValue: "") ?? "";
    return value;
  }

  Future<void> saveBoolean(
    String key,
    bool value,
  ) async {
    await sharedPreferencesAsync.setBoolean(key, value);
  }

  Future<bool> getBoolean(
    String key,
  ) async {
    final value =
        await sharedPreferencesAsync.getBool(key, defaultValue: false) ?? false;
    return value;
  }

  Future<void> saveInt(
    String key,
    int value,
  ) async {
    await sharedPreferencesAsync.setInt(key, value);
  }

  Future<int> getInt(
    String key,
  ) async {
    final value =
        await sharedPreferencesAsync.getInt(key, defaultValue: 0) ?? 0;
    return value;
  }

  Future<void> clearEncryptedPrefs() async {
    final keys = await sharedPreferencesAsync.getKeys();
    for (var key in keys) {
      await sharedPreferencesAsync.remove(key);
    }
  }

  Future<String?> isRefreshTokenAvailable() async {
    final token = await sharedPreferencesAsync
        .getString(SharedPreferenceKeys.refreshTokenKey);
    return token;
  }
}
