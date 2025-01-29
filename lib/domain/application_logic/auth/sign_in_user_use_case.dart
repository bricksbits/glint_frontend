import 'dart:async';

import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';

class SignInUserUseCase extends CompletableUseCase {
  final AuthenticationRepo authenticationRepo;

  SignInUserUseCase(this.authenticationRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(params) {
    final StreamController<int> controller = StreamController();
    throw UnimplementedError();
  }
}
