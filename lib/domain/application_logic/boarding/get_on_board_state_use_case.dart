import 'dart:async';

import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/forgot_password_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';

class GetOnBoardStateUseCase extends UseCase<void, String> {
  final OnBoardingRepo onBoardingRepo;

  GetOnBoardStateUseCase(this.onBoardingRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(String? params) {
    final StreamController<int> controller = StreamController();
    throw UnimplementedError();
  }
}
