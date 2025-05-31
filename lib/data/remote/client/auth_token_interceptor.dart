import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';

///  Checks if the Access Token is Valid or not.
///  IF Not valid, we make another API call to update the Auth Token.
///  By using the Refresh Token
class AuthInterceptor extends Interceptor {
  final Dio authClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  AuthInterceptor(this.sharedPreferenceHelper, this.authClient);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.accessTokenKey);
    if (accessToken.isNotEmpty) {
      options.headers['Auth'] = accessToken;
    }
    return handler.next(options);
  }

  /// Todo: Handle the Errors properly,
  /// Handle the Navigation effectively
  /// Remove Constants.
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final authState = rootNavigatorKey.currentState;
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final refreshToken = await sharedPreferenceHelper
          .getString(SharedPreferenceKeys.refreshTokenKey);

      if (refreshToken.isEmpty) {
        if (authState != null) {
          authState.pushNamed(GlintAdminDasboardRoutes.home.name);
          return;
        }
        return;
      }

      try {
        final response = await authClient.post('/refresh', data: {
          'refresh_token': refreshToken,
        });

        final successResponse =
            RefreshAuthTokenResponse.fromJson(response.data);
        final newRequest = err.requestOptions;
        if (successResponse.accessToken != null &&
            successResponse.refreshToken != null) {
          newRequest.headers['Auth'] = successResponse.accessToken;
          await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.accessTokenKey,
              successResponse.accessToken!);
          await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.refreshTokenKey,
              successResponse.refreshToken!);
        }

        final clone = await authClient.fetch(newRequest);
        return handler.resolve(clone);
      } catch (e) {
        // Token refresh failed, logout user
        await sharedPreferenceHelper.clearEncryptedPrefs();
        if (authState != null) {
          authState.pushNamed(GlintAdminDasboardRoutes.home.name);
          return;
        }
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
