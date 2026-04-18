import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/common/pagination_params.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FetchTicketHistoryUseCase
    extends UseCase<List<EventTicketHistoryDomainModel>, PaginationParams> {
  final EventRepo eventRepo;

  FetchTicketHistoryUseCase(this.eventRepo);

  @override
  Future<Stream<List<EventTicketHistoryDomainModel>?>> buildUseCaseStream(
      PaginationParams? params) async {
    final StreamController<List<EventTicketHistoryDomainModel>> controller =
        StreamController();
    try {
      final offset = params?.offset ?? 0;
      final userTicketsHistoryResponse =
          await eventRepo.getEventTicketHistory(offset: offset);
      switch (userTicketsHistoryResponse) {
        case Success():
          controller.add(userTicketsHistoryResponse.data);
          logger.finest('fetching ticket history successful.');
        case Failure():
          controller.addError(userTicketsHistoryResponse.error);
          logger.severe('fetching ticket history unsuccessful.');
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
      controller.close();
    }

    return controller.stream;
  }
}
