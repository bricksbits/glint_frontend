import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_ticket_history_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart' as api_response;
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
        return Success(response.data);
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<List<EventTicketHistoryDomainModel>>>
      getEventTicketHistory() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/ticket/history",
      requestBody: null,
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Success(response.data);
      case Failure():
        return Failure(Exception(response.error));
    }
  }
}
