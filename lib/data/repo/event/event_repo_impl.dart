import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/utils/safe_api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/network_response.dart' as api_response;
import 'package:glint_frontend/utils/network_response.dart';

class EventRepoImpl extends EventRepo {
  final MyDioClient httpClient;
  final EncryptedSharedPreferencesAsync sharedPreferencesAsync;

  EventRepoImpl(this.httpClient, this.sharedPreferencesAsync);

  @override
  Future<NetworkResponse<void>> fetchInterestedProfiles(int? eventId) {
    // if (eventId == null) return Future.value(Failure(error: Exception()));

    // final response = safeApiCallHandler(
    //   httpClient: httpClient,
    //   requestType: HttpRequestEnum.GET,
    //   sharedPreference: sharedPreferencesAsync,
    //   endpoint: "/event/$eventId/profiles",
    //   requestBody: null,
    //   passedQueryParameters: null,
    // );
    //
    // switch (response) {
    //   case api_response.Success():
    //     return Future.value(
    //         // Success(data: response.data),
    //         );
    //   case api_response.Failure():
    // return Future.value(Failure(error: Exception()));

    // return Future.value(Failure(error: Exception()));
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> filterEvents() {
    // TODO: implement filterEvents
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> getAllEvents() {
    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event",
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

  @override
  Future<NetworkResponse<void>> getEventDetails(int? eventId) {
    if (eventId == null) return Future.value(Failure(error: Exception()));

    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event/$eventId/details",
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

  @override
  Future<NetworkResponse<void>> userInterested(int? eventId) {
    if (eventId == null) return Future.value(Failure(error: Exception()));

    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event/$eventId/like",
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
