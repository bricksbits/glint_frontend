import 'dart:async';
import 'dart:math';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUserUseCase extends UseCase<Result<UsersType>, LoginRequestBody> {
  final AuthenticationRepo authenticationRepo;

  SignInUserUseCase(this.authenticationRepo);

  @override
  Future<Stream<Result<UsersType>?>> buildUseCaseStream(
      LoginRequestBody? params) async {
    final StreamController<Result<UsersType>> controller = StreamController();
    try {
      authenticationRepo.login(params!).then((loginResponse) {
        switch (loginResponse) {
          case Success<LoginResponse>(data: _):
            var typeFound = loginResponse.data.profile?.userRole ?? "user";
            late final UsersType userType;
            switch (typeFound) {
              case 'user':
                userType = UsersType.USER;
                break;
              case 'admin':
                userType = UsersType.ADMIN;
                break;
              case 'super admin':
                userType = UsersType.SUPER_ADMIN;
                break;
              default:
                userType = UsersType.USER;
            }
            controller.add(Success(userType));
            controller.close();
          case Failure<LoginResponse>(error: var error):
            controller.addError(Failure(error));
            controller.close();
        }
      }).catchError((caughtError) {
        controller.addError(Failure(Exception(caughtError.toString())));
        controller.close();
      });
    } catch (e) {
      controller.addError(Failure(Exception(e.toString())));
      controller.close();
    }
    return controller.stream;
  }
}
