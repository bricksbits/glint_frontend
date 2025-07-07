import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class FetchEventDetailsUseCase extends UseCase<EventDetailsDomainModel, int> {
  final EventRepo eventRepo;

  FetchEventDetailsUseCase(this.eventRepo);

  @override
  Future<Stream<EventDetailsDomainModel?>> buildUseCaseStream(int? params) async {
    final StreamController<EventDetailsDomainModel?> controller =
        StreamController();
    try {
      final eventDetailsResponse = await eventRepo.getEventDetails(params);
      switch (eventDetailsResponse) {
        case Success():
          controller.add(null);
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
