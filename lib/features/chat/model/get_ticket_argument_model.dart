import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';

class GetTicketArgumentModel {
  final String eventId;
  final String matchId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventInitialPrice;
  final String eventFinalPrice;
  final String dayLeftForEvent;
  final String eventLocation;
  final UserTicketHolderModel currentUser;
  final UserTicketHolderModel matchedUser;
  final String? eventBanner;

  GetTicketArgumentModel(
      {required this.eventId,
      required this.matchId,
      required this.eventName,
      required this.eventDate,
      required this.eventTime,
      required this.eventInitialPrice,
      required this.eventFinalPrice,
      required this.dayLeftForEvent,
      required this.eventLocation,
      required this.currentUser,
      required this.matchedUser,
      required this.eventBanner});
}