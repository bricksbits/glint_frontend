import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/refresh_token_body_request.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/data/remote/utils/network_response_handler.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccessTokenHelper {
  AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  MyDioClient httpClient;

  AccessTokenHelper(
    this.sharedPreferenceHelper,
    this.httpClient,
  );

  Future<bool> isTokenValid() async {
    final inBoundTime = await sharedPreferenceHelper
        .getInt(SharedPreferenceKeys.lastSavedTimeKey);
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    final accessToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.accessTokenKey);

    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    if (inBoundTime >= currentTime) {
      return true;
    }

    return false;
  }

  Future<void> updateRefreshToken() async {
    final getRefreshToken =
        await sharedPreferenceHelper.getString("refreshToken");
    final requestBody = RefreshTokenBodyRequest(refreshToken: getRefreshToken);

    final response = await httpClient.postRequest(
      endpoint: "/refresh",
      body: requestBody.toJson(),
      accessToken: null,
    );

    switch (response) {
      case Success():
        final successResponse =
            RefreshAuthTokenResponse.fromJson(response.data);

        //Todo: Make better time control here.
        final epochWithBuffer = DateTime.now()
            .add(const Duration(minutes: 55))
            .microsecondsSinceEpoch;

        await sharedPreferenceHelper.saveString(
            SharedPreferenceKeys.accessTokenKey,
            successResponse.accessToken ?? "");

        await sharedPreferenceHelper.saveString(
            SharedPreferenceKeys.refreshTokenKey,
            successResponse.refreshToken ?? "");

        await sharedPreferenceHelper.saveInt(
            SharedPreferenceKeys.lastSavedTimeKey, epochWithBuffer);

      case Failure():
        print("Something Went Wrong");
        throw Exception(response.error);
    }
  }
}
