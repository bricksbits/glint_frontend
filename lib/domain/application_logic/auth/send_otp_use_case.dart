import 'dart:async';

import 'package:glint_frontend/data/remote/model/request/auth/send_otp_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendOtpUseCase extends UseCase<void, SendOtpRequestBody> {
  final ForgotPasswordRepo forgotPasswordRepo;

  SendOtpUseCase(this.forgotPasswordRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(SendOtpRequestBody? params) async {
    final StreamController<Result<bool>> controller = StreamController();
    try {
      final sendOtpResponse = await forgotPasswordRepo.sendOtp(params!);
      switch (sendOtpResponse) {
        case Success():
          controller.add(const Success(true));
          logger.finest('Send OTP successful.');
        case Failure():
          controller.addError(sendOtpResponse.error);
          logger.severe('Send OTP unsuccessful.');
          print(sendOtpResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
} 