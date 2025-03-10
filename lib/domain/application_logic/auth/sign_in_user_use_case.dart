import 'dart:async';
import 'dart:math';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUserUseCase extends UseCase<Result<bool>, LoginRequestBody> {
  final AuthenticationRepo authenticationRepo;

  SignInUserUseCase(this.authenticationRepo);

  @override
  Future<Stream<Result<bool>?>> buildUseCaseStream(
      LoginRequestBody? params) async {
    final StreamController<Result<bool>> controller = StreamController();
    try {
      final loginResponse = await authenticationRepo.login(params!);
      switch (loginResponse) {
        case Success<LoginResponse>():
          controller.add(const Success(true));
        case Failure<LoginResponse>():
          controller.addError(Failure(loginResponse.error));
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
