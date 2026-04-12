import 'dart:io';

import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_stats_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class AdminDashboardRepo {
  /// ---------------------- SUPER ADMINS USE CASES ----------------------------- *
  Future<Result<void>> approveEvent(
      EventApproveOrRejectDomainModel approveList);

  Future<Result<void>> rejectEvent(EventApproveOrRejectDomainModel rejectList);

  Future<Result<List<AdminEventListDomainModel>>> getAllEvents();

  /// ---------------------- ADMINS USE CASES ----------------------------- *
  Future<Result<List<AdminEventListDomainModel>>> getAllPublishEvents();

  Future<Result<String>> uploadTempEventImages(List<File> images);

  Future<Result<void>> createEvent(
    CreateEventRequestDomainModel createEventRequest,
  );

  Future<Result<void>> editEvent(
    CreateEventRequestDomainModel createEventRequest,
  );

  Future<Result<void>> uploadEventMediaFiles(String eventId, List<File> event);

  Future<Result<void>> deleteEventContent(
    String eventId,
    List<String> pictureList,
    List<String> videoList,
  );

  Future<Result<void>> pauseEvent(String eventId);

  Future<Result<void>> unpauseEvent(String eventId);

  Future<Result<void>> deleteEvent(String eventId);

  Future<Result<EventStatsDomainModel>> getEventAdminStats(int eventId);

  /// ---------------------- COMMON [ADMINS, SUPER ADMINS] ----------------------------- *
  Future<Result<List<EventInterestedUserDomainModel>>> fetchInterestedProfiles(
      int eventId);

  Future<Result<List<EventTicketBoughtDomainModel>>> fetchBookedTicketList(
      int eventId);

  /// ---------------------- UTILS  ----------------------------- *
  Future<UsersType> getCurrentUserType();

  Future<PeopleCardModel?> getCurrentUserDetails();
}
