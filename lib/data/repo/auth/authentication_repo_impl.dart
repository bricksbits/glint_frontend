import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  AuthenticationRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<void>> createAccount() async {
    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPrefHelper: sharedPreferenceHelper,
      endpoint: "/registerUser",
      requestBody: null,
      passedQueryParameters: null,
    );

    return Future.value(Failure(Exception()));
  }

  @override
  Future<Result<LoginResponse>> login(LoginRequestBody loginRequestBody) async {
    final response = await safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      sharedPrefHelper: sharedPreferenceHelper,
      endpoint: "auth/v1/login",
      requestBody: loginRequestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final successResponse = LoginResponse.fromJson(response.data);
        final accessToken = successResponse.profile?.authToken;
        if (accessToken != null) {
          if (accessToken.isNotEmpty) {
            await sharedPreferenceHelper.saveString(
                SharedPreferenceKeys.accessTokenKey, accessToken);
          }
        }

        final refreshToken = successResponse.profile?.refreshToken;
        if (refreshToken != null) {
          if (refreshToken.isNotEmpty) {
            await sharedPreferenceHelper.saveString(
                SharedPreferenceKeys.refreshTokenKey, refreshToken);
          }
        }

        final tokenBufferTime = DateTime.now()
            .add(const Duration(minutes: 55))
            .microsecondsSinceEpoch;

        await sharedPreferenceHelper.saveInt(
            SharedPreferenceKeys.lastSavedTimeKey, tokenBufferTime);

        return Future.value(Success(successResponse));

      case Failure():
        return Future.value(Failure(Exception()));
    }
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> setAuthToken(String newAuthToken) async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    final sharedPreferencesAsync =
        EncryptedSharedPreferencesAsync.getInstance();
    sharedPreferencesAsync.setString("authToken", newAuthToken);
  }
}
