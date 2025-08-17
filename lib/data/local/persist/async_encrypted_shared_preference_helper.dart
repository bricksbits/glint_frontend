import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
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

  Future<void> saveUserData(
    String? accessToken,
    String? refreshToken,
    String? streamAuthToken,
    String? userId,
    String? userName,
  ) async {
    if (accessToken != null) {
      if (accessToken.isNotEmpty) {
        await saveString(SharedPreferenceKeys.accessTokenKey, accessToken);
      }
    }

    if (refreshToken != null) {
      if (refreshToken.isNotEmpty) {
        await saveString(SharedPreferenceKeys.refreshTokenKey, refreshToken);
      }
    }

    if (streamAuthToken != null) {
      if (streamAuthToken.isNotEmpty) {
        await saveString(SharedPreferenceKeys.streamTokenKey, streamAuthToken);
      }
    }

    if (userId != null) {
      await saveString(
        SharedPreferenceKeys.userIdKey,
        userId,
      );
    }

    if (userName != null) {
      await saveString(
        SharedPreferenceKeys.userNameKey,
        userName,
      );
    }

    final tokenBufferTime =
        DateTime.now().add(const Duration(minutes: 55)).microsecondsSinceEpoch;

    await saveInt(SharedPreferenceKeys.lastSavedTimeKey, tokenBufferTime);
  }

  Future<void> saveUserType(String typeFound) async {
    late final UsersType userType;
    switch (typeFound) {
      case 'user':
        userType = UsersType.USER;
        break;
      case 'admin':
        userType = UsersType.ADMIN;
        break;
      case 'super admin':
        userType = UsersType.SUPER_ADMIN;
        break;
      default:
        userType = UsersType.USER;
    }
    await saveString(SharedPreferenceKeys.userRoleKey, userType.name);
  }
}
