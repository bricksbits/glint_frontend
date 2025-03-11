import 'dart:async';

import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/network_response.dart';

class EventBookUseCase extends UseCase<void, EventBookingRequestBody> {
  final EventBookingRepo eventBookingRepo;

  EventBookUseCase(this.eventBookingRepo);

  @override
  Future<Stream<void>> buildUseCaseStream(
      EventBookingRequestBody? params) async {
    final StreamController<NetworkResponse<bool>> controller =
        StreamController();
    try {
      final eventBookingResponse = await eventBookingRepo.bookEvent(params!);
      switch (eventBookingResponse) {
        case Success():
          controller.add(eventBookingResponse.data);
          logger.finest('event booking successful.');
        case Failure():
          controller.addError(eventBookingResponse.error);
          logger.severe('event booking unsuccessful.');
          print(eventBookingResponse.error);
      }
      controller.close();
    } catch (caughtError) {
      controller.addError(caughtError);
    }

    return controller.stream;
  }
}
