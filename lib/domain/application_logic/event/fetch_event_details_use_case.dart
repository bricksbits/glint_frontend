import 'dart:async';

import 'package:glint_frontend/data/remote/model/response/event/event_details_response.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class FetchEventDetailsUseCase extends UseCase<EventDetailsResponse, int> {
  final EventRepo eventRepo;

  FetchEventDetailsUseCase(this.eventRepo);

  @override
  Future<Stream<EventDetailsResponse?>> buildUseCaseStream(int? params) async {
    final StreamController<EventDetailsResponse?> controller =
        StreamController();
    try {
      final eventDetailsResponse = await eventRepo.getEventDetails(params);
      switch (eventDetailsResponse) {
        case Success():
          controller.add(eventDetailsResponse.data);
          logger.finest('fetching event details successful.');
        case Failure():
          controller.addError(eventDetailsResponse.error);
          logger.severe('fetching event details unsuccessful.');
          print(eventDetailsResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
