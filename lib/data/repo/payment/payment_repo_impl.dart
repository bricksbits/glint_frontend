import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/payment/book_event_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/payment/buy_membership_request.dart';
import 'package:glint_frontend/data/remote/model/request/payment/verify_payment_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/payment/book_event_response.dart'
    as bookEventResponse;
import 'package:glint_frontend/data/remote/model/response/payment/buy_membership_response.dart';
import 'package:glint_frontend/data/remote/model/response/payment/payment_history_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/payment/payment_repo.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PaymentRepo)
class PaymentRepoImpl extends PaymentRepo {
  final MyDioClient httpClient;

  PaymentRepoImpl(this.httpClient);

  @override
  Future<Result<bookEventResponse.BookEventResponse>> bookEvent(
    String eventId,
    String matchId,
  ) async {
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
  Future<Result<BuyMembershipResponse>> buyMembership(
      MembershipType membershipType, String price, String timePeriod) async {
    final requestBody = BuyMembershipRequest(
      price: int.parse(price),
      numberOfDays: int.parse(timePeriod),
      membershipType: membershipType.name.toLowerCase(),
    );

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "user/background",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final successResponse = BuyMembershipResponse.fromJson(response.data);
        return Success(successResponse);
      case Failure():
        return Failure(Exception("Can't get the Membership, please try again"));
    }
  }

  @override
  Future<Result<void>> cancelOrder(String orderId) async {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> verifyPayment(
    int orderId,
    String paymentId,
  ) async {
    final requestBody = VerifyPaymentRequestBody(
        orderId: orderId, razorpayPaymentId: paymentId);

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

  @override
  Future<Result<void>> fetchPaymentHistory() async {
    final historyResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "user/payment-history",
      requestBody: null,
      passedQueryParameters: null,
    );

    switch (historyResponse) {
      case Success():
        var historyModel =
            PaymentHistoryResponse.fromJson(historyResponse.data);
        return Success(true);
      case Failure():
        return Failure(
            Exception("Something went wrong, not able to load history data."));
    }
  }
}
