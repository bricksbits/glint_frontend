import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/network_response.dart' as api_response;
import 'package:glint_frontend/utils/network_response.dart';

class EventBookingRepoImpl extends EventBookingRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  EventBookingRepoImpl(this.httpClient, this.sharedPreferencesAsync);

  @override
  Future<NetworkResponse<void>> bookEvent(EventBookingRequestBody body) {
    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event/ticket/book",
      requestBody: body.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case api_response.Success():
        return Future.value(Success(data: response));
      case api_response.Failure():
        return Future.value(Failure(error: Exception()));
    }

    return Future.value(Failure(error: Exception()));
  }

  @override
  Future<NetworkResponse<void>> getUserTickets() {
    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event/ticket/history",
      requestBody: null,
      passedQueryParameters: null,
    );

    switch (response) {
      case api_response.Success():
        return Future.value(Success(data: response));
      case api_response.Failure():
        return Future.value(Failure(error: Exception()));
    }

    return Future.value(Failure(error: Exception()));
  }
}
