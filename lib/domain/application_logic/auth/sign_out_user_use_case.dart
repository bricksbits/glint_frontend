import 'dart:async';

import 'package:glint_frontend/utils/clean_arch_use_case.dart';

class SignOutUserUseCase extends CompletableUseCase {

  @override
  Future<Stream<void>> buildUseCaseStream(params) {
    final StreamController<void> controller = StreamController();
    throw UnimplementedError();
  }
}