import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  AuthenticationRepoImpl(
    this.httpClient,
    this.sharedPreferencesAsync,
  );

  @override
  Future<Result<void>> createAccount() async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    final sharedPreferencesAsync =
        EncryptedSharedPreferencesAsync.getInstance();

    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
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
      sharedPreference: sharedPreferencesAsync,
      endpoint: "auth/v1/login",
      requestBody: loginRequestBody.toJson(),
      passedQueryParameters: null,
    );

    print("Repo : Initial --> $response");
    switch (response) {
      case Success():
        final successResponse = LoginResponse.fromJson(response.data);
        print("Repo : Raw --> $response");
        print("Repo : Converted --> $successResponse");
        return Future.value(Success(successResponse));
      case Failure():
        print("Repo : Failure Called");
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
