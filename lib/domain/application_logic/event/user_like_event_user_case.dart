import 'dart:async';

import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class UserLikedEventUseCase extends UseCase<void, int> {
  final EventRepo eventRepo;

  UserLikedEventUseCase(this.eventRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(int? params) async {
    final StreamController<Result<bool>> controller =
        StreamController();
    try {
      final userLikedResponse = await eventRepo.userInterested(params!);
      switch (userLikedResponse) {
        case Success():
          controller.add(const Success(true));
          logger.finest('like event successful.');
        case Failure():
          controller.addError(userLikedResponse.error);
          logger.severe('like event unsuccessful.');
          print(userLikedResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
