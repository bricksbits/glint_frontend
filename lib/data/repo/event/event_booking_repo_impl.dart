import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/event/event_booking_request_body.dart';
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/event_booking_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart' as api_response;
import 'package:glint_frontend/utils/result_sealed.dart';

class EventBookingRepoImpl extends EventBookingRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  EventBookingRepoImpl(this.httpClient, this.sharedPreferencesAsync);

  @override
  Future<Result<void>> bookEvent(EventBookingRequestBody body) async {
    final response = await safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      sharedPreference: sharedPreferencesAsync,
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
  Future<Result<void>> getUserTickets() async {
    final response = await safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
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
