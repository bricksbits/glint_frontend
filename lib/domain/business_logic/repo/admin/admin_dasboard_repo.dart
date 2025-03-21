import 'dart:ffi';

import 'package:glint_frontend/data/remote/model/request/admin/update_event_request_body.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_detail_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/create_event_request.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class AdminDashboardRepo {
  Future<Result<EventListDomainModel>> getAllEvents();

  Future<Result<void>> createEvent(CreateEventRequest createEventRequest);

  Future<Result<void>> editEvent(UpdateEventRequestBody updateEventRequest);

  Future<Result<EventInterestedUserDomainModel>> fetchInterestedProfiles();

  Future<Result<EventTicketBoughtDomainModel>> fetchBookedTicketList(int eventId);

  Future<Result<void>> approveEvent(
      EventApproveOrRejectDomainModel approveList);

  Future<Result<void>> rejectEvent(EventApproveOrRejectDomainModel rejectList);

  Future<Result<AdminEventDetailDomainModel>> getEventDetailsForAdmin();
}
