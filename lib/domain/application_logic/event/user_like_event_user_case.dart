import 'dart:async';

import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class UserLikedEventUseCase extends UseCase<void, int> {
  final EventRepo eventRepo;

  UserLikedEventUseCase(this.eventRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(int? params) async {
    final StreamController<NetworkResponse<bool>> controller =
        StreamController();
    try {
      final loginResponse = await eventRepo.userInterested(params!);
      switch (loginResponse) {
        case Success():
          controller.add(loginResponse.data);
          logger.finest('like event successful.');
        case Failure():
          controller.addError(loginResponse.error);
          logger.severe('like event unsuccessful.');
          print(loginResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
