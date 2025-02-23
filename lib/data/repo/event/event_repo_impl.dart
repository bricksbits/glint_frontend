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
  Future<NetworkResponse<void>> fetchInterestedProfiles() {
    // TODO: implement fetchInterestedProfiles
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> filterEvents() {
    // TODO: implement filterEvents
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> getEventDetails(int? eventId) {
    final id = eventId ?? 1; // todo - change/ remove this later

    final response = safeApiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      sharedPreference: sharedPreferencesAsync,
      endpoint: "/event/$id/details",
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
  Future<NetworkResponse<void>> userInterested() {
    // TODO: implement userInterested
    throw UnimplementedError();
  }
}
