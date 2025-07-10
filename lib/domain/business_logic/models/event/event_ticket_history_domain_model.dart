import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';

class EventTicketHistoryDomainModel {
  final String eventId;
  final String eventName;
  final String eventCoverImageUrl;
  final String eventdate;
  final String eventTime;
  final String eventLocation;
  final String eventOldPrice;
  final String eventCurrentPrice;
  final String daysLeft;
  final Map<String, String> location;
  final UserTicketHolderModel currentUser;
  final UserTicketHolderModel matchedUser;

  EventTicketHistoryDomainModel(
      {required this.eventId,
      required this.eventName,
      required this.eventCoverImageUrl,
      required this.eventdate,
      required this.eventTime,
      required this.eventLocation,
      required this.eventOldPrice,
      required this.eventCurrentPrice,
      required this.daysLeft,
      required this.location,
      required this.currentUser,
      required this.matchedUser});
}