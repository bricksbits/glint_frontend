import 'dart:async';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUserUseCase
    extends UseCase<NetworkResponse<bool>, LoginRequestBody> {
  // final AuthenticationRepo authenticationRepo;

  SignInUserUseCase();
  // SignInUserUseCase(this.authenticationRepo);

  @override
  Future<Stream<NetworkResponse<bool>?>> buildUseCaseStream(
      LoginRequestBody? params) async {
    final StreamController<NetworkResponse<bool>> controller =
        StreamController();
    controller.addError(Exception("INJECTED Successfully"));
    // try {
    //   final loginResponse = await authenticationRepo.login(params!);
    //   switch (loginResponse) {
    //     case Success():
    //       print("Login usecase : Response ${loginResponse.data}");
    //       controller.add(loginResponse.data);
    //       logger.finest('GetUsersUseCase successful.');
    //     case Failure():
    //       controller.addError(loginResponse.error);
    //       logger.severe('GetUsersUseCase unsuccessful.');
    //       print("Login usecase : Error ${loginResponse.error}");
    //   }
    //   controller.close();
    // } catch (caughtError) {
    //   print("Login usecase : Error $caughtError");
    //   controller.addError(caughtError);
    // }

    return controller.stream;
  }
}
