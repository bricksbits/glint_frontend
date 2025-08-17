import 'package:glint_frontend/design/components/admin/event_status_container.dart';

class AdminEventListDomainModel {
  final String eventName;
  final String eventId;
  final String eventThumbnail;
  final String eventDate;
  final String eventBy;
  final AdminEventState eventState;

  AdminEventListDomainModel({
    required this.eventName,
    required this.eventId,
    required this.eventThumbnail,
    required this.eventDate,
    required this.eventBy,
    this.eventState = AdminEventState.PENDING,
  });
}

enum AdminEventState {
  LIVE,
  PENDING,
  REJECTED,
  PAST_EVENT,
}

EventStatus convertToEventStatus(AdminEventState passedState) {
  late EventStatus status;
  switch (passedState) {
    case AdminEventState.LIVE:
      status = EventStatus.live;
      break;
    case AdminEventState.PENDING:
      status = EventStatus.inApproval;
      break;
    case AdminEventState.REJECTED:
      status = EventStatus.rejected;
      break;
    case AdminEventState.PAST_EVENT:
      status = EventStatus.pastEvent;
      break;
  }
  return status;
}
