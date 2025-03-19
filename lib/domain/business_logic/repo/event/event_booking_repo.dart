import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/utils/network_response.dart';

abstract class EventBookingRepo {
  Future<Result<void>> getUserTickets();

  Future<Result<void>> bookEvent(EventBookingRequestBody body);
}
