import 'dart:async';

import 'package:glint_frontend/data/remote/model/request/auth/reset_password_with_otp_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordWithOtpUseCase extends UseCase<void, ResetPasswordWithOtpRequestBody> {
  final ForgotPasswordRepo forgotPasswordRepo;

  ResetPasswordWithOtpUseCase(this.forgotPasswordRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(ResetPasswordWithOtpRequestBody? params) async {
    final StreamController<Result<bool>> controller = StreamController();
    try {
      final resetPasswordResponse = await forgotPasswordRepo.resetPasswordWithOtp(params!);
      switch (resetPasswordResponse) {
        case Success():
          controller.add(const Success(true));
          logger.finest('Reset Password with OTP successful.');
        case Failure():
          controller.addError(resetPasswordResponse.error);
          logger.severe('Reset Password with OTP unsuccessful.');
          print(resetPasswordResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
} 