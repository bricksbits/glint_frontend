import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/utils/api_response.dart'
    as api_response;
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
    this.sharedPreferencesAsync ,
  );

  // final EncryptedSharedPreferencesAsync

  @override
  Future<NetworkResponse<void>> createAccount() async {
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

    switch (response) {
      case api_response.Success():
        return Future.value(Success(data: response));
      case api_response.Failure():
        return Future.value(Failure(error: Exception()));
    }

    return Future.value(Failure(error: Exception()));
  }

  @override
  Future<NetworkResponse<void>> login(LoginRequestBody loginRequestBody) async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    final sharedPreferencesAsync =
        EncryptedSharedPreferencesAsync.getInstance();

    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/login",
      requestBody: loginRequestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case api_response.Success():
        print(
            "Login Repo : Success Called with Response : ${(response as LoginResponse).toJson()}");
        return Future.value(Success(data: response));
      case api_response.Failure():
        print("Login Repo : Failure Called");
        return Future.value(Failure(error: Exception()));
    }

    print("Login Repo : Failure Called");
    return Future.value(
      Failure(
        error: Exception("Something went wrong"),
      ),
    );
  }

  @override
  Future<NetworkResponse<void>> logout() {
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
