import 'package:glint_frontend/data/remote/model/request/auth/reset_password_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/reset_password_with_otp_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/send_otp_request_body.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ForgotPasswordRepo {
  /// Get the Entered Email, and use that to produce the OTP
  /// User when enter the OTP, lead to reset Password Screen
  Future<Result<void>> sendOtp(SendOtpRequestBody body);

  /// Use the Entered OTP, Email and Reset Password
  /// To first reset the password and then use the new credentials
  /// To Login the User Again.
  Future<Result<void>> resetPasswordWithOtp(
      ResetPasswordWithOtpRequestBody body);
}
