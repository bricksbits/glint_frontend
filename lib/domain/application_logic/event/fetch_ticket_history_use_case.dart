import 'dart:async';

import 'package:glint_frontend/data/remote/model/response/event/ticket_history_response_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class FetchTicketHistoryUseCase extends UseCase<List<TicketHistory>, void> {
  final EventBookingRepo eventBookingRepo;

  FetchTicketHistoryUseCase(this.eventBookingRepo);

  @override
  Future<Stream<List<TicketHistory>?>> buildUseCaseStream(void params) async {
    final StreamController<List<TicketHistory>> controller = StreamController();
    try {
      final userTicketsHistoryResponse =
          await eventBookingRepo.getUserTickets();
      switch (userTicketsHistoryResponse) {
        case Success():
          // TODO: Return the Required Type via the Repo
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
