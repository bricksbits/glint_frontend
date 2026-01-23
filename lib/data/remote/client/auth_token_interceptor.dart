import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

///  Checks if the Access Token is Valid or not.
///  IF Not valid, we make another API call to update the Auth Token.
///  By using the Refresh Token
class AuthInterceptor extends QueuedInterceptorsWrapper {
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
  /// Based on the App Status, Navigate to Specific Error Screen
  /// Todo: Check with Wrong Credentials this will fail the onError Case
  /// Handle the Navigation effectively
  /// Remove Constants.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    const retriedKey = "retried";
    if (err.response?.statusCode == 401) {
      // Preventing looping for 401 queued error
      if (err.requestOptions.extra[retriedKey] == true) {
        return handler.next(err);
      }

      final refreshToken = await sharedPreferenceHelper
          .getString(SharedPreferenceKeys.refreshTokenKey);

      if (refreshToken.isEmpty) {
        _handleLogOutAndClearCache();
        return handler.next(err);
      }

      try {
        final response = await authClient.post('/refresh', data: {
          'refresh_token': refreshToken,
        });

        if (response.statusCode == 200) {
          final successResponse =
              RefreshAuthTokenResponse.fromJson(response.data);
          if (successResponse.accessToken != null &&
              successResponse.refreshToken != null) {
            await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.accessTokenKey,
              successResponse.accessToken!,
            );
            await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.refreshTokenKey,
              successResponse.refreshToken!,
            );
          }
          final newOptions = err.requestOptions;
          newOptions.headers['Auth'] = successResponse.accessToken;
          newOptions.extra[retriedKey] = true;
          final clone = await authClient.fetch(newOptions);
          return handler.resolve(clone);
        } else {
          _handleLogOutAndClearCache();
        }
      } catch (e) {
        _handleLogOutAndClearCache();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  void _handleLogOutAndClearCache() async {
    await sharedPreferenceHelper.clearEncryptedPrefs();
    GoRouter.of(rootNavigatorKey.currentContext!)
        .goNamed(GlintMainRoutes.splash.name);
  }
}
