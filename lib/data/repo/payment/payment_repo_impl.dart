import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/payment/book_event_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/payment/verify_payment_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart'
    as bookEventResponse;
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PaymentRepo)
class PaymentRepoImpl extends PaymentRepo {
  final MyDioClient httpClient;

  PaymentRepoImpl(this.httpClient);

  @override
  Future<Result<bookEventResponse.BookEventResponse>> bookEvent(
      String eventId, String matchId) async {
    final requestBody = BookEventRequestBody(
      eventId: int.parse(eventId),
      matchId: int.parse(matchId),
    );

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/event/ticket/book",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final successResponse =
            bookEventResponse.BookEventResponse.fromJson(response.data);
        return Success(successResponse);
      case Failure():
        return Failure(Exception("Can't Book the ticket, please try again"));
    }
  }

  @override
  Future<Result<void>> buyMembership(
      MembershipType membershipType, String price, String timePeriod) async {
    // TODO: implement buyMembership
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> cancelOrder(String orderId) async {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> verifyPayment(String orderId, String paymentId) async {
    final requestBody = VerifyPaymentRequestBody(
        orderId: int.parse(orderId), razorpayPaymentId: paymentId);

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "user/verify-payment",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final successResponse = response.data;
        if (successResponse != null) {
          print("Verify Payment : $successResponse");
        }
        return Success("data");
      case Failure():
        return Failure(Exception("Can't make the payment, please try again"));
    }
  }
}
