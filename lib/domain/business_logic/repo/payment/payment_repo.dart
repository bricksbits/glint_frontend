import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart';
import 'package:glint_frontend/data/remote/model/response/payment/buy_membership_response.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class PaymentRepo {
  Future<Result<BookEventResponse>> bookEvent(
    String eventId,
    String matchId,
  );

  Future<Result<BuyMembershipResponse>> buyMembership(
    MembershipType membershipType,
    String price,
    String timePeriod,
  );

  Future<Result<void>> verifyPayment(
    int orderId,
    String paymentId,
  );

  Future<Result<void>> cancelOrder(String orderId);
}
