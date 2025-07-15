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
  Future<Result<void>> sendOtp(SendOtpRequestBody body) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/auth/v1/reset-password/generate-otp",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(
          Exception("Error : ${response.error} something went wrong,"),
        );
    }
  }

  @override
  Future<Result<void>> resetPasswordWithOtp(
    ResetPasswordWithOtpRequestBody body,
  ) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "auth/v1/reset-password/confirm",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Success(response);
      case Failure():
        return Failure(
          Exception("Error : Something went wrong, ${response.error}"),
        );
    }
  }
}
