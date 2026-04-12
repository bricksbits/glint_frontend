import 'dart:io';
import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/admin/approve_or_reject_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/admin/delete_event_content_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/admin/pause_event_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/admin/admin_mappers.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_event_stats_for_admin.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_interested_users_response.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_published_event_response.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_ticket_booked_response.dart';
import 'package:glint_frontend/data/remote/model/response/admin/upload_temp_images_response.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/application_logic/auth/is_user_logged_in_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_stats_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AdminDashboardRepo)
class AdminDashBoardRepoImpl extends AdminDashboardRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;

  AdminDashBoardRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.profileDao,
  );

  @override
  Future<Result<void>> approveEvent(
      EventApproveOrRejectDomainModel approveList) async {
    final requestBody = ApproveOrRejectRequestBody(
      approvals: [
        Approvals(
            eventId: int.parse(approveList.eventId),
            isApproved: approveList.isApproved)
      ],
    );

    final approveRequestResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/event/manage/super-admin/approval",
      requestBody: requestBody.toJson(),
    );

    switch (approveRequestResponse) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(Exception("Something Went wrong"));
    }
  }

  @override
  Future<Result<String>> uploadTempEventImages(List<File> images) async {
    FormData formData = FormData();
    for (final file in images) {
      formData.files.add(
        MapEntry(
          "picture",
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.UPLOAD,
      endpoint: "/event/manage/event-admin/images/temp",
      uploadFilesFormData: formData,
    );

    switch (response) {
      case Success():
        final parsed =
            UniversalSuccessResponseBody<UploadTempImagesResponse>.fromJson(
          response.data,
          (json) => UploadTempImagesResponse.fromJson(json),
        );
        if (parsed.success && parsed.data?.tempId != null) {
          return Success(parsed.data!.tempId!);
        } else {
          return Failure(Exception(parsed.message));
        }
      case Failure():
        return Failure(
          Exception("Failed to upload images, please try again."),
        );
    }
  }

  @override
  Future<Result<void>> createEvent(
    CreateEventRequestDomainModel createEventRequest,
  ) async {
    final createRequestBody = createEventRequest.mapToRequestBody();
    final createEventResponse = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.POST,
        endpoint: "/event/manage/event-admin/create",
        requestBody: createRequestBody.toJson());

    switch (createEventResponse) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(createEventResponse.error);
    }
  }

  @override
  Future<Result<void>> editEvent(
      CreateEventRequestDomainModel createEventRequest) async {
    final eventRequestBody = createEventRequest.mapToUpdateRequestBody();
    final createEventRequestResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/event/manage/event-admin/edit",
      requestBody: eventRequestBody.toJson(),
    );

    switch (createEventRequestResponse) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(createEventRequestResponse.error);
    }
  }

  @override
  Future<Result<void>> uploadEventMediaFiles(
      String eventId, List<File> event) async {
    FormData formData = FormData();
    for (int i = 0; i < event.length; i++) {
      final file = event[i];
      if (file != null) {
        formData.files.add(
          MapEntry(
            "picture",
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.UPLOAD,
      endpoint: "event/$eventId/content",
      uploadFilesFormData: formData,
    );

    switch (response) {
      case Success():
        return const Success("File Uploaded successfully");
      case Failure():
        return Failure(
          Exception("Not able to upload files currently, please try again."),
        );
    }
  }

  @override
  Future<Result<void>> deleteEventContent(
    String eventId,
    List<String> pictureList,
    List<String> videoList,
  ) async {
    final requestBody = DeleteEventContentRequestBody(
      pictureList: pictureList,
      videoList: videoList,
    );

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.DELETE,
      endpoint: "/event/$eventId/content",
      requestBody: requestBody.toJson(),
    );

    switch (response) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(response.error);
    }
  }

  @override
  Future<Result<void>> pauseEvent(String eventId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/event/$eventId/manage/event-admin/pause",
      requestBody: PauseEventRequestBody(isPaused: true).toJson(),
    );

    switch (response) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(response.error);
    }
  }

  @override
  Future<Result<void>> unpauseEvent(String eventId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/event/$eventId/manage/event-admin/pause",
      requestBody: PauseEventRequestBody(isPaused: false).toJson(),
    );

    switch (response) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(response.error);
    }
  }

  @override
  Future<Result<void>> deleteEvent(String eventId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.DELETE,
      endpoint: "/event/$eventId/manage/event-admin",
    );

    switch (response) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(response.error);
    }
  }

  @override
  Future<Result<EventStatsDomainModel>> getEventAdminStats(int eventId) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/$eventId/manage/event-admin/stats",
    );

    switch (response) {
      case Success():
        final parsed =
            UniversalSuccessResponseBody<GetEventStatsForAdmin>.fromJson(
          response.data,
          (json) => GetEventStatsForAdmin.fromJson(json),
        );
        if (parsed.success && parsed.data != null) {
          return Success(parsed.data!.mapToDomain());
        } else {
          return Failure(Exception(parsed.message));
        }
      case Failure():
        return Failure(response.error);
    }
  }

  @override
  Future<Result<List<EventTicketBoughtDomainModel>>> fetchBookedTicketList(
    int eventId,
  ) async {
    late String fetchTicketBoughtUserEndpoint;
    var currentUserKey = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userRoleKey);

    var userRole = getUserTypeFromName(currentUserKey);
    switch (userRole) {
      case UsersType.USER:
        fetchTicketBoughtUserEndpoint = "";
        break;
      case UsersType.ADMIN:
        fetchTicketBoughtUserEndpoint =
            "/event/$eventId/manage/event-admin/booked-tickets";
        break;
      case UsersType.SUPER_ADMIN:
        fetchTicketBoughtUserEndpoint =
            "/event/$eventId/manage/super-admin/booked-tickets";
        break;
    }

    final ticketBookedUsers = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: fetchTicketBoughtUserEndpoint,
      passedQueryParameters: {"offset": 0},
    );

    switch (ticketBookedUsers) {
      case Success():
        final response =
            UniversalSuccessResponseBody<GetTicketBookedResponse>.fromJson(
          ticketBookedUsers.data,
          (json) => GetTicketBookedResponse.fromJson(json),
        );
        if (response.success && response.data != null) {
          return Success(response.data!.mapToDomain());
        } else {
          return Failure(Exception(response.message));
        }
      case Failure():
        return Failure(ticketBookedUsers.error);
    }
  }

  @override
  Future<Result<List<EventInterestedUserDomainModel>>> fetchInterestedProfiles(
      int eventId) async {
    late String fetchInterestedUserEndpoint;
    var currentUserKey = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userRoleKey);

    var userRole = getUserTypeFromName(currentUserKey);
    switch (userRole) {
      case UsersType.USER:
        fetchInterestedUserEndpoint = "";
        break;
      case UsersType.ADMIN:
        fetchInterestedUserEndpoint =
            "/event/$eventId/manage/event-admin/interested-users";
        break;
      case UsersType.SUPER_ADMIN:
        fetchInterestedUserEndpoint =
            "/event/$eventId/manage/super-admin/interested-users";
        break;
    }

    final interestedProfilesResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: fetchInterestedUserEndpoint,
      passedQueryParameters: {"offset": 0},
    );

    switch (interestedProfilesResponse) {
      case Success():
        final response =
            UniversalSuccessResponseBody<GetInterestedUsersResponse>.fromJson(
          interestedProfilesResponse.data,
          (json) => GetInterestedUsersResponse.fromJson(json),
        );
        if (response.data != null && response.success) {
          return Success(response.data!.mapToDomain());
        } else {
          return Failure(Exception(response.message));
        }
      case Failure():
        return Failure(interestedProfilesResponse.error);
    }
  }

  @override
  Future<Result<List<AdminEventListDomainModel>>> getAllEvents() async {
    final allEventsResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/manage/super-admin",
    );

    switch (allEventsResponse) {
      case Success():
        final response =
            UniversalSuccessResponseBody<GetPublishedEventResponse>.fromJson(
          allEventsResponse.data,
          (json) => GetPublishedEventResponse.fromJson(json),
        );
        if (response.data != null && response.success) {
          final mappedResponse = response.data!.mapToDomain();
          if (mappedResponse.isNotEmpty) {
            return Success(mappedResponse);
          } else {
            return Failure(Exception("Response is Empty"));
          }
        } else {
          return Failure(Exception(response.message));
        }
      case Failure():
        return Failure(allEventsResponse.error);
    }
  }

  @override
  Future<Result<void>> rejectEvent(
      EventApproveOrRejectDomainModel rejectList) async {
    final requestBody = ApproveOrRejectRequestBody(
      approvals: [
        Approvals(
          eventId: int.parse(rejectList.eventId),
          isApproved: rejectList.isApproved,
        )
      ],
    );

    final approveRequestResponse = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.PUT,
        endpoint: "/event/manage/super-admin/approval",
        requestBody: requestBody.toJson());

    switch (approveRequestResponse) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(Exception("Something Went wrong"));
    }
  }

  @override
  Future<Result<List<AdminEventListDomainModel>>> getAllPublishEvents() async {
    final allEventsResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/manage/event-admin",
    );

    switch (allEventsResponse) {
      case Success():
        final response =
            UniversalSuccessResponseBody<GetPublishedEventResponse>.fromJson(
          allEventsResponse.data,
          (json) => GetPublishedEventResponse.fromJson(json),
        );
        if (response.success && response.data != null) {
          final mappedResponse = response.data!.mapToDomain();
          if (mappedResponse.isNotEmpty) {
            return Success(mappedResponse);
          } else {
            return Failure(Exception("Response is Empty"));
          }
        } else {
          return Failure(Exception(response.message));
        }

      case Failure():
        return Failure(
          allEventsResponse.error,
        );
    }
  }

  @override
  Future<UsersType> getCurrentUserType() async {
    final currentUser = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userRoleKey);
    return getUserTypeFromName(currentUser);
  }

  @override
  Future<PeopleCardModel?> getCurrentUserDetails() async {
    var currentUserId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    var currentUser = await profileDao.getProfileData(currentUserId);
    return currentUser?.mapToPeopleUiModel();
  }
}
