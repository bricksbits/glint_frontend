import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

class AdminEventDetailDomainModel {
  final String eventName;
  final String eventId;
  final String eventThumbnail;
  final String eventDate;
  final String eventLocation;
  final String eventMapLocation;
  final String eventBy;
  final AdminEventState eventState;
  final String interestedUsers;
  final String revenueGenerated;
  final List<EventInterestedUserDomainModel> interestedUserList;
  final List<EventTicketBoughtDomainModel> ticketsBoughtByList;

  AdminEventDetailDomainModel(
      this.eventName,
      this.eventId,
      this.eventThumbnail,
      this.eventDate,
      this.eventLocation,
      this.eventMapLocation,
      this.eventBy,
      this.eventState,
      this.interestedUsers,
      this.revenueGenerated,
      this.interestedUserList,
      this.ticketsBoughtByList);
}
