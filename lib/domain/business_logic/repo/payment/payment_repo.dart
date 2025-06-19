import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class PaymentRepo {
  Future<Result<BookEventResponse>> bookEvent(
    String eventId,
    String matchId,
  );

  Future<Result<void>> buyMembership(
    MembershipType membershipType,
    String price,
    String timePeriod,
  );

  Future<Result<void>> verifyPayment(
    String orderId,
    String paymentId,
  );

  Future<Result<void>> cancelOrder(String orderId);
}

enum MembershipType {
  SILVER,
  GOLD,
  PLATINUM,
}
