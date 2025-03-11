import 'dart:async';

import 'package:glint_frontend/data/remote/model/request/auth/reset_password_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';

import '../../../utils/network_response.dart';

class ResetPasswordUseCase extends UseCase<void, ResetPasswordRequestBody> {
  final ForgotPasswordRepo forgotPasswordRepo;

  ResetPasswordUseCase(this.forgotPasswordRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(
      ResetPasswordRequestBody? params) async {
    final StreamController<NetworkResponse<bool>> controller =
        StreamController();
    try {
      final resetPasswordResponse =
          await forgotPasswordRepo.resetPassword(params!);
      switch (resetPasswordResponse) {
        case Success():
          controller.add(resetPasswordResponse.data);
          logger.finest('Reset Password successful.');
        case Failure():
          controller.addError(resetPasswordResponse.error);
          logger.severe('Reset Password unsuccessful.');
          print(resetPasswordResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
