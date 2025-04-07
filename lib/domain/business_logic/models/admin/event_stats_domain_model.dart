import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

class EventStatsDomainModel {
  final String totalRevenue;
  final String totalTickets;
  final List<EventInterestedUserDomainModel> interestedUsers;
  final List<EventTicketBoughtDomainModel> ticketsBoughtUsers;

  EventStatsDomainModel(this.totalRevenue, this.totalTickets,
      this.interestedUsers, this.ticketsBoughtUsers);
}
