import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class EventRepoImpl extends EventRepo {
  final MyDioClient httpClient;

  EventRepoImpl(
    this.httpClient,
  );

  @override
  Future<Result<void>> fetchInterestedProfiles(int? eventId) async {
    if (eventId == null) return Result.failure(Exception("Event Id is null"));

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/$eventId/profiles",
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

  @override
  Future<Result<void>> filterEvents() {
    // TODO: implement filterEvents
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> getAllEvents() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event",
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

  @override
  Future<Result<void>> getEventDetails(int? eventId) async {
    if (eventId == null) return Result.failure(Exception("Event Id is null"));

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/$eventId/details",
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

  @override
  Future<Result<void>> userInterested(int? eventId) async {
    if (eventId == null) return Result.failure(Exception("Event Id is null"));

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/event/$eventId/like",
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
