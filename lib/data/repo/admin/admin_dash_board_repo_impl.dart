import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/admin/approve_or_reject_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/admin/create_event_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/admin/admin_mappers.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_interested_users_response.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_published_event_response.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_ticket_booked_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AdminDashboardRepo)
class AdminDashBoardRepoImpl extends AdminDashboardRepo {
  final MyDioClient httpClient;

  AdminDashBoardRepoImpl(this.httpClient);

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

  /// TODO: MAKE USAGE OF THE CREATE EVENT REQUEST MODEL
  @override
  Future<Result<void>> createEvent(
    CreateEventRequestDomainModel createEventRequest,
  ) async {
    final event1 = CreateEventRequestBody(
      eventName: "Glint Tech Conference",
      isHotEvent: true,
      eventDescription: "A conference for tech enthusiasts.",
      eventLocationLongitude: -74.0060,
      eventLocationLatitude: 40.7128,
      createdTime: "2023-10-26T10:00:00Z",
      bookByTime: "2023-11-20T23:59:59Z",
      startTime: "2023-12-01T09:00:00Z",
      endTime: "2023-12-03T18:00:00Z",
      ticketPrice: 150,
      ticketsRemaining: 500,
      totalTickets: 1000,
      categoryList: ["Technology", "Conference", "Innovation"],
    );

    final createEventRequest = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/event/manage/event-admin/create",
      passedQueryParameters: event1.toJson(),
    );

    switch (createEventRequest) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(Exception("Something Went wrong"));
    }
  }

  @override
  Future<Result<void>> editEvent(
      CreateEventRequestDomainModel createEventRequest) async {
    final event1 = CreateEventRequestBody(
      eventName: "Glint Tech Conference",
      isHotEvent: true,
      eventDescription: "A conference for tech enthusiasts.",
      eventLocationLongitude: -74.0060,
      eventLocationLatitude: 40.7128,
      createdTime: "2023-10-26T10:00:00Z",
      bookByTime: "2023-11-20T23:59:59Z",
      startTime: "2023-12-01T09:00:00Z",
      endTime: "2023-12-03T18:00:00Z",
      ticketPrice: 150,
      ticketsRemaining: 500,
      totalTickets: 1000,
      categoryList: ["Technology", "Conference", "Innovation"],
    );

    final createEventRequest = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/event/manage/event-admin/edit",
      passedQueryParameters: event1.toJson(),
    );

    switch (createEventRequest) {
      case Success():
        return const Success(true);
      case Failure():
        return Failure(Exception("Something Went wrong"));
    }
  }

  /// TODO: HOW TO PASS THE QUERY PARAMETERS
  @override
  Future<Result<List<EventTicketBoughtDomainModel>>> fetchBookedTicketList(
    int eventId,
  ) async {
    final ticketBookedUsers = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "event/$eventId/manage/super-admin/booked-tickets",
    );

    switch (ticketBookedUsers) {
      case Success():
        final response =
            GetTicketBookedResponse.fromJson(ticketBookedUsers.data);
        return Success(response.mapToDomain());
      case Failure():
        return Failure(Exception("Something Went wrong"));
    }
  }

  @override
  Future<Result<List<EventInterestedUserDomainModel>>> fetchInterestedProfiles(
      int eventId) async {
    final interestedProfiles = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/event/$eventId/manage/super-admin/interested-users",
    );

    switch (interestedProfiles) {
      case Success():
        final response =
            GetInterestedUsersResponse.fromJson(interestedProfiles.data);
        return Success(response.mapToDomain());
      case Failure():
        return Failure(Exception("Something Went wrong"));
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
            GetPublishedEventResponse.fromJson(allEventsResponse.data);
        final mappedResponse = response.mapToDomain();
        if (mappedResponse.isNotEmpty) {
          return Success(mappedResponse);
        } else {
          return Failure(Exception("Response is Empty"));
        }
      case Failure():
        return Failure(Exception("Something Went wrong"));
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
            GetPublishedEventResponse.fromJson(allEventsResponse.data);
        final mappedResponse = response.mapToDomain();
        if (mappedResponse.isNotEmpty) {
          return Success(mappedResponse);
        } else {
          return Failure(Exception("Response is Empty"));
        }
      case Failure():
        return Failure(Exception("Something Went wrong"));
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
            "picture_$i",
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last, // or keep your custom name
            ),
          ),
        );
      }
    }

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "event/{$eventId}/content",
      uploadFilesFormData: formData,
    );

    switch (response) {
      case Success():
        // final storiesResponse = StoryUploadResponse.fromJson(response.data);
        // if (storiesResponse.filesUploaded?.isNotEmpty == true) {
        //   return const Success(true);
        // } else {
        //   return Failure(
        //     Exception(
        //         "Files ${storiesResponse.filesNotUploaded} failed to upload"),
        //   );
        // }
        return Success("File Uploaded successfully");
      case Failure():
        return Failure(
          Exception("Not able to upload files currently, please try again."),
        );
    }
  }
}
