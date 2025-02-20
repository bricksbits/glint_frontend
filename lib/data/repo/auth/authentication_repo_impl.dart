import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/utils/api_response.dart'
    as api_response;
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  AuthenticationRepoImpl(this.httpClient, this.sharedPreferencesAsync);

  @override
  Future<NetworkResponse<void>> createAccount() {
    final response = safeApiCallHandler(
        httpClient, HttpRequestEnum.GET, "", sharedPreferencesAsync, null);

    switch (response) {
      case api_response.Success():
        return Future.value(Success(data: response));
      case api_response.Failure():
        return Future.value(Failure(error: Exception()));
    }

    return Future.value(Failure(error: Exception()));
  }

  @override
  Future<NetworkResponse<void>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> setAuthToken() {
    // TODO: implement setAuthToken
    throw UnimplementedError();
  }
}
