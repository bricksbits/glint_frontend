import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class FetchTicketHistoryUseCase extends UseCase<List<EventTicketHistoryDomainModel>, void> {
  final EventBookingRepo eventBookingRepo;

  FetchTicketHistoryUseCase(this.eventBookingRepo);

  @override
  Future<Stream<List<EventTicketHistoryDomainModel>?>> buildUseCaseStream(void params) async {
    final StreamController<List<EventTicketHistoryDomainModel>> controller = StreamController();
    try {
      final userTicketsHistoryResponse =
          await eventBookingRepo.getEventTicketHistory();
      switch (userTicketsHistoryResponse) {
        case Success():
          controller.add([]);
          logger.finest('fetching event details successful.');
        case Failure():
          controller.addError(userTicketsHistoryResponse.error);
          logger.severe('fetching event details unsuccessful.');
          print(userTicketsHistoryResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
