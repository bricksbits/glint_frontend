import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/model/response/auth/refresh_auth_token_response.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/app_config.dart';
import 'package:go_router/go_router.dart';

///  Checks if the Access Token is Valid or not.
///  IF Not valid, we make another API call to update the Auth Token.
///  By using the Refresh Token
class AuthInterceptor extends QueuedInterceptorsWrapper {
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final freshDioClient = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  );

  AuthInterceptor(
    this.sharedPreferenceHelper,
  );

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
    final isAuthTokenAvailable = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.accessTokenKey);

    if (isAuthTokenAvailable.isEmpty) {
      return handler.next(err);
    }

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
        final response = await freshDioClient.post('auth/v1/refresh', data: {
          'refresh_token': refreshToken,
        });

        if (response.statusCode == 200) {
          final successResponse =
              UniversalSuccessResponseBody<RefreshAuthTokenResponse>.fromJson(
            response.data,
            (json) => RefreshAuthTokenResponse.fromJson(json),
          );
          if (successResponse.data?.accessToken != null &&
              successResponse.data?.refreshToken != null) {
            await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.accessTokenKey,
              successResponse.data!.accessToken!,
            );
            await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.refreshTokenKey,
              successResponse.data!.refreshToken!,
            );
            final newStreamToken = successResponse.data?.streamAuthToken;
            if (newStreamToken != null && newStreamToken.isNotEmpty) {
              await sharedPreferenceHelper.saveString(
                SharedPreferenceKeys.streamTokenKey,
                newStreamToken,
              );
            }
          }
          final newOptions = err.requestOptions;
          newOptions.headers['Auth'] = successResponse.data!.accessToken;
          newOptions.extra[retriedKey] = true;

          final clone = await freshDioClient.fetch(newOptions);
          return handler.resolve(clone);
        } else {
          _handleLogOutAndClearCache();
          return handler.next(err);
        }
      } catch (e) {
        _handleLogOutAndClearCache();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  //Todo: Clear the Database as well.
  void _handleLogOutAndClearCache() async {
    await sharedPreferenceHelper.clearEncryptedPrefs();
    final ctx = rootNavigatorKey.currentContext;
    if (ctx == null || !ctx.mounted) return;
    showCustomSnackbar(
      ctx,
      message: "Your Security is our top priority",
      isError: true,
    );
    GoRouter.of(ctx).goNamed(GlintMainRoutes.starter.name);
  }
}
