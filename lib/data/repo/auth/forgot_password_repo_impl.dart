import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/reset_password_request_body.dart';
import 'package:glint_frontend/data/remote/utils/api_response.dart'
    as api_response;
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl extends ForgotPasswordRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  ForgotPasswordRepoImpl(
    this.httpClient,
    this.sharedPreferencesAsync,
  );

  @override
  Future<NetworkResponse<void>> provideEmailId() {
    // TODO: implement provideEmailId
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> provideOtp() {
    // TODO: implement provideOtp
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> resetPassword(ResetPasswordRequestBody body) {
    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/reset-password",
      requestBody: body.toJson(),
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
}
