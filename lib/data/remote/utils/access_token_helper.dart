import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:encrypt_shared_preferences/provider.dart';

class AccessTokenHelper {
  late EncryptedSharedPreferencesAsync sharedPreferences;

  AccessTokenHelper() {
    setupSharedPref();
  }

  Future<void> setupSharedPref() async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    sharedPreferences = EncryptedSharedPreferencesAsync.getInstance();
  }

  // Method to check if Token is Valid or not.
  Future<bool> isTokenValid() async {
    final lastUpdatedTime = await sharedPreferences.getInt("") ?? 0;
    return lastUpdatedTime > DateTime.now().microsecondsSinceEpoch;
  }

  Future<void> updateRefreshToken(
    MyDioClient httpClient,
  ) async {
    // final requestBody = SpotifyAccessTokenRequestModel(
    //   grantType: grant_type,
    //   clientId: client_id,
    //   clientSecret: client_secret,
    // );
    //
    // final accessTokenResponse = await httpClient.postRequest(
    //     SPOTIFY_ACCESS_TOKEN_ENDPOINT, requestBody.toJson());
    //
    // if (accessTokenResponse?.statusCode == 200) {
    //   final accessTokenResponseModel =
    //       SpotifyAccessTokenDataModel.fromJson(accessTokenResponse?.data);
    //
    //   final accessToken =
    //       accessTokenResponseModel.accessToken ?? "empty_access_token";
    //
    //   // Saving the time Token received and added 3500 millisecond buffer
    //   // as per the Spotify Docs.
    //
    //   final expireTimePeriod = DateTime.now()
    //       .add(const Duration(minutes: 55))
    //       .microsecondsSinceEpoch;
    //   await sharedPreferences.setInt(
    //       LAST_SAVED_TIME_IN_MS_KEY, expireTimePeriod);
    //
    //   // Saving the new access token
    //   await sharedPreferences.setString(SPOTIFY_ACCESS_TOKEN_KEY, accessToken);
    // }
  }
}
