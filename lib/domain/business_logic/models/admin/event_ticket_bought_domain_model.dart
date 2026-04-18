import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';

class EventTicketBoughtDomainModel {
  final EventInterestedUserDomainModel userOne;
  final EventInterestedUserDomainModel userTwo;
  final DateTime? bookedAt;

  EventTicketBoughtDomainModel({
    required this.userOne,
    required this.userTwo,
    this.bookedAt,
  });
}
