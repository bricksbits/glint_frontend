import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class FetchEventsUseCase extends UseCase<List<EventListDomainModel>, void> {
  final EventRepo eventRepo;

  FetchEventsUseCase(this.eventRepo);

  @override
  Future<Stream<List<EventListDomainModel>?>> buildUseCaseStream(void params) async {
    final StreamController<List<EventListDomainModel>> controller = StreamController();
    try {
      final eventsResponse = await eventRepo.getAllEvents();
      switch (eventsResponse) {
      // TODO: Return the Required Type via the Repo
        case Success():
          // controller.add(eventsResponse.data
          controller.add([]);
          logger.finest('fetching events successful.');
        case Failure():
          controller.addError(eventsResponse.error);
          logger.severe('fetching events unsuccessful.');
          print(eventsResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
