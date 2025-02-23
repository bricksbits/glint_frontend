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
      final loginResponse = await forgotPasswordRepo.resetPassword(params!);
      switch (loginResponse) {
        case Success():
          controller.add(loginResponse.data);
          logger.finest('GetUsersUseCase successful.');
        case Failure():
          controller.addError(loginResponse.error);
          logger.severe('GetUsersUseCase unsuccessful.');
          print(loginResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
