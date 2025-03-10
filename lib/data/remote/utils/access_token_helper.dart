import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/model/request/auth/refresh_token_body_request.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/data/remote/utils/network_response_handler.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccessTokenHelper {
  EncryptedSharedPreferencesAsync sharedPreferences;
  Dio dioClient;

  AccessTokenHelper(this.sharedPreferences, this.dioClient);

  //Todo: GO Method to check if Token is Valid or not.
  Future<bool> isTokenValid() async {
    return true;
  }

  Future<void> updateRefreshToken() async {
    final getRefreshToken =
        await sharedPreferences.getString("refreshToken", defaultValue: "");
    final requestBody = RefreshTokenBodyRequest(refreshToken: getRefreshToken);

    final response =
        await dioClient.post("/refresh", data: requestBody.toJson());

    final tokenResponse = await networkResponseHandler(response);

    switch (tokenResponse) {
      case Success():
        final newAuthToken = tokenResponse.data as RefreshAuthTokenResponse;
        sharedPreferences.setString("accessToken", newAuthToken.accessToken);
      case Failure():
        print("Something went wrong");
    }
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
