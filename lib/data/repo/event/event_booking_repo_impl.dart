import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_payment_history_response.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_ticket_hisotry_response.dart';
import 'package:glint_frontend/data/remote/model/response/mapper/event_mapper.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/payment_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class EventBookingRepoImpl extends EventBookingRepo {
  final MyDioClient httpClient;

  EventBookingRepoImpl(
    this.httpClient,
  );

  @override
  Future<Result<void>> bookEvent(EventBookingRequestBody body) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/event/ticket/book",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return const Success("");
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<List<EventTicketHistoryDomainModel>>> getEventTicketHistory({
    int offset = 0,
  }) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/ticket/history",
      requestBody: null,
      passedQueryParameters: {'offset': offset},
    );

    switch (response) {
      case Success():
        final historyResponse =
            GetTicketHisotryResponse.fromJson(response.data);
        return Success(historyResponse.mapToDomainModel());
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<void>> cancelTicket(int orderId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/event/ticket/cancel",
      requestBody: {'order_id': orderId},
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return const Success("");
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<void>> cancelOrder(int orderId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/user/cancel-order",
      requestBody: {'order_id': orderId},
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return const Success("");
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<List<PaymentHistoryDomainModel>>> getPaymentHistory() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/user/payment-history",
      requestBody: null,
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final paymentHistoryResponse =
            GetPaymentHistoryResponse.fromJson(response.data['data']);
        return Success(paymentHistoryResponse.mapToDomainModel());
      case Failure():
        return Failure(Exception(response.error));
    }
  }
}
