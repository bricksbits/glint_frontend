import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/reset_password_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/reset_password_with_otp_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/send_otp_request_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl extends ForgotPasswordRepo {
  final MyDioClient httpClient;

  ForgotPasswordRepoImpl(
    this.httpClient,
  );

  @override
  Future<Result<void>> provideEmailId() {
    // TODO: implement provideEmailId
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> provideOtp() {
    // TODO: implement provideOtp
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> resetPassword(ResetPasswordRequestBody body) {
    final response = apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/reset-password",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Future.value(Success(response));
      case Failure():
        return Future.value(Failure(Exception()));
    }

    return Future.value(Failure(Exception()));
  }

  @override
  Future<Result<void>> sendOtp(SendOtpRequestBody body) {
    final response = apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/send-otp",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Future.value(Success(response));
      case Failure():
        return Future.value(Failure(Exception()));
    }

    return Future.value(Failure(Exception()));
  }

  @override
  Future<Result<void>> resetPasswordWithOtp(ResetPasswordWithOtpRequestBody body) {
    final response = apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/reset-password-with-otp",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Future.value(Success(response));
      case Failure():
        return Future.value(Failure(Exception()));
    }

    return Future.value(Failure(Exception()));
  }
}
