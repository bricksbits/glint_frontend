import 'package:glint_frontend/data/local/db/dao/event_like_dao.dart';
import 'package:glint_frontend/data/local/db/entities/user_event_like_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_all_events_response.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_event_details_response.dart';
import 'package:glint_frontend/data/remote/model/response/event/get_user_interested_for_event_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EventRepo)
class EventRepoImpl extends EventRepo {
  final MyDioClient httpClient;
  final EventLikeDao eventLikeDao;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  EventRepoImpl(
    this.httpClient,
    this.eventLikeDao,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<List<PeopleCardModel>>> fetchInterestedProfiles(
      int? eventId) async {
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
        var people = GetUserInterestedForEventResponse.fromJson(response.data);
        return Success(people.mapToPeopleCard());
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<List<EventListDomainModel>>> getAllEvents() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event",
      requestBody: null,
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        final events = GetAllEventsResponse.fromJson(response.data);
        return Success(events.mapToDomain());
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  @override
  Future<Result<EventDetailsDomainModel>> getEventDetails(int? eventId) async {
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
        final details = GetEventDetailsResponse.fromJson(response.data);
        return Success(details.mapToDomain());
      case Failure():
        return Failure(Exception(response.error));
    }
  }

  /// A Weak try to optimize the Event Interested Request again and again
  /// If the event already exists in the Local DB Avoid the API call altogether
  @override
  Future<Result<void>> userInterested(int? eventId) async {
    var userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    if (eventId == null) return Result.failure(Exception("Event Id is null"));
    var userEventEntities = await eventLikeDao.getLikedEvents(userId);
    var filterList = userEventEntities
        .where((entity) => entity.eventId == eventId.toString())
        .toList();
    if (filterList.isEmpty) {
      final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.POST,
        endpoint: "/event/$eventId/like",
        requestBody: null,
        passedQueryParameters: null,
      );

      switch (response) {
        case Success():
          await eventLikeDao.likeEvent(
            UserEventLikeEntity(
              userId: userId,
              eventId: eventId.toString(),
            ),
          );
          return Success(response.data);
        case Failure():
          return Failure(Exception(response.error));
      }
    } else {
      return const Success("User Already liked the event");
    }
  }
}
