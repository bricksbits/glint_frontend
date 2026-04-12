import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/payment_history_domain_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class EventBookingRepo {
  Future<Result<List<EventTicketHistoryDomainModel>>> getEventTicketHistory({
    int offset = 0,
  });

  Future<Result<void>> bookEvent(EventBookingRequestBody body);

  Future<Result<void>> cancelTicket(int orderId);

  Future<Result<void>> cancelOrder(int orderId);

  Future<Result<List<PaymentHistoryDomainModel>>> getPaymentHistory();
}
