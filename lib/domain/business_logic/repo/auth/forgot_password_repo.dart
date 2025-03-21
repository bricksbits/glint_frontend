import 'package:glint_frontend/data/remote/model/request/auth/reset_password_request_body.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ForgotPasswordRepo {
  Future<Result<void>> provideEmailId();

  Future<Result<void>> provideOtp();

  Future<Result<void>> resetPassword(ResetPasswordRequestBody body);
}
