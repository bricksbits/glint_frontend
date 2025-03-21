import 'dart:async';

import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class FetchEventInterestedProfilesUseCase extends UseCase<List<Profile>, int> {
  final EventRepo eventRepo;

  FetchEventInterestedProfilesUseCase(this.eventRepo);

  /// Your Usecase design is all correct just return the required return
  /// type that is required by the Usecase
  /// Currently you are trying to Return `List<Profile>` but your repo
  /// Method is returning Void
  @override
  Future<Stream<List<Profile>?>> buildUseCaseStream(int? params) async {
    final StreamController<List<Profile>> controller = StreamController();
    try {
      final eventInterestedProfilesResponse =
          await eventRepo.fetchInterestedProfiles(params);
      switch (eventInterestedProfilesResponse) {
        case Success():
          controller.add([]);
          logger.finest('fetching event details successful.');
        case Failure():
          controller.addError(eventInterestedProfilesResponse.error);
          logger.severe('fetching event details unsuccessful.');
          print(eventInterestedProfilesResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
