import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_detail_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class AdminDashboardRepo {
  Future<Result<List<AdminEventListDomainModel>>> getAllEvents();

  Future<Result<List<AdminEventListDomainModel>>> getAllPublishEvents();

  Future<Result<void>> createEvent(CreateEventRequestDomainModel createEventRequest);

  Future<Result<void>> editEvent(CreateEventRequestDomainModel createEventRequest);

  Future<Result<EventInterestedUserDomainModel>> fetchInterestedProfiles(int eventId);

  Future<Result<EventTicketBoughtDomainModel>> fetchBookedTicketList(int eventId);

  Future<Result<void>> approveEvent(
      EventApproveOrRejectDomainModel approveList);

  Future<Result<void>> rejectEvent(EventApproveOrRejectDomainModel rejectList);

  Future<Result<AdminEventDetailDomainModel>> getEventDetailsForAdmin();
}
