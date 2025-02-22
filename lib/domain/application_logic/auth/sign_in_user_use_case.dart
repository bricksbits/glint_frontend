import 'dart:async';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class SignInUserUseCase
    extends UseCase<NetworkResponse<bool>, LoginRequestBody> {
  final AuthenticationRepo authenticationRepo;

  SignInUserUseCase(this.authenticationRepo);

  @override
  Future<Stream<NetworkResponse<bool>?>> buildUseCaseStream(
      LoginRequestBody? params) async {
    final StreamController<NetworkResponse<bool>> controller =
        StreamController();
    try {
      final loginResponse = await authenticationRepo.login(params!);
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
